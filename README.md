# docker-streaming


Docker images related to streaming (RIST focused) - multiarch (arm64/amd64/armv7l)

recently added armv7l support for rasperry pi 2 (32bit)

you can contact the developer on discord: https://discord.gg/khTtNJjFBY

also check out the streaming board documentation on: https://irlbox.com/

IRLBOX is using RIST BONDING and an advanced adaptive bitrate algorithm on top of the RIST integrated one

**related project:** [Native RIST Setup](https://github.com/moo-the-cow/moo-rist-hosting-native) 

**Current version docker:** `0.0.19`

**libRIST library:** `v0.2.13-9-g36de1db` **API version:** `4.7.0`

## Quick Start

### Requirement
docker must be running on that machine

get the project files into a folder
```
git clone https://github.com/moo-the-cow/moo-rist-hosting-docker
cd docker-streaming
docker compose up -d
```

### Automated Setup (Recommended)

We provide automated setup scripts for both Windows and Linux/Mac:

#### For HOME Network (username/password authentication only):
#### Linux/Mac
```bash
bash setup-docker-home.sh
```

#### Windows
double click the `setup-docker-home.bat` file

---
## Manual Setup

modify `.env` for username and password

Please check out the Comments inside the .env file there is a setup for HOME-NETWORK and for REMOTE-RELAY

you only need encryption between OBS and the FORWARDER (NOT the RECEIVER) IF you are using REMOTE-RELAY (for security reason)

---
## Description

**ON IRLBOX USE NO ENCRYPTION BUT USERNAME AND PASSWORD TO THE RECEIVER IN ANY SETUP**

**HOME-NETWORK:**
`[irlbox] (username,password,no-encryption,no secret) => [receiver] => [forwarder] (no-encryption, no-secret) => [OBS] (no-encryption, no-secret)`

**REMOTE-RELAY:**
`[irlbox] (username,password,no-encryption,no secret) => [receiver] => [forwarder] (encryption, secret) => [OBS] (encryption, secret)`

**Port Scenario:**
`irlbox => 2030 | relay | <= 5556 OBS`

---
## OBS Setup for RIST

Create a MediaSource Item and uncheck "local"

### HOME NETWORK
put `rist://[RELAY_IP]:[RELAY_PORT]?cname=irlbox` into Input

### REMOTE RELAY
put `rist://[RELAY_IP]:[RELAY_PORT]?cname=irlbox&aes-type=128&secret=[YOUR_VERY_LOG_SECRET_HASH]` into Input

or

put `rist://[RELAY_IP]:[RELAY_PORT]?cname=irlbox&aes-type=256&secret=[YOUR_VERY_LOG_SECRET_HASH]` into Input

put `mpegts` into Input Format

---
## Fix for OBS not refreshing the media source (OBS BUG please report on their github) on stream end (static html)

It also shows a nice overlay showing the bitrate and rtt

HTML Polling version

https://raw.githubusercontent.com/moo-the-cow/streaming-tools/refs/heads/main/obs_RIST_media_source_refresh/index_rist_template.html

Websocket version

https://raw.githubusercontent.com/moo-the-cow/streaming-tools/refs/heads/main/obs_RIST_media_source_refresh/index_rist_websocket_template.html

Configuration File (shared)

https://raw.githubusercontent.com/moo-the-cow/streaming-tools/refs/heads/main/obs_RIST_media_source_refresh/config.js


## Troubleshooting
After you changed your `.env` file make sure you restart docker to read those changes

---
## Faq
### How to use RIST for Scene Switching (stats)?

for dedetailed infos check out

https://github.com/sniffingpickles/BitrateSceneSwitch
