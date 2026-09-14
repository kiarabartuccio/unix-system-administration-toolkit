#!/bin/bash

# ==========================================
#         SYSTEM STATUS INFORMATION
# ==========================================

#displays:
echo -e "\033[1;34m================ MEMORY INFORMATION ================\033[0m"
#Shows memory information in a way humans can read it:
#free: shows system memory statistics
#-h: human-readable-intsead of raw bytes
free -h
echo ""

# ==========================================
#                CPU TEMPERATURE
# ==========================================

#displays:
echo -e "\033[1;34m================= CPU TEMPERATURE ==================\033[0m"
#checks if temperature file already exists in system:
#[...]: checks if file exists in regular file not in directory or device
if [ -f /sys/class/thermal/thermal_zone0/temp ]
 then
    #reads temps values:
    #(...): reads contents of file that store CPU temp in millidegrees Celsius
    #$(...): command substitution, runs command inside () and stores result
    #raw_temp=...:assigns result of command to variable named raw_temp
    raw_temp=$(cat /sys/class/thermal/thermal_zone0/temp)

    #converts millidegrees to degrees (/1000):
    #raw_temp: variable holding CPU temp in millidegrees Celsius
    #raw_temp / 1000: divides raw temp by 1000 to convert to degrees Celsius
    #temp=...assigns result to new variable called temp
    temp=$((raw_temp / 1000))

    #displays converted temp:
    echo "CPU temperature is: $temp°C"

    #if temp > 70 it displays alert:
    if [ "$temp" -gt 70 ]
 then
        echo -e "\033[1;31mALERT!!! - CPU temperature is higher than 70°C!\033[0m"
    fi
else
    #if no temp file, displays:
    echo "Temperature info not available on this system."
fi
echo ""

# ==========================================
#             SYSTEM PROCESSES
# ==========================================

#displays:
echo -e "\033[1;34m================= SYSTEM PROCESSES =================\033[0m"
#shows first 10 running processes:
#ps:process status
#a:shows processes for all users
#u:shows user-oriented format(username, CPU/memory usage,...)
#x:include processes not attached to terminal(ex.background services)
#|:pipe operator:sends output of ps aux into next command
#head -n 10: displays only first 10 lines of output
ps aux | head -n 10
echo ""

#asks user to choose using PID(process ID):
read -p "Enter a PID to stop or press Enter to skip: " stop

#if enter stop and displays:
if [ "$stop" ]
 then
    #kill $stop: tries to stop process with specified PID
    #&&: if kill succeed(return exit status 0), then run next command
    #echo Process $stop stopped: prints success message
    #||: if kill fails (returns non-zero), then run the next command
    #echo Failed to stop process $stop: prints error message if process could not be stopped
    kill "$stop" && echo "Process $stop stopped." || echo "Failed to stop process $stop."
fi
