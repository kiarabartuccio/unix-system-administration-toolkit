#!/bin/bash

# ============================
#     BACKUP MANAGEMENT MENU
# ============================

while true
 do
    clear

    # Main menu
    echo -e "\033[1;34m======================================\033[0m"
    echo -e "\033[1;34m========== BACKUP SCHEDULER ==========\033[0m"
    echo -e "\033[1;34m======================================\033[0m"
    echo "1) Schedule a new backup"
    echo "2) View last backup"
    echo "3) Return to Main Menu"
    echo -e "======================================"
    read -p "Choose an option [1-3]: " choice

    case "$choice" in

        1)
            echo ""
            echo -e "\033[1;34m===== BACKUP SCHEDULER =====\033[0m"
            echo ""

            # Ask user for input
            read -p "Enter FULL PATH of the file/folder to backup: " fileName
            read -p "Enter the DAY of backup (1-31): " day
            read -p "Enter the TIME of backup (HH:MM): " time
            read -p "Enter the DESTINATION folder: " dest

            # Extract hour and minute from input
            hour=$(echo "$time" | cut -d: -f1)
            minute=$(echo "$time" | cut -d: -f2)

            # Create destination folder if it doesn't exist
            mkdir -p "$dest"

            # Install cron job
            (crontab -l 2>/dev/null; \
            echo "$minute $hour $day * * tar -czf $dest/backup_\$(date +\%Y\%m\%d_\%H\%M\%S).tar.gz $fileName && echo \"Last backup: \$(date)\" > $dest/last_backup.txt") \
            | crontab -

            # Display a mini summary
            echo ""
            echo -e "\033[1;32mBackup scheduled successfully!\033[0m"
            echo "--------------------------------------"
            echo "Backup Summary:"
            echo "File/Folder: $fileName"
            echo "Day: $day"
            echo "Time: $time"
            echo "Destination: $dest"
            echo "--------------------------------------"
            echo ""
            read -p "Press ENTER to continue..."
 ;;

        2)
            read -p "Enter the DESTINATION backup folder: " dest

            # Display last backup if exists
            if [ -f "$dest/last_backup.txt" ]
 then
                echo ""
                echo -e "\033[1;32mLast completed backup:\033[0m"
                cat "$dest/last_backup.txt"
            else
                echo ""
                echo -e "\033[1;31mNo backup has been completed yet.\033[0m"
            fi

            echo ""
            read -p "Press ENTER to continue..."
 ;;

        3)
            echo "Returning to Main Menu..."
            sleep 1
            return
 ;;

        *)
            # Handle invalid input
            echo -e "\033[1;31mInvalid option, try again.\033[0m"
            sleep 1 
;;
    esac

done
