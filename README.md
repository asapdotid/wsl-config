# Windows 10 Pro - WSL Ubuntu for Web Server

> **LEMP Stack** + **Node Js**

> All service installation from PPA Launchpad [Link](https://launchpad.net/ubuntu)

## Before run all file bash script

you can mount windows drive to WSL which create wsl config on etc

```sudo vim /etc/wsl.conf```

add this config:

```
# Enable extra metadata options by default
[automount]
enabled = true
root = /
options = "metadata,umask=22,fmask=11"
mountFsTab = false

# Enable DNS – even though these are turned on by default, we’ll specify here just to be explicit.
[network]
generateHosts = true
generateResolvConf = true
```

save it `:wq` and restart WSL (open PowerShell as Administrator) then execute below this

```
Get-Service LxssManager | Restart-Service
```

![Restart WSL](./images/wsl-powershell-restart-wsl.jpg "Restart WSL from PowerShell as Administrator")

You can check that drive show on wsl:

`ls -al /c/` or `ls -al /d/`

than you can link (Win10) project directory to (WSL) home directory etc:

`ln -s /d/projects ~/.`

![Restart WSL](./images/wsl-list-home-dir.jpg "Show list home directory WSL")

next

```
sudo apt update && sudo apt upgrade -y
```

download it and the chmod command sets the all file with .sh extention

> cd wsl-web-config

```find . -type f -iname "*.sh" -exec chmod +x {} \;```

next you can running every setup file, example:

`./install-php-fpm-on-wsl.sh` or `./install-nginx-on-wsl.sh`

> note: You can choose what MySQL do you use 5 or 8 up to you, just select one.

you can check manual.

### Add correct permission files and directory optional (Laravel storage & boostrap/cache directory)

you can run shell script `setPermission.sh` and follow instruction

first setup `setPermission.sh` to executable:

> chmod +x setPermission.sh

then execute the file in terminal: `./setPermission.sh`

wait until done.. :)

do not hesitate if there are suggestions and criticisms [@asapdotid](https://github.com/asapdotid)
