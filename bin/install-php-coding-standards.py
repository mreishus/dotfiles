#!/usr/bin/env python
from shutil import which, copyfile
import subprocess
import json
import os
import re
import datetime
from typing import List

## Version: 0.1
COMMAND_LOG = "/tmp/composer.log.txt"

def clear_log_file():
    file = open(COMMAND_LOG,"w")
    file.close()

def sandbox_warning():
    print("==> Sandbox warning")
    print("This script isn't designed to run on a sandbox. ")
    print(" ")
    print("In my testing, after running it on a sandbox, ")
    print("~/.config/composer/vendor/bin/phpcs works correctly, but ")
    print("/home/wpcom/public_html/bin/phpcs cannot find the WordPress standard. ")
    print("Unless you modify your PATH, the default 'phpcs' will be the broken one. ")
    print(" ")
    print("I don't recommend running this on a sandbox unless you wish to help debug/fix. ")
    print(" ")
    if not input("Do you wish to continue? (y/n): ").lower().strip()[:1] == "y":
        exit()

def composer_check():
    print("")
    print("==> Checking for composer")
    if which('composer'):
        print("[+] composer installed")
    else:
        print("[-] composer missing")
        print("arch linux, try: sudo pacman -Syu composer")
        print("mac os x, try: brew install composer")
        print("mac os x, or try: https://getcomposer.org/download/")
        exit()

def phpcs_check():
    print("")
    print("==> Checking for phpcs")
    if which('phpcs'):
        print("[+] phpcs installed")
    else:
        print("[-] phpcs missing")
        print("")
        print("install phpcs: try:")
        print("composer global require \"squizlabs/php_codesniffer=*\"\n")
        print("then add ~/.config/composer/vendor/bin/ to your path. for bash, try:")
        print('echo $"export PATH=\$PATH:~/.config/composer/vendor/bin/" >> ~/.bash_profile')
        print("\nfor fish, try:")
        print('set -Ua fish_user_paths ~/.config/composer/vendor/bin/')
        exit()

def backup_global_composer_config():
    home = os.path.expanduser("~")
    file = home + "/.config/composer/composer.json"
    if not os.path.isfile(file):
        return

    dt = datetime.datetime.now().strftime("%Y-%m-%d--%H-%M-%S")
    file_bak = file + f".bak.{dt}"
    copyfile(file, file_bak)
    print(f"==> Made backup {file} -> {file_bak}")

def install_standards():
    print("")
    print("==> Installing open source coding standards")
    commands = [
        "composer global config minimum-stability dev",
        "composer global config prefer-stable true",
        "composer global require --dev dealerdirect/phpcodesniffer-composer-installer",
        ##"composer global require --dev phpcsstandards/phpcsextra:1.0.0-alpha3",
        ##"composer global require --dev phpcsstandards/phpcsutils:1.0.0-alpha3",
        "composer global require --dev phpcsstandards/phpcsextra",
        "composer global require --dev phpcsstandards/phpcsutils",
        # "composer global require --dev wp-coding-standards/wpcs",
        #"composer global require --dev sirbrillig/phpcs-no-get-current-user",
        ##"composer global require --dev sirbrillig/phpcs-variable-analysis:v3.0.0-beta.6",
        # "composer global require --dev sirbrillig/phpcs-variable-analysis",
    ]
    for command in commands:
        run_command_to_console(command)

def run_command_to_console(command, do_split=True) -> subprocess.CompletedProcess:
    with open(COMMAND_LOG, "a") as log_file:
        print('')
        print("===== Running: =====")
        ## Write to console
        print(command)

        ## Write to file
        if do_split:
            log_file.write(command + "\n")
        else:
            log_file.write(" ".join(command) + "\n")

        print("====================")
        print('')
        parts = []
        if do_split:
            parts = command.split()
        else:
            parts = command
        os.environ['SYSTEMD_COLORS'] = '1'
        result = subprocess.run(parts, stdout=subprocess.PIPE)
        print(result.stdout.decode('utf-8'))
        return result

def install_wpcom_standards():
    cs_dir = get_wpcom_cs_dir()
    print("")
    print("==> Installing wpcom coding standards")
    if not os.path.isdir(cs_dir):
        print(f"Could not find directory [{cs_dir}] on disk. Exiting...")
        exit()
    subfolders = [ f.path for f in os.scandir(cs_dir) if f.is_dir() ]
    for subfolder_full in subfolders:
        install_a_wpcom_standard(subfolder_full)

