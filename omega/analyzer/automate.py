import requests
import re
import argparse
import time
import os

GITHUB_TOKEN = 'YOUR_GITHUB_TOKEN'
github_repos_file = 'github_repos.txt'
results_dir = '/YOUR/DIR/workflow_results'

headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': f'Bearer {GITHUB_TOKEN}',
}

github_url_pattern = re.compile(r'^https?://github\.com/([\w-]+)/([\w-]+)$')

parser = argparse.ArgumentParser(description="Trigger and manage GitHub workflows for repositories")
parser.add_argument("-l", "--limit", type=int, default=0, help="Limit the number of repositories to process (0 for no limit)")
args = parser.parse_args()

# Function to wait for workflow completion
#def wait_for_workflow_completion(user, repo):
#    print(f'Waiting for workflow completion for {user}/{repo}...')
#    while True:
#        url = 'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs'
#        response = requests.get(url, headers=headers)
#        if response.status_code == 200:
#            runs = response.json()['workflow_runs']
#            for run in runs:
#                if run['status'] == 'completed' and run['name'] == f'{user}/{repo}':
#                    return run['id']
#        time.sleep(60)  # Wait for 60 seconds before checking again

def num_of_queued_wf_runs():
    url = 'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs'
    response = requests.get(url, headers=headers, params={'status': 'queued'})
    if response.status_code == 200:
        return response.json()['total_count']
    return -1

# Download artifacts of successful workflow runs
def download_results():
    url = 'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs'
    response = requests.get(url, headers=headers, params={'status': 'success'})
    if response.status_code == 200:
        runs = response.json()['workflow_runs']
        for run in runs:
            run_id = run['id']
            download_artifact(run_id)
            delete_workflow_run(run_id)

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
        with open(f'{results_dir}/{artifact["name"]}.zip', 'wb') as file:
            file.write(download_response.content)
        return artifact['id']
    else:
        print('Failed to download artifact.')

# Function to delete artifact
def delete_artifact(artifact_id):
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/artifacts/{artifact_id}'
    response = requests.delete(url, headers=headers)
    if response.status_code == 204:
        print(f'Deleted artifact {artifact_id} successfully.')

# Function to delete workflow run
def delete_workflow_run(run_id):
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs/{run_id}'
    response = requests.delete(url, headers=headers)
    if response.status_code == 204:
        print(f'Deleted workflow run {run_id} successfully.')

def delete_all_runs():
    url = 'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs'
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        runs = response.json()['workflow_runs']
        for run in runs:
            run_id = run['id']
            delete_workflow_run(run_id)

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

def get_github_repos():
    with open(github_repos_file, 'r') as file:
        for repo_url in file:
            repo_url = repo_url.strip()
            if not repo_url:
                continue
            result = validate_and_extract_github_url(repo_url)
            if not result:
                print(f'Invalid GitHub URL: {repo_url}')
                continue
            user, repo = result
            if os.path.exists(f'{results_dir}/results-{user}-{repo}.zip'):
                print(f'Skipped {user}/{repo}: result already exists')
                continue
            yield user, repo

# Main loop to run the workflow for each repository URL in the file
github_repos = get_github_repos()
while True:
    download_results()
    nr_queued = num_of_queued_wf_runs()
    if nr_queued != -1 and nr_queued < 1:
        try:
            user, repo = next(github_repos)
            trigger_workflow(user, repo)
        except StopIteration:
            pass
    time.sleep(60)  # Wait for 60 seconds before checking again

#count = 0
#with open(github_repos_file, 'r') as file:
#    for repo_url in file:
#        if args.limit > 0 and count >= args.limit:
#            break
