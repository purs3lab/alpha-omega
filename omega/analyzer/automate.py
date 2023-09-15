import os
import argparse


def main():
    parser = argparse.ArgumentParser(
        prog="python ./automate.py",
        description="Automatically run the Omega Analyzer on a list of repositories"
    )
    parser.add_argument("-i", "--input", default="list.txt", help="input file (default list.txt)")
    parser.add_argument("-f", "--force", action="store_true", help="overwrite previous analysis")
    args = parser.parse_args()

    with open(args.input, "r") as f:
        lines = f.readlines()
        for i in range(len(lines)):
            line = lines[i]
            if "github" not in line:
                print(line + " is not a github repository")
                with open("failed.txt", "a") as failed_list:
                    failed_list.write(line + "\n")
                continue

            user, repo = line.split("/")[-2:]

            if not args.force and not os.system("test -d ./results/" + user + "/" + repo):
                print(f'[{i + 1}/{len(lines)}] Skipping {user}/{repo} (Already exists)')
                continue

            print(f'[{i + 1}/{len(lines)}] Analyzing {user}/{repo}...')
            rc = os.system(
                f'docker run --rm -it -v ./results:/opt/export/github openssf/omega-toolshed:latest {user} {repo}'
            )
            if rc:
                print("Analyzer exited with code 1. Exiting script...")
                return


if __name__ == "__main__":
    main()
