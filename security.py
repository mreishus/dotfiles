#!/usr/bin/env python
from shutil import which
import os

progs_with_instructions = {
    "gobuster": "go get github.com/OJ/gobuster",
    "wfuzz": "yay -Syu wfuzz",
    "burpsuite": "yay -Syu burpsuite",
    "nmap": "yay -Syu nmap\nAlso install python2? Lots of scripts fail, not sure",
    "fzf": "yay -Syu fzf",
    "rg": "yay -Syu rg",
    "nc": "yay -Syu gnu-netcat",
    "openvpn": "yay -Syu openvpn",
    "searchsploit": "git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb\nln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit",
    "msfdb": "yay -Syu metasploit\nThen set up postgres and make a DB by checking the arch wiki for both metasploit and postgres. (Not that hard, come on)",
    "hydra": "yay -Syu hydra",
    "arp": "yay -Syu net-tools",
    "sqlmap": "yay -Syu sqlmap",
    "smbexec.py": "yay -Syu impacket",
    "amass": "yay -Syu amass",
    "sublister": "yay -Syu sublist3r-git",
    "whatweb": "yay -Syu ruby-bundler\nhttps://github.com/urbanadventurer/WhatWeb/releases\nDownload, untar, sudo make install",
    "zaproxy": "yay -Syu zaproxy (or zaproxy-weekly)",
}
directories_with_instructions = {
    "/opt/seclists": "git clone --depth 1 https://github.com/danielmiessler/SecLists.git /opt/seclists"
    + "\nPossibly delete .git after to speed up shells",
    "/opt/privilege-escalation-awesome-scripts-suite": "git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite /opt/privilege-escalation-awesome-scripts-suite",
}
if __name__ == "__main__":
    for prog, instructions in progs_with_instructions.items():
        if which(prog) is not None:
            print(f"[+] {prog}")
        else:
            print(f"[-] MISSING: {prog}")
            for line in instructions.split("\n"):
                print("    " + line)

    for d, instructions in directories_with_instructions.items():
        if os.path.isdir(d):
            print(f"[+] {d}")
        else:
            print(f"[-] MISSING: {d}")
            for line in instructions.split("\n"):
                print("    " + line)
