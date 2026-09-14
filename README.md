# Unix System Administration Toolkit

A menu-driven Bash application that brings together common Linux administration tasks for system monitoring, backups, networking, services, users, and files.

> **Visibility:** This fork is currently private. Only approved GitHub users can view or download it.

## Quick Start

This project is designed for a Linux system that uses Bash and `systemd`.

```bash
git clone https://github.com/kiarabartuccio/unix-system-administration-toolkit.git
cd unix-system-administration-toolkit
chmod +x run.sh
./run.sh
```

The launcher gives the project scripts execute permission and opens the main menu.

Some operations—such as changing network interfaces, managing services, and modifying users—require `sudo` or root privileges. Test those options in a virtual machine rather than on an important computer.

## Features

### System Status

- Display human-readable memory usage
- Read CPU temperature when supported
- Warn when CPU temperature exceeds 70°C
- List active processes
- Stop a process by PID

### Backup Management

- Schedule compressed backups using `cron`
- Choose the source, date, time, and destination
- Display the last completed backup

### Network Management

- Display interfaces and IPv4 addresses
- Enable or disable an interface
- Assign an IP address
- Scan for Wi-Fi networks and connect using NetworkManager

### Service Management

- List running services
- Start or stop a selected `systemd` service

### User Management

- Create and delete users
- Manage user groups and privileges
- View connected users
- Disconnect a remote user session

### File Management

- Search for files in a user's home directory
- Display the ten largest files
- Display the ten oldest files

## Technologies and Commands

- Bash
- Linux
- `systemctl`
- `ip` and `nmcli`
- `cron`, `tar`, and `find`
- Linux user and process-management commands

## Project Structure

- `MainMenu.sh` – central navigation menu
- `status.sh` – system and process information
- `Backup_Management.sh` – scheduled backup tools
- `Network_Management.sh` – interface and Wi-Fi management
- `Service_Management.sh` – service controls
- `management.sh` – user administration
- `FileManagement.sh` – file search and reporting
- `run.sh` – quick-start launcher

## What I Practiced

This collaborative academic project demonstrates Bash scripting, menu design, input validation, Linux permissions, process management, system services, scheduled tasks, networking, and Git-based teamwork.
