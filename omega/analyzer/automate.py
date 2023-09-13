import os

def analyze():
    with open("list.txt", "r") as f:
        lines = f.readlines()
        for i in range(len(lines)):
            line = lines[i]
            if "github" not in line:
                print(line + " is not a github repository")
                with open("failed.txt", "a") as failed_list:
                    failed_list.write(line + "\n")
                continue

            user, repo = line.split("/")[-2:]

            if not os.system("test -d ./results/" + user + "/" + repo):
                print(f'[{i + 1}/{len(lines)}] Skipping {user}/{repo} (Already exists)')
                continue

            print(f'[{i + 1}/{len(lines)}] Analyzing {user}/{repo}...')
            rc = os.system(f'docker run --rm -it -v ./results:/opt/export/github openssf/omega-toolshed:0.8.6-2 {user} {repo}')
            if rc:
                print("Analyzer exited with code 1. Exiting script...")
                return


if __name__ == "__main__":
    analyze()

