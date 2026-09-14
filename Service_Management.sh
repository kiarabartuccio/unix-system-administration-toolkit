#!/bin/bash

# ============================

# SERVICE MANAGEMENT MENU

# ============================

while true; do
clear
# Blue headers for the menu
echo -e "\e[34m===============================\e[0m"
echo -e "\e[34m      SERVICE MANAGEMENT       \e[0m"
echo -e "\e[34m===============================\e[0m"

# Menu options
echo "1) Show all running services"
echo "2) Start a service"
echo "3) Stop a service"
echo "4) Return to Main Menu"
echo -e "\e[34m===============================\e[0m"

read -p "Choose an option [1-4]: " choice

case $choice in
    1)
        # Show first 12 running services
        echo ""
        echo "----- Running Services -----"
        systemctl list-units --type=service --state=running | head -n 12
        echo "----------------------------"
        read -p "Press ENTER to continue..."
        ;;

    2)
        # Show inactive services first
        echo ""
        echo "----- Inactive Services -----"
        systemctl list-units --type=service --state=inactive | head -n 12
        echo "-----------------------------"

        # Ask for service name
        read -p "Enter the name of the service to start: " service

        # Check if input is empty
        if [ -z "$service" ]
 then
            echo "No service name entered. Nothing to start."
        # Check if service exists
        elif systemctl list-units --type=service | grep -q "^$service"
 then
            sudo systemctl start "$service"
            echo "Service '$service' started successfully."
        else
            echo "Service '$service' not found."
        fi

        read -p "Press ENTER to continue..."
        ;;

    3)
        # Show running services first
        echo ""
        echo "----- Running Services -----"
        systemctl list-units --type=service --state=running | head -n 12
        echo "----------------------------"

        # Ask for service name
        read -p "Enter the name of the service to stop: " service

        # Check if input is empty
        if [ -z "$service" ]
 then
            echo "No service name entered. Nothing to stop."
        # Check if service exists
        elif systemctl list-units --type=service | grep -q "^$service"
 then
            sudo systemctl stop "$service"
            echo "Service '$service' stopped successfully."
        else
            echo "Service '$service' not found."
        fi

        read -p "Press ENTER to continue..."
        ;;

    4)
        # Return to main menu
        echo "Returning to Main Menu..."
        sleep 1
        break
        ;;

    *)
        # Invalid input
        echo "Invalid option! Try again."
        sleep 1
        ;;
esac

done
