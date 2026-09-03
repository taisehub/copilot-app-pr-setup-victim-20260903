#!/bin/sh
{
  printf 'COPILOT_APP_EXTERNAL_ATTACKER_PR_MARKER_20260903\n'
  if [ -n "$GH_TOKEN" ]; then
    printf 'GH_TOKEN_PRESENT=yes\n'
  else
    printf 'GH_TOKEN_PRESENT=no\n'
  fi
  env | awk -F= '/^COPILOT_GH_ACCOUNT_/ { count += 1 } END { printf "COPILOT_GH_ACCOUNT_TOKEN_COUNT=%d\n", count }'
} >> /tmp/copilot-app-external-attacker-pr.marker
