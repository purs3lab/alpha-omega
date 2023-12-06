import requests
import re
import argparse
import time

GITHUB_TOKEN = 'YOUR_GITHUB_TOKEN'
github_repos_file = 'github_repos.txt'

headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': f'Bearer {GITHUB_TOKEN}',
}

github_url_pattern = re.compile(r'^https?://github\.com/([\w-]+)/([\w-]+)$')

parser = argparse.ArgumentParser(description="Trigger and manage GitHub workflows for repositories")
parser.add_argument("-l", "--limit", type=int, default=0, help="Limit the number of repositories to process (0 for no limit)")
args = parser.parse_args()

# Function to wait for workflow completion
def wait_for_workflow_completion(user, repo):
    print(f'Waiting for workflow completion for {user}/{repo}...')
    while True:
        url = 'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs'
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            runs = response.json()['workflow_runs']
            for run in runs:
                if run['status'] == 'completed' and run['name'] == f'{user}/{repo}':
                    return run['id']
        time.sleep(60)  # Wait for 60 seconds before checking again

# Function to download workflow artifact
def download_artifact(run_id):
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs/{run_id}/artifacts'
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        artifacts = response.json()['artifacts']
        if artifacts:
            artifact = artifacts[0]
        else:
            print('No artifacts found.')
            return
        download_url = artifact['archive_download_url']
        print(f'Downloading artifact from {download_url}')
        download_response = requests.get(download_url, headers=headers)
        with open(f'./workflow_results/{artifact["name"]}.zip', 'wb') as file:
            file.write(download_response.content)
        return artifact['id']
    else:
        print('Failed to download artifact.')

# Function to delete workflow run
def delete_artifact(artifact_id):
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/artifacts/{artifact_id}'
    response = requests.delete(url, headers=headers)
    if response.status_code == 204:
        print(f'Deleted workflow run {run_id} successfully.')

# Function to trigger the workflow
def trigger_workflow(user, repo):
    url = 'https://api.github.com/repos/purs3lab/alpha-omega/actions/workflows/omega_analyzer_pull.yml/dispatches'
    data = {'ref': 'main',
            'inputs': {
                'user': user,
                'repository': repo
                }
            }
    response = requests.post(url, headers=headers, json=data)
    if response.status_code == 204:
        print(f'Workflow dispatched for {user}/{repo} successfully.')
        return True
    else:
        print(f'Failed to dispatch workflow for {user}/{repo}. Response: {response.status_code} - {response.text}')
        return False

# Function to validate and extract user/repo from the GitHub URL
def validate_and_extract_github_url(url):
    match = github_url_pattern.match(url)
    return match.groups() if match else None

# Main loop to run the workflow for each repository URL in the file
count = 0
with open(github_repos_file, 'r') as file:
    for repo_url in file:
        if args.limit > 0 and count >= args.limit:
            break

        repo_url = repo_url.strip()
        if repo_url:
            result = validate_and_extract_github_url(repo_url)
            if result:
                user, repo = result
                if trigger_workflow(user, repo):
                    run_id = wait_for_workflow_completion(user, repo)
                    artifact_id = download_artifact(run_id)
                    if artifact_id:
                        delete_artifact(artifact_id)
                    count += 1
            else:
                print(f'Invalid GitHub URL: {repo_url}')

