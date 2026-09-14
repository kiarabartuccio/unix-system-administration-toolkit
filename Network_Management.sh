#!/bin/bash

while true; do
    clear
    # ============================
    #       NETWORK MENU
    # ============================

    echo -e "\033[1;34m----- Network Management -----\033[0m"
    echo "1) Display networks and IP addresses"
    echo "2) Enable a network interface"
    echo "3) Disable a network interface"
    echo "4) Set an IP address"
    echo "5) Display Wi-Fi networks"
    echo "6) Return to Main Menu"
    echo "==============================="

    # Ask for user choice
    read -p "Choose an option [1-6]: " op

    case $op in
        1)
            # Display all networks with IP addresses
            echo -e "\n\033[1;32mCurrent networks and IP addresses:\033[0m"
            ip -4 -brief address show
            echo ""
            read -p "Press ENTER to continue..." ;;
        
        2)
            # Enable a network interface
            read -p "Enter the network interface to enable: " net
            sudo ip link set "$net" up
            state=$(ip -o link show "$net" | awk '{print $9}')
            if [ "$state" = "UP" ]
 then
                echo -e "\033[1;32m $net is now enabled\033[0m"
            else
                echo -e "\033[1;31m Failed to enable $net, try again\033[0m"
            fi
            read -p "Press ENTER to continue..." ;;

        3)
            # Disable a network interface
            read -p "Enter the network interface to disable: " net
            sudo ip link set "$net" down
            state=$(ip -o link show "$net" | awk '{print $9}')
            if [ "$state" = "DOWN" ]
 then
                echo -e "\033[1;32m $net is now disabled\033[0m"
            else
                echo -e "\033[1;31m Failed to disable $net, try again\033[0m"
            fi
            read -p "Press ENTER to continue..." ;;

        4)
            # Set a static IP address
            read -p "Enter the network interface to set IP: " net
            read -p "Enter the IP address to assign: " ip_addr
            sudo ip addr add "$ip_addr" dev "$net"
            ipSet=$(ip -4 -brief address show "$net" | awk '{print $3}')
            if [[ "$ipSet" == *"$ip_addr"* ]]
 then
                echo -e "\033[1;32m $ip_addr has been set on $net\033[0m"
            else
                echo -e "\033[1;31m Failed to set IP on $net, try again\033[0m"
            fi
            read -p "Press ENTER to continue..." ;;

        5)
            # Display available Wi-Fi networks and connect
            echo -e "\n\033[1;32mAvailable Wi-Fi networks:\033[0m"
            nmcli dev wifi
            read -p "Enter the Wi-Fi network to connect: " wifi
            read -p "Enter the Wi-Fi password: " pass
            connection=$(nmcli dev wifi connect "$wifi" password "$pass" 2>/dev/null)
            if [ $? -eq 0 ]
 then
                echo -e "\033[1;32m Connected to $wifi successfully!\033[0m"
            else
                echo -e "\033[1;31m Failed to connect to $wifi, check password or signal.\033[0m"
            fi
            read -p "Press ENTER to continue..." ;;

        6)
            # Exit to main menu
            echo "Returning to Main Menu..."
            sleep 1
            break ;;

        *)
            # Handle invalid input
            echo -e "\033[1;31mInvalid option, try again.\033[0m"
            sleep 1 ;;
    esac
done
