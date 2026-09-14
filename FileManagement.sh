#!/bin/bash

# ============================
#   FILE MANAGEMENT SUB-MENU
# ============================

while true; do
    clear
    # Blue headers for the menu
    echo -e "\e[34m==========================================\e[0m"
    echo -e "\e[34m        FILE MANAGEMENT MENU             \e[0m"
    echo -e "\e[34m==========================================\e[0m"
    
    # Menu options
    echo "1) Search for a file"
    echo "2) Show 10 largest files"
    echo "3) Show 10 oldest files"
    echo "4) Return to Main Menu"
    echo -e "\e[34m==========================================\e[0m"

    # Ask user to choose an option
    read -p "Choose an option [1-4]: " choice

    case "$choice" in

        1)
            # Search for a file in user's home
            read -p "Enter a username: " username
            
            if ! id "$username" >/dev/null 2>&1
 then
                echo "User does not exist."
                sleep 2
                continue
            fi
            
            read -p "Enter the filename to search: " filename
            userHome="/home/$username"

            echo ""
            echo "Searching for '$filename' in $userHome ..."
            filePath=$(find "$userHome" -type f -name "$filename" 2>/dev/null)

            if [ -n "$filePath" ]
 then
                echo "File Found:"
                echo "$filePath"
            else
                echo "File not found."
            fi

            read -p "Press ENTER to continue..." ;;
        
        2)
            # Show 10 largest files in user's home
            read -p "Enter a username: " username
            userHome="/home/$username"

            if [ ! -d "$userHome" ]
 then
                echo "Home directory does not exist."
                sleep 2
                continue
            fi

            echo ""
            echo "10 Largest Files in $userHome:"
            du -ah "$userHome" 2>/dev/null | sort -hr | head -10

            read -p "Press ENTER to continue..." ;;

        3)
            # Show 10 oldest files in user's home
            read -p "Enter a username: " username
            userHome="/home/$username"

            if [ ! -d "$userHome" ]
 then
                echo "Home directory does not exist."
                sleep 2
                continue
            fi

            echo ""
            echo "10 Oldest Files in $userHome:"
            find "$userHome" -type f -printf "%T@ %p\n" 2>/dev/null \
                | sort -n | head -10 | cut -d' ' -f2-

            read -p "Press ENTER to continue..." ;;

        4)
            # Return to main menu
            echo "Returning to Main Menu..."
            sleep 1
            return ;;   # Back to MainMenu.sh

        *)
            # Invalid input handler
            echo "Invalid option! Try again."
            sleep 1 ;;
    esac
done
