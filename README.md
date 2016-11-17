# Docker Toran Proxy

Toran acts as a proxy for Packagist and GitHub. It is meant to be set up on your own server or even inside your office. This offers a few benefits:

- **Redundant infrastructure to ensure your deployments never fail and your developers can work at any time.** Packages will be installed from your proxy with a fallback to Github, ensuring a maximum availability.
- **Higher bandwidth for faster installations.** You can set up Toran on your local network or on a server near you.

This is a modification of [cedvan/docker-toran-proxy](https://github.com/cedvan/docker-toran-proxy/) using Ubuntu 16.04 and PHP 7

## Quick Start

```bash
docker run --name toran-proxy -d \
    -p 80:80 \
    christirichards/toran-proxy:latest
```

Open **localhost** in your browser

## Save data

Files are saved to `/data/toran-proxy` in the container. Simply mount this volume to save your configurations and repositories

```bash
docker run --name toran-proxy -d \
    -v /opt/toran-proxy:/data/toran-proxy \
    christirichards/toran-proxy:latest
```

## Add an SSH Config for Private Repositories

```bash
docker run --name toran-proxy -d \
    -p 443:443 \
    -v /opt/toran-proxy/ssh:/data/toran-proxy/ssh \
    christirichards/toran-proxy:latest
```

_Files supported : `id_rsa`, `id_rsa.pub`, `config` and `known_hosts`_

## Configure Cron

```bash
docker run --name toran-proxy -d \
    -p 443:443 \
    -e "TORAN_CRON_TIMER=half" \
    christirichards/toran-proxy:latest
```

## Enabled HTTPS

```bash
docker run --name toran-proxy -d \
    -p 443:443 \
    -e "TORAN_HTTPS=true" \
    -v /opt/toran-proxy/certs:/data/toran-proxy/certs \
    christirichards/toran-proxy:latest
```

Add your **toran-proxy.key** and **toran-proxy.crt** in the folder **certs**. If `toran-proxy.key` and `toran-proxy.crt` do not exist, the container will create self-signed certificates for you

## HTTP Authentication

Use the file **htpasswd** to add authentication

Add `auth.json` to the Composer configuration home folder

```
{
    "http-basic": {
        "toran-proxy.domain.tld": {
            "username": "myUsername",
            "password": "myPassword"
        },
    }
}
```

## Toran Proxy Options

_Please refer the Docker run command options for the `--env-file` flag where you can specify all of the required environment variables in a single file. This will save you from writing a potentially long Docker run command. Alternately you can use fig._

Below is the complete list of available options that can be used to customize your Toran Proxy installation.

- **TORAN_HOST**: The hostname of the Toran Proxy server. Defaults to `localhost`
- **TORAN_HTTP_PORT**: The port of the Toran HTTP server. Defaults to `80`
- **TORAN_HTTPS**: Set to `true` to enable HTTPS support, Defaults to `false`. **If you do not use a reverse proxy, don't forget to add the certificate files**
- **TORAN_HTTPS_PORT**: The port of the Toran HTTPS server. Defaults to `443`
- **TORAN_REVERSE**: Set to `true` if you use Docker behind a reverse proxy for i.e. SSL Termination. This will make Toran use the HTTPS scheme without the need to add certificates. If you do so, make sure to set your reverse proxy to target port 443\. Defaults to `false`
- **TORAN_CRON_TIMER**: Setup cron job timer. Defaults to `fifteen`

  - `minutes`: All minutes
  - `five`: All five minutes
  - `fifteen`: All fifteen minutes
  - `half`: All thirty minutes
  - `hour`: All hours
  - `daily`: All days at 04:00 (Use _TORAN_CRON_TIMER_DAILY_TIME_ for customize time)

- **TORAN_CRON_TIMER_DAILY_TIME**: Set a time for cron job daily timer in `HH:MM` format. Defaults to `04:00`

- **TORAN_TOKEN_GITHUB**: Add your Github OAuth token to download repositories from Github. Default `null`.

- **TORAN_TRACK_DOWNLOADS**: Track private package installs. Set to `true` to get an install log in `/data/toran-proxy/logs/downloads.private.log`. Defaults to `false`

- **TORAN_MONO_REPO**: Set to `true` to a use a mono repo instead of dual repo model. Defaults to `false`

- **PHP_TIMEZONE**: Configure timezone in PHP. Default `America/New_York`.

- **TORAN_AUTH_ENABLE**: Set to `true` to enable HTTP Basic Authentication. When enabled, `TORAN_AUTH_USER` and `TORAN_AUTH_PASSWORD` are required. Defaults to `false`.

- **TORAN_AUTH_USER**: Configure the HTTP Basic Authentication Username. Defaults to `toran`.

- **TORAN_AUTH_PASSWORD**: Configure the HTTP Basic Authentication Password. Defaults to `toran`.

## Toran Proxy License

By default, the Toran Proxy license is for personal use. You can add a license from the Toran Proxy interface if you have a paid plan.
