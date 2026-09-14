while true
do
        clear
        echo "===== Welcome to the MAIN MENU ====="
        echo "1) System Status"
        echo "2) Backup Management"
        echo "3) Network Management"
        echo "4) Service Management"
        echo "5) User Management"
        echo "6) File Management"
        echo "7) Exit the program"
        echo "==================================="
        
        read -p "Enter an option [1-7]: " option
        
	case $option in 
   	 1) source status.sh ;;
   	 2) source Backup_Management.sh ;;
   	 3) source Network_Management.sh ;;
   	 4) source Service_Management.sh ;;
   	 5) source management.sh ;;
   	 6) source FileManagement.sh ;;
   	 7)
        echo "Goodbye!"
        echo "Exiting..."
        sleep 1
        exit 0
        ;;
    *)
        echo "Invalid choice, please try again!"
        sleep 1
        ;;
esac

done
