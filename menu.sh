#!/bin/bash

menu_option_one() {
        echo "Checking with yum for updates"
        yumtmp="/tmp/yum-check-update.$$"
        yum="/usr/bin/yum"
        $yum check-update >& $yumtmp
        yumstatus="$?"
        hostname=$(/bin/hostname)
        case $yumstatus in
        o)
        echo "No Updates"
        exit o
        ;;
        *)
        date=$(date)
        number=$(cat $yumtmp | egrep '(.i386|.x86_64|.noarch|.src)'| wc -l)
        updates=$(cat $yumtmp | egrep '(.i386|.x86_64|.noarch|.src)')
        echo "There are $number updates available on host $hostname at $date"
        echo "The available updates are"
        echo ""
        echo "$updates"
        ;;
        esac
        rm -f /tmp/yum-check-update.*
}
menu_option_two() {
        echo "Host machine INFO"
        echo ""
        echo "          1 - Display Basic information"
        echo "          2 - Display Full information"
        echo "          3 - Display CPU information"
        echo "          4 - Display GPU information"
        echo ""
        echo -n "Enter Selection: "
        read selection
        echo ""
        case $selection in
        1) clear ; menu_option_two_basic ;;
        2) clear ; menu_option_two_full ;;
        3) clear ; menu_option_two_cpu ;;
        4) clear ; menu_option_two_gpu ;;
        *) clear ; incorrect_selection ; press_enter ;;
        esac
}
menu_option_two_basic() {
        hostname=$(/bin/hostname)
        date=$(date)
        echo "Basic Host /  Kernel / IP / Disk information "
        echo ""
        uname -a
        echo ""
        echo "Current TCP/IP configuration: "
        echo ""
        if ! command -v ifconfig &> /dev/null
        then
                ip link show
        else
                ifconfig
        fi
        echo ""
        echo "Hard disks"
        echo ""
        lsblk
        echo ""
        echo "          1. Save output to file"
        echo "          2. Return to main menu"
        echo ""
        echo "Select action: "
        read action
        echo ""
        case $action in
        1) basic_output_to_file ;;
        2) clear ;;
        *) incorrect_selection ; press_enter ;;
        esac
}
menu_option_two_full() {
        echo "Full list information"
        lshw
        echo ""
        echo "          1. Save output to file"
        echo "          2. Return to main menu"
        echo ""
        echo "Select action: "
        read action
        echo ""
        case $action in
        1) full_save_output_to_file ;;
        2) clear ;;
        *) incorrect_selection ; press_enter ;;
        esac
}
menu_option_two_cpu() {
        echo "CPU information"
        echo ""
        lscpu
        echo ""
        echo ""
        echo "          1. Save Output to file"
        echo "          2. Return to main menu"
        echo ""
        echo "Select action: "
        read action
        echo ""
        case $action in
        1) cpu_save_output_to_file ;;
        2) clear ;;
        *) incorrect_selection ; press_enter ;;
        esac
}
menu_option_two_gpu() {
        echo ""
        echo "Basic GPU information"
        echo ""
        lshw -C display
        echo ""
        echo "          1. Save output to file"
        echo "          2. Return to main menu"
        echo ""
        echo "Select action: "
        read action
        echo ""
        case $action in
        1) gpu_save_output_to_file ;;
        2) clear ;;
        *) incorrect_selection ;;
        esac
}
menu_option_three() {
        echo "Logged in users:"
        echo ""
        w
        echo ""
        echo "          1. List all users"
        echo "          2. Return to main menu"
        echo ""
        echo "Select action: "
        read action
        case $action in
        1) list_all_users ;;
        2) clear ;;
        *) incorrect_selection ;;
        esac
}
menu_option_four() {
        echo ""
        echo "Network stats"
        echo ""
        netstat -i
}
menu_option_five() {
        echo "Press CTLR + C to get back to the main menu"
        top

}
menu_option_six() {
        echo""
        history
}
list_all_users() {
        echo ""
        awk -F: '{ print $1}' /etc/passwd
        echo ""
}
basic_output_to_file() {
        uname -a && ifconfig && lsblk >> /tmp/BasicInfo.txt &> /dev/null
        echo "Saved as /tmp/BasicInfo.txt"
}
full_save_output_to_file() {
        lshw >> /tmp/HardWareInfo.txt
        echo "Saved as /tmp/HardWareInfo.txt"
}
cpu_save_output_to_file() {
        lscpu >> /tmp/CPUInfo.txt
        echo "Saved as /tmp/CPUInfo.txt"
}
gpu_save_output_to_file() {
        lshw -C display >> /tmp/GPUInfo.txt
        echo "Saved as /tmp/GPUInfo.txt"
}
press_enter() {
        echo ""
        echo -n "       Press Enter to continue "
        read
        clear
}
incorrect_selection() {
        echo "Incorrect selection! Try again. "
}
until ["$selection" = "0" ]; do
        clear
        date=$(date)
        if ! command -v figlet &> /dev/null
        then
                COLUMNS=$(tput cols)
                title=$(date)
                banner="Banner"
                printf "%*s\n" $(((${#banner}+$COLUMNS)/2)) "$banner"
                printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
        else
                echo "Banner" | figlet -ctk
                COLUMNS=$(tput cols)
                title=$(date)
                printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
        fi
        echo ""
        echo "          1 - Check for updates with yum                          5- List current running processes"
        echo "          2 - Host Information                                    6- Command history"
        echo "          3 - Check currently logged in users                     7- Test "
        echo "          4 - Network stats                                       8- Test "
        echo "          0 - Exit                                                9- Test "
        echo ""
        echo -n "Enter Selection: "
        read selection
        echo ""
        case $selection in
        1) clear ; menu_option_one ; press_enter ;;
        2) clear ; menu_option_two ; press_enter ;;
        3) clear ; menu_option_three ; press_enter ;;
        4) clear ; menu_option_four ; press_enter ;;
        5) clear ; menu_option_five ; press_enter ;;
        6) clear ; menu_option_six ; press_enter ;;
        0) clear ; exit ;;
        *) clear ; incorrect_selection ; press_enter ;;
        esac
done




