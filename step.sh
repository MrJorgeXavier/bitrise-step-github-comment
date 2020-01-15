#!/bin/bash
set -ex

function install_jq () {
    apt-get update
    apt-get install -y curl jq
}

if ! [ -x "$(command -v jq)" ] 
then
    echo "jq json parser is not installed, installing..."
    install_jq
else
    echo "jq json parser already installed, continuing..."
fi

# $GITHUB_TOKEN 
# $GITHUB_BRANCH
# $GITHUB_OWNER
# $GITHUB_REPO
# $GITHUB_ENVIRONMENT
# $GITHUB_TARGET_URL



requestHeader="Content-Type: application/json -H Authorization: token ${github_token}"

#MARK: DEPLOY REQUEST
createDeploymentRequestUrl="https://api.github.com/repos/${github_owner}/${github_repo}/deployments"

createDeploymentData=$(echo '{"ref": '\"${github_branch}\"', "description": "Deploying", "payload": ""}')

createDeploymentResult=$(curl -d '{"ref": '\"${github_branch}\"', "description": "Deploying", "payload": ""}' -H "Content-Type: application/json" -H "Authorization: token ${github_token}" -X POST $createDeploymentRequestUrl)

deploymentId=$(echo $createDeploymentResult | jq '.id')

echo "deployment request: $createDeploymentResult"


#MARK: STATUS REQUEST
createStatusRequestUrl="https://api.github.com/repos/${github_owner}/${github_repo}/deployments/$deploymentId/statuses"

createStatusData=$(echo '{"environment": '\"${github_environment}\"',"state": "success", "target_url": '\"${github_target_url}\"', "description": "Deployment test finish"}')

createStatusResult=$(curl -d $createStatusData -H $requestHeader -X POST $createStatusRequestUrl)

echo "status request: $createStatusResult"