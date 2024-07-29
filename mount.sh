#!/bin/bash

SMB_FOLDER="/mnt/smb"
CONFIG_FILE="$SMB_FOLDER/config.cfg"

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run as root."
        exit 1
    fi
}

check_files() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "File not found: $CONFIG_FILE"
        exit 1
    fi
}

load_configurations() {
    source "$CONFIG_FILE"

    local required_vars=(username password uid gid server_ip)
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            echo "Required variable $var not found in $CONFIG_FILE."
            exit 1
        fi
    done
}

prepare_mount_point() {
    local mount_point="$1"
    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
    fi
    chmod -R 777 "$mount_point"
    echo "Full permission granted for $mount_point"
}

mount_smb_share() {
    local server="$1"
    local mount_point="$2"
    mount -t cifs "//$server" "$mount_point" -o username="$username",password="$password",uid="$uid",gid="$gid"
    if [ $? -eq 0 ]; then
        echo "SMB share successfully mounted at $mount_point"
    else
        echo "Error mounting SMB share"
        exit 1
    fi
}

main() {
    local local_folder="$1"
    local server_folder="$2"

    check_root
    check_files
    load_configurations

    local server_mount_point="$server_ip/$server_folder"
    local local_mount_point="$SMB_FOLDER/$local_folder"

    prepare_mount_point "$local_mount_point"
    mount_smb_share "$server_mount_point" "$local_mount_point"
}

main "$1" "$2"

