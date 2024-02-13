#!/bin/bash

# Display the message
echo -e "\e[1;33mCreate with Love By Mr.HamidRouter - Special Thanks to Engineer Masoud Gb\e[0m"
sleep 2

# Variables
log_directory="/var/Pingchi"
ipv4_log="$log_directory/ipv4.log"
ipv6_log="$log_directory/ipv6.log"
domain_log="$log_directory/domain.log"

# Create log directory if not exist
mkdir -p "$log_directory"

# Function for scheduling and pinging
schedule_and_ping() {
    target="$1"
    logfile="$2"
    timing="$3"

    # Execute ping command for the target and save results to log file
    ping_result=$(ping -c 1 "$target")
    if [ $? -eq 0 ]; then
        echo "$(date): $ping_result" >> "$logfile"
        echo -e "\e[1;36mPing command executed for $target every $timing and results saved in $logfile.\e[0m"
    else
        echo "$(date): Ping to $target timed out." >> "$logfile"
        echo -e "\e[1;31mPing to $target timed out.\e[0m"
    fi

    # Check log file size and rotate if necessary
    log_size=$(wc -c <"$logfile")
    if [ $log_size -gt 1048576 ]; then  # 1 MB in bytes
        mv "$logfile" "$logfile.old"
        echo -e "\e[1;33mLog file exceeded size limit. Rotated the log file.\e[0m"
    fi
}

# Install submenu
install_submenu() {
    clear
    echo -e "\e[1;35mInstall Submenu:\e[0m"
    echo -e "\e[1;32m1. Install IPv4\e[0m"
    echo -e "\e[1;33m2. Install IPv6\e[0m"
    echo -e "\e[1;34m3. Install Domain\e[0m"
    read -p "Please select an option: " choice

    case $choice in
        1)
            echo -e "\e[1;32mEnter IPv4 Address:\e[0m"
            read ipv4_address
            read -p "Set timing for IPv4 ping (e.g., 1m for 1 minute, 1h for 1 hour, 1d for 1 day, 1M for 1 month): " ipv4_timing
            schedule_and_ping "$ipv4_address" "$ipv4_log" "$ipv4_timing"
            echo -e "\e[1;32mIPv4 successfully installed.\e[0m"
            ;;
        2)
            echo -e "\e[1;33mEnter IPv6 Address:\e[0m"
            read ipv6_address
            read -p "Set timing for IPv6 ping (e.g., 1m for 1 minute, 1h for 1 hour, 1d for 1 day, 1M for 1 month): " ipv6_timing
            schedule_and_ping "$ipv6_address" "$ipv6_log" "$ipv6_timing"
            echo -e "\e[1;33mIPv6 successfully installed.\e[0m"
            ;;
        3)
            echo -e "\e[1;34mEnter Domain:\e[0m"
            read domain
            read -p "Set timing for domain ping (e.g., 1m for 1 minute, 1h for 1 hour, 1d for 1 day, 1M for 1 month): " domain_timing
            schedule_and_ping "$domain" "$domain_log" "$domain_timing"
            echo -e "\e[1;34mDomain successfully installed.\e[0m"
            ;;
        *)
            echo -e "\e[1;31mInvalid choice!\e[0m"
            ;;
    esac
    sleep 2
}

# Display logs
display_logs() {
    while true; do
        clear
        echo -e "\e[1;35mDisplay Logs:\e[0m"
        echo -e "\e[1;32m1. View IPv4 Logs\e[0m"
        echo -e "\e[1;33m2. View IPv6 Logs\e[0m"
        echo -e "\e[1;34m3. View Domain Logs\e[0m"
        echo -e "\e[1;35m4. Search Logs\e[0m"
        echo -e "\e[1;31m5. Exit\e[0m"
        read -p "Please select an option: " log_choice

        case $log_choice in
            1)
                nano "$ipv4_log"
                ;;
            2)
                nano "$ipv6_log"
                ;;
            3)
                nano "$domain_log"
                ;;
            4)
                read -p "Enter search keyword: " search_keyword
                grep -i "$search_keyword" "$log_directory"/*.log
                read -p "Press Enter to go back..."
                ;;
            5)
                break
                ;;
            *)
                echo -e "\e[1;31mInvalid choice!\e[0m"
                ;;
        esac
    done
}

# Uninstall function
uninstall() {
    clear
    echo -e "\e[1;35mUninstall:\e[0m"
    echo -e "\e[1;32m1. Uninstall IPv4\e[0m"
    echo -e "\e[1;33m2. Uninstall IPv6\e[0m"
    echo -e "\e[1;34m3. Uninstall Domain\e[0m"
    read -p "Please select an option to uninstall: " uninstall_choice

    case $uninstall_choice in
        1)
            rm -i "$ipv4_log"
            echo -e "\e[1;32mUninstalled successfully!\e[0m"
            ;;
        2)
            rm -i "$ipv6_log"
            echo -e "\e[1;33mUninstalled successfully!\e[0m"
            ;;
        3)
            rm -i "$domain_log"
            echo -e "\e[1;34mUninstalled successfully!\e[0m"
            ;;
        *)
            echo -e "\e[1;31mInvalid choice!\e[0m"
            ;;
    esac
}

# Main menu
while true; do
    clear
    echo -e "\e[1;36mPing Chi Project 0.8\e[0m"
    echo -e "\e[1;36mCreate with Love By Mr.HamidRouter - Special Thanks to Engineer Masoud Gb\e[0m"
    echo -e "\e[1;32m1. Install\e[0m"
    echo -e "\e[1;33m2. View Logs\e[0m"
    echo -e "\e[1;34m3. Uninstall\e[0m"
    echo -e "\e[1;31m4. Exit\e[0m"
    read -p "Please select an option: " choice

    case $choice in
        1)
            install_submenu
            ;;
        2)
            display_logs
            ;;
        3)
            uninstall
            ;;
        4)
            echo -e "\e[1;32mThank you for using Ping Chi Project. Goodbye!\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid choice!\e[0m"
            ;;
    esac
    sleep 2
done
