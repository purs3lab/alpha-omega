import requests
import re
import argparse

# Replace this with your GitHub token
GITHUB_TOKEN = 'YOUR_GITHUB_TOKEN'

# Path to your file containing GitHub repository URLs
github_repos_file = 'github_repos.txt'

# Header for authentication
headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': f'Bearer {GITHUB_TOKEN}',
}

# GitHub URL pattern for validation, allowing both http and https
github_url_pattern = re.compile(r'^https?://github\.com/([\w-]+)/([\w-]+)$')

# Set up command-line argument parsing
parser = argparse.ArgumentParser(description="Trigger GitHub workflows for repositories")
parser.add_argument("-f", "--force", action="store_true", help="Force re-analysis of repositories")
parser.add_argument("-l", "--limit", type=int, default=0, help="Limit the number of repositories to queue (0 for no limit)")
args = parser.parse_args()

# Function to fetch names of workflow runs that are completed, in progress, or queued
def fetch_active_runs():
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs'
    response = requests.get(url, headers=headers)
    active_runs = set()

    if response.status_code == 200:
        for run in response.json()['workflow_runs']:
            if run['status'] in ['completed', 'in_progress', 'queued']:
                if run['status'] == 'completed' and run['conclusion'] != 'success':
                    continue
                # Assuming the workflow run name includes the repository name
                name = run['name']
                active_runs.add(name)
    
    return active_runs

# Function to trigger the workflow
def trigger_workflow(user, repo, active_runs, force=False):
    # Check if the workflow run is already active for this repo
    if not force and f'{user}/{repo}' in active_runs:
        print(f'Skipping {user}/{repo} as it was already queued')
        return False

    # URL to trigger the workflow dispatch event
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/workflows/omega_analyzer_pull.yml/dispatches'

    # Payload with inputs
    data = {
        'ref': 'main',
        'inputs': {
            'user': user,
            'repository': repo
        }
    }

    # Post request to trigger the workflow
    response = requests.post(url, headers=headers, json=data)
    
    if response.status_code == 204:
        print(f'Workflow dispatched for {user}/{repo} successfully.')
    else:
        print(f'Failed to dispatch workflow for {user}/{repo}. Response: {response.status_code} - {response.text}')
    return True

# Function to validate and extract user/repo from the GitHub URL
def validate_and_extract_github_url(url):
    match = github_url_pattern.match(url)
    if match:
        return match.groups()
    else:
        return None

# Main loop to run the workflow for each repository URL in the file
active_runs = fetch_active_runs() if not args.force else set()

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
                count += trigger_workflow(user, repo, active_runs, args.force)
            else:
                print(f'Invalid GitHub URL: {repo_url}')

# Ensure you replace 'YOUR_GITHUB_TOKEN' with your actual GitHub Personal Access Token
# Also ensure that the 'github_repos.txt' file exists and contains valid GitHub repository URLs.

