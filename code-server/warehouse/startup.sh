#!/bin/bash
[[ -f /home/code/.homedir-initialized ]] || (
    echo "Remove this file to re-copy files from /etc/skel /opt/default_home at next container startup" > /home/code/.homedir-initialized
    shopt -s dotglob
    cp -r /etc/skel/* /home/code
    cp -r /opt/default_home/* /home/code
    shopt -u dotglob
    )
    # make workspace dir if it doesn't exist
[[ -d /home/code/workspace ]] || mkdir /home/code/workspace
# chown stuff to kube:kube
chown code:code /home/code -R
# generate env whitelist from su using.. a blacklist, pretty much.
env_whitelist=$(env | cut -d = -f 1 | grep -v -e HOSTNAME -e PWD -e HOME -e TERM -e SHLVL -e LC_ALL -e ^_$ | tr "\n" "," | head -c -1)
# configure kubectl so vscode's kubernetes extension works
# su code --login -w "$env_whitelist" -c "/usr/local/bin/generate-kubeconfig.sh"
# start code-server
# su code --login -w "$env_whitelist" -c "/usr/bin/code-server --bind-addr 0.0.0.0:8080 /home/code/workspace" # --enable-proposed-api [\"ms-vsliveshare.vsliveshare\",\"ms-vscode.node-debug\",\"ms-vscode.node-debug2\"]
runuser code --login -w "$env_whitelist" -c "/usr/bin/code-server --bind-addr 0.0.0.0:8080 /home/code/workspace" # --enable-proposed-api [\"ms-vsliveshare.vsliveshare\",\"ms-vscode.node-debug\",\"ms-vscode.node-debug2\"]

/bin/bash /tools.sh;