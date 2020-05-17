# Windows 10 Pro - WSL Ubuntu for Web Server (Base Ubuntu 20.04 LTS)

Depending on the operating system you are using:

- Ubuntu 18.04 LTS and can use the `wsl-ubuntu-18.04` branch
- Ubuntu 20.04 LTS and can use the `master` branch

**LEMP Stack** + **Node Js**

## Before run all file bash script

you can mount windows drive to WSL which create wsl config on etc

```sudo vim /etc/wsl.conf```

add this config:

``` bash
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

``` bash
Get-Service LxssManager | Restart-Service
```

![Restart WSL](./images/wsl-powershell-restart-wsl.jpg "Restart WSL from PowerShell as Administrator")

You can check that drive show on wsl:

`ls -al /c/` or `ls -al /d/`

than you can link (Win10) project directory to (WSL) home directory etc:

`ln -s /d/projects ~/.`

![Restart WSL](./images/wsl-list-home-dir.jpg "Show list home directory WSL")

Next step:

``` bash
sudo apt update && sudo apt upgrade -y
```

> Copy or clone this repository to your home directory
> Change directory to project `wsl-web-config`

### 1. Install Nginx

> ./install-nginx-on-wsl.sh

Copy all snippet files configuration: `sudo cp -r etc/nginx/snippets/* /etc/nginx/snippets`
And you can change Nginx config `nginx.conf` for optimize, sample config: `etc/nginx/nginx.conf`
Adding custom Virtual Hosts to your Nginx config, sample `$HOME/.config/vhosts`

// you can change "username" with your username
> include /home/`username`/.config/vhosts/*;

Sample virtual host for `Laravel` project, file name: `laravel-project`

``` bash
server {
    listen 80;
    listen [::]:80;

    server_name laravel-project.test;
    set $base /home/usernem/projects/laravel-project;
    root $base/public;

    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    error_page 404 /index.php;

    location ~ \.php$ {
        include snippets/php_fastcgi.conf;
    }

    # additional config
    include snippets/general.conf;

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

After install and custom configurations setup now with aliases you can run services:

- `s:nginx start`
- `s:nginx restart`
- `s:nginx stop`
- `s:nginx status`

### 2. Install MySQL

> ./install-mysql8-on-wsl.sh

Setup secure MySQL with password

> mysql_secure_installation

You can install with above script and with aliases you can run services:

- `s:mydb start`
- `s:mydb restart`
- `s:mydb stop`
- `s:mydb status`

### 3. Install PHP7.4 FPM

NOTE: Ubuntu 20.04 ships with PHP 7.4 in its upstream repositories. Just install it and the extensions you with the apt package manager.

> ./install-php-fpm-on-wsl.sh

You can install with above script and with aliases you can run services:

- `s:php start`
- `s:php restart`
- `s:php stop`
- `s:php status`

> Fastcgi Settings on `/etc/nginx/snippets/php_fastcgi.conf`
> TCP `fastcgi_pass 127.0.0.1:9000;`
> Socket `fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;`

Before you can user fastcgi_pass `TCP` you should change php7.4-fpm config on www.conf: `/etc/php/7.4/fpm/pool.d/www.conf`

``` bash
; The address on which to accept FastCGI requests.
; Valid syntaxes are:
;   'ip.add.re.ss:port'    - to listen on a TCP socket to a specific IPv4 address on
;                            a specific port;
;   '[ip:6:addr:ess]:port' - to listen on a TCP socket to a specific IPv6 address on
;                            a specific port;
;   'port'                 - to listen on a TCP socket to all addresses
;                            (IPv6 and IPv4-mapped) on a specific port;
;   '/path/to/unix/socket' - to listen on a unix socket.
; Note: This value is mandatory.
listen = /run/php/php7.4-fpm.sock
```

Change to:

``` bash
; The address on which to accept FastCGI requests.
; Valid syntaxes are:
;   'ip.add.re.ss:port'    - to listen on a TCP socket to a specific IPv4 address on
;                            a specific port;
;   '[ip:6:addr:ess]:port' - to listen on a TCP socket to a specific IPv6 address on
;                            a specific port;
;   'port'                 - to listen on a TCP socket to all addresses
;                            (IPv6 and IPv4-mapped) on a specific port;
;   '/path/to/unix/socket' - to listen on a unix socket.
; Note: This value is mandatory.
; listen = /run/php/php7.4-fpm.sock
listen = 127.0.0.1:9000
```

### 4. Install Redis Server

> ./install-redis-on-wsl.sh

Now you have Redis Server on your system.

- `s:redis start`
- `s:redis restart`
- `s:redis stop`
- `s:redis status`

### 5. Install NODE JS use NVM

> ./install-nvm-on-wsl.sh

Now you have Node JS on your system.

Reference [NVM Repo](https://github.com/nvm-sh/nvm#installing-and-updating)

## Add correct permission files and directory optional (Laravel storage & boostrap/cache directory)

you can run shell script `setPermission.sh` and follow instruction

first setup `setPermission.sh` to executable:

> chmod +x setPermission.sh

Then execute the file in terminal: `./setPermission.sh`

or

you can add in composer.json on root Laravel project

``` bash
"scripts": {
    "post-install-cmd": [
      "chgrp -R www-data storage bootstrap/cache",
      "chmod -R ug+rwx storage bootstrap/cache"
    ]
}
```

Do not hesitate if there are suggestions and criticisms [@asapdotid](https://github.com/asapdotid)
