import requests
import re

# Replace this with your GitHub token
GITHUB_TOKEN = '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'

# Path to your file containing GitHub repository URLs
github_repos_file = 'github_repos.txt'

# Header for authentication
headers = {
    'Accept': 'application/vnd.github+json',
    'Authorization': f'Bearer {GITHUB_TOKEN}',
}

# GitHub URL pattern for validation, allowing both http and https
github_url_pattern = re.compile(r'^https?://github\.com/([\w-]+)/([\w-]+)$')

# Function to trigger the workflow
def trigger_workflow(user, repo):
    # URL to trigger the workflow dispatch event
    url = f'https://api.github.com/repos/purs3lab/alpha-omega/actions/workflows/omega_analyzer_pull.yml/dispatches'

    # Payload with inputs
    data = {
        'ref': 'main',  # or the branch you want to dispatch on
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

# Main loop to run the workflow for each repository URL in the file
with open(github_repos_file, 'r') as file:
    for repo_url in file:
        repo_url = repo_url.strip()
        if repo_url:
            result = validate_and_extract_github_url(repo_url)
            if result:
                user, repo = result
                trigger_workflow(user, repo)
            else:
                print(f'Invalid GitHub URL: {repo_url}')

# Ensure you replace 'YOUR_GITHUB_TOKEN' with your actual GitHub Personal Access Token
# Also ensure that the 'github_repos.txt' file exists and contains valid GitHub repository URLs.

