#!/usr/bin/env bash

#
# Utils
#

echo_clear() {
    echo -ne "\033[1A\r\033[K"
}

echo_ok() {
    echo -e "\033[0;32m✓\033[0;0m $1"
}

echo_wait() {
    echo -e "* \033[0;33m$1\033[0;0m"
}

echo_error() {
    echo -e "\033[0;31m!\033[0;0m $1"
}

xcode_setup() {
    echo_wait 'Determining Xcode status. You may need to enter root password...'
    if ! xcode-select --install 2>/dev/null; then
        echo_ok 'Xcode has been successfully setup.'
    echo_ok 'Please make sure to run sudo xcodebuild -license'
    fi
}

brew_setup() {
    if hash brew 2>/dev/null; then
        echo_ok 'Homebrew is already installed.'
    else
        echo_wait 'Homebrew is not installed. Installing...'
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

setenv() {
    export PATH=/opt/homebrew/bin:$PATH
}

ansible_bootstrap() {
    if hash ansible-playbook 2>/dev/null; then
        echo_ok 'Ansible is already installed.'
    else
        echo_wait 'Ansible is not installed. Installing...'
        brew install ansible
    fi
}

ansible_run() {
    echo_wait 'Running Ansible playbook. This will take a while.'
    if ! ansible-playbook provision/local.yml -K -i provision/hosts; then
        echo_error 'Ansible playbook exited with an error.'
        exit 1
    fi
}

cask_update() {
    echo_wait 'Cask appears to be installed. Checking for updates...'
    outdated_casks=()

    while read -ra cask_info; do
        outdated_casks+=(${cask_info[0]})
    done <<< "$(brew outdated --cask --quiet)"

    echo -ne "\r\n"
    echo_clear

    if [ ${#outdated_casks[@]} == 0 ]; then
        echo_ok 'Casks are up-to-date.'
    else
        echo_wait "Updating casks: \033[1;30m${outdated_casks[*]}"
        brew install --cask --force "${outdated_casks[@]}"
    fi
}

cleanup() {
    echo_wait 'Cleaning up...'
    rm "$HOME"/.homebrew_analytics_user_uuid >/dev/null 2>&1
    brew cleanup
}

bootstrap_macos() {
    xcode_setup
    brew_setup
    setenv
    ansible_bootstrap
    ansible_run
    cask_update
    cleanup
}

bootstrap_macos
