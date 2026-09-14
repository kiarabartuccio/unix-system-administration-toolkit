while true; do
    clear
    # Blue headers for menu
    echo -e "\e[34m===============================\e[0m"
    echo -e "\e[34m      USER MANAGEMENT MENU     \e[0m"
    echo -e "\e[34m===============================\e[0m"

    # Menu options
    echo "1) Create a new user"
    echo "2) Grant root privileges to a user"
    echo "3) Delete a user"
    echo "4) Display currently connected users"
    echo "5) Disconnect a remote user"
    echo "6) Show all groups a user belongs to"
    echo "7) Change a user's group membership"
    echo "8) Return to Main Menu"
    echo -e "\e[34m===============================\e[0m"

    # Ask for user choice
    read -p "Enter your choice [0-8]: " choose

    case $choose in
        1)
            # Create a new user
            read -p "Enter new username: " username
            read -s -p "Enter password: " password
            echo ""
            useradd "$username"
            echo "$password" | passwd --stdin "$username" 2>/dev/null
            echo "User $username created."
            read -p "Press ENTER to continue..."
            ;;
        2)
            # Grant root privileges
            read -p "Enter username to give root privileges: " username
            gpasswd -a "$username" yes
            echo "$username now has root privileges."
            read -p "Press ENTER to continue..."
            ;;
        3)
            # Delete a user
            read -p "Enter username to delete: " username
            userdel "$username" 2>/dev/null
            echo "User $username deleted."
            read -p "Press ENTER to continue..."
            ;;
        4)
            # Show currently connected users
            echo "Currently logged in users:"
            who
            read -p "Press ENTER to continue..."
            ;;
        5)
            # Disconnect a user
            read -p "Enter username to disconnect: " username
            pkill -KILL -u "$username"
            echo "User $username has been disconnected."
            read -p "Press ENTER to continue..."
            ;;
        6)
            # Show groups for a user
            read -p "Enter username: " username
            echo "Groups for $username:"
            groups "$username"
            read -p "Press ENTER to continue..."
            ;;
        7)
            # Add user to a group
            read -p "Enter username: " username
            read -p "Enter group to add user to: " group
            gpasswd -a "$username" "$group"
            echo "$username added to group $group."
            read -p "Press ENTER to continue..."
            ;;
        8)
            # Return to main menu
            echo "Returning to Main Menu..."
            sleep 1
            break
            ;;
        *)
            # Invalid input handler
            echo "Invalid option. Try again."
            sleep 1
            ;;
    esac
done
