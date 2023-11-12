import requests
import re

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

# Function to fetch names of workflow runs that are completed, in progress, or queued
def fetch_active_runs():
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/runs'
    response = requests.get(url, headers=headers)
    active_runs = set()

    if response.status_code == 200:
        for run in response.json()['workflow_runs']:
            if run['status'] in ['completed', 'in_progress', 'queued']:
                # Assuming the workflow run name includes the repository name
                name = run['name']
                active_runs.add(name)
    
    return active_runs

# Function to trigger the workflow
def trigger_workflow(user, repo, active_runs):
    # Check if the workflow run is already active for this repo
    if f'{user}/{repo}' in active_runs:
        print(f'Skipping {user}/{repo} as it was already queued')
        return

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

# Function to validate and extract user/repo from the GitHub URL
def validate_and_extract_github_url(url):
    match = github_url_pattern.match(url)
    if match:
        return match.groups()
    else:
        return None

# Fetch the names of active workflow runs
active_runs = fetch_active_runs()

# Main loop to run the workflow for each repository URL in the file
with open(github_repos_file, 'r') as file:
    for repo_url in file:
        repo_url = repo_url.strip()
        if repo_url:
            result = validate_and_extract_github_url(repo_url)
            if result:
                user, repo = result
                trigger_workflow(user, repo, active_runs)
            else:
                print(f'Invalid GitHub URL: {repo_url}')

# Ensure you replace 'YOUR_GITHUB_TOKEN' with your actual GitHub Personal Access Token
# Also ensure that the 'github_repos.txt' file exists and contains valid GitHub repository URLs.

