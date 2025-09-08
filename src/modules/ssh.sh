
# SSH Monitoring Module for EDITH
check_ssh() {
  local line="$1"

  # Count failed password attempts (common brute-force signature)
  if echo "$line" | grep -q "Failed password"; then
    ((ssh_fail_count++))
    # Log the offending IP
    local ip=$(echo "$line" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
    echo "$(date) - SSH Fail from $ip. Total this minute: $ssh_fail_count" >> "$LOG_FILE"

    # Check if we're in a spike
    if [[ $ssh_fail_count -ge $SSH_FAIL_THRESHOLD ]]; then
      alert="SSH Brute-Force Attack detected from $ip. $ssh_fail_count failures per minute."
      # Execute the alert command defined in config
      eval "$(printf "$ALERT_CMD" "$alert")"
      # Optionally, trigger a blocking rule (Advanced!)
      # iptables -I INPUT -s "$ip" -j DROP
    fi
  fi

  # Detect successful login after failures (potential breach)
  if echo "$line" | grep -q "Accepted password" && [[ $ssh_fail_count -ge $SSH_SUCCESS_AFTER_FAIL ]]; then
    local user=$(echo "$line" | grep -oE 'for .* from' | awk '{print $2}')
    local ip=$(echo "$line" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
    alert="SUCCESSFUL SSH LOGIN AFTER FAILURES! User '$user' from $ip."
    eval "$(printf "$ALERT_CMD" "$alert")"
  fi

  # Reset counter every minute using a background process
  # This is a non-blocking way to handle timing
  (sleep 60 && ssh_fail_count=0) &
}