def full_path_to_part(full: str) -> str:
    """ Given a full directory name, like "/var/lib/mysql", return the last part, like "mysql" """
    return os.path.basename(os.path.normpath(full))

def install_a_wpcom_standard(subfolder_full: str):
    if not os.path.isdir(subfolder_full):
        print(f"Could not find directory [{subfolder_full}] on disk. Exiting...")
        exit()
    subfolder_part = full_path_to_part(subfolder_full)
    print("")
    print(f"=> Installing {subfolder_part}")

    command = f"composer global config repositories.{subfolder_part} path {subfolder_full}"
    run_command_to_console(command)

    print(f"Looking for a package name for {subfolder_part}.. ", end="")
    package_name = get_composer_package_name(subfolder_full)
    if package_name is None:
        print(" Unable to find.")
        add_installed_path(subfolder_full)
    else:
        print(" Found.")
        print(f"=> Composer requiring {package_name}..")
        result = run_command_to_console(f"composer global require --dev {package_name}=*")
        if result.returncode > 0:
            print(f"!!! Error composer requiring {package_name}.  Manually adding path instead..")
            add_installed_path(subfolder_full)

def add_installed_path(subfolder_full: str):
    paths = get_installed_paths()
    if subfolder_full in paths:
        print(f"Already in path: {full_path_to_part(subfolder_full)}.")
    else:
        print(f"> Adding to path: {full_path_to_part(subfolder_full)}.")
        paths.append(subfolder_full)
        set_installed_paths(paths)


def get_installed_paths() -> List[str]:
    output = subprocess.check_output(['phpcs', '--config-show']).decode('utf-8')
    finder = re.compile('installed_paths: (.*?)\n')
    matches = finder.findall(output)
    if len(matches) == 0:
        print("Couldn't find phpcs installed paths..")
        exit()
    return matches[0].split(',')

def set_installed_paths(paths: List[str]):
    # Remove empty strings
    paths = [p for p in paths if p]
    path_str = ",".join(paths)
    run_command_to_console(["phpcs", "--config-set", "installed_paths", path_str], do_split=False)

def get_composer_package_name(subfolder_full):
    file = subfolder_full + "/composer.json"
    if not os.path.isfile(file):
        return None

    composer_str = ''
    with open(file, 'r') as file:
        composer_str = file.read()

    composer_data = json.loads(composer_str)
    if "name" in composer_data:
        return composer_data['name']
    return None

def get_wpcom_cs_dir():
    cs_dir = ""

    print("")
    print("==> Searching homedir for phpcs-coding-standards in wpcom")
    home = os.path.expanduser("~")
    command = f"find {home} -type d -regex .*bin/metrics/shared/phpcs-coding-standards"
    parts = command.split()
    result = subprocess.run(parts, stdout=subprocess.PIPE)
    candidates = result.stdout.decode('utf-8').split()

    if len(candidates) > 1:
        print("Found multiple candidates:")
        for cand in candidates:
            print(cand)
        print("Please paste which full path you would like to use: ")
        cs_dir = input('--> ')
    elif len(candidates) == 1:
        cs_dir = candidates[0]
    else:
        print("Error: Couldn't find wpcom with phpcs-coding-standards in ~...")
        exit()

    return cs_dir

def update_reminder():
    print("==> Update reminder")
    print("To update composer in the future, run: ")
    print("composer global update")
    print("")

def list_installed_standards():
    print("Checking installed standards.. [phpcs -i]")
    output = subprocess.check_output(['phpcs', '-i']).decode('utf-8')
    finder = re.compile('The installed coding standards are (.*)$')
    matches = finder.findall(output)
    if len(matches) == 0:
        print("Couldn't find any.")

    l = re.split(r'\s*,\s*|\s+and\s+', matches[0])
    print('')
    for standard in sorted(l):
        print(standard.strip())
    print('')

if __name__ == "__main__":
    print("install-php-coding-standards.py: Helping you install php coding standards for working on WPCOM.")
    clear_log_file()
    sandbox_warning()
    composer_check()
    phpcs_check()
    backup_global_composer_config()
    install_standards()
    install_wpcom_standards()
    update_reminder()
    list_installed_standards()
    print("Finished!")
