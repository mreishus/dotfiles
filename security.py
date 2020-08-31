#!/usr/bin/env python
from shutil import which
import os

progs_with_instructions = {
    "gobuster": "go get github.com/OJ/gobuster",
    "wfuzz": "yay -Syu wfuzz",
    "burpsuite": "yay -Syu burpsuite",
    "nmap": "yay -Syu nmap",
    "fzf": "yay -Syu fzf",
    "rg": "yay -Syu rg",
    "nc": "yay -Syu gnu-netcat",
}
directories_with_instructions = {
    "/opt/seclists": "git clone --depth 1 https://github.com/danielmiessler/SecLists.git /opt/seclists" + "\nPossibly delete .git after to speed up shells",
    "/opt/privilege-escalation-awesome-scripts-suite": "git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite /opt/privilege-escalation-awesome-scripts-suite"
}
if __name__ == "__main__":
    for prog, instructions in progs_with_instructions.items():
        if which(prog) is not None:
            print(f"[+] {prog}")
        else:
            print(f"[-] MISSING: {prog}")
            print("    " + instructions)

    for d, instructions in directories_with_instructions.items():
        if os.path.isdir(d):
            print(f"[+] {d}")
        else:
            print(f"[-] MISSING: {d}")
            for line in instructions.split("\n"):
                print("    " + line)
