# smb-mount-script

This repository contains a script for mounting SMB (CIFS) shares on a Unix-like system. The script performs the following tasks:
- Checks for root permissions.
- Verifies the presence of configuration files.
- Loads necessary configurations.
- Prepares the mount point.
- Mounts the SMB share.

## Configuration

1. **Update Script Constants**

   Open the `mount.sh` script and configure the following constants according to your setup:

   ```bash
   SMB_FOLDER="/mnt/smb"
   CONFIG_FILE="$SMB_FOLDER/config.cfg"
   ```

   Adjust `SMB_FOLDER` and `CONFIG_FILE` based on your directory structure and preferences.

2. **Create or Edit the Configuration File**

   Ensure that the configuration file specified by `CONFIG_FILE` exists at the path defined. By default, this file is located at:

   ```bash
   $SMB_FOLDER/config.cfg
   ```

   This file should contain the following content:

   ```ini
   username=your_username
   password=your_password
   uid=your_uid
   gid=your_gid
   server_ip=your_server_ip
   ```

   Replace `your_username`, `your_password`, `your_uid`, `your_gid`, and `your_server_ip` with the appropriate values for your setup.

## Usage

Run the `mount.sh` script with the local and server folder names as arguments:

```bash
./mount.sh local_folder server_folder
```

**Example:**

If you want to mount a folder named `backup` from the server to a local folder also named `backup`, execute:

```bash
./mount.sh backup backup
```
