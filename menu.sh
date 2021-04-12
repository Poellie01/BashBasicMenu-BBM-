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
        echo ""
        echo -n "Enter Selection: "
        read selection
        echo ""
        case $selection in
        1) clear ; menu_option_two_basic ;;
        2) clear ; menu_option_two_full ;;
        3) clear ; menu_option_three ;;
        *) clear ; incorrect_selection ; press_enter ;;
        esac
}
menu_option_two_basic() {
        hostname=$(/bin/hostname)
        date=$(date)
        echo "Basic Host /  Kernel / IP information "
        echo ""
        uname -a
        echo ""
        echo "Current TCP/IP configuration: "
        echo ""
        ifconfig
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
menu_option_three() {
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
menu_option_three() {
	echo "Currently logged in users:" 
	w
}
basic_output_to_file() {
        uname -a | ifconfig | lsblk >> /tmp/BasicInfo.txt &> /dev/null
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
                echo "$date"
        else
                echo "$date" | figlet -cktf small
                echo "Gemeente Haarlem - RedHat" | figlet -ctk
        fi
        echo ""
        echo "          1 - Check for updates with yum"
        echo "          2 - Host Information"
        echo "		3 - Check currently logged in users"
	echo "          0 - Exit"
        echo ""
        echo -n "Enter Selection: "
        read selection
        echo ""
        case $selection in
        1) clear ; menu_option_one ; press_enter ;;
        2) clear ; menu_option_two ; press_enter ;;
	3) clear ; menu_option_three ; press_enter ;;
        0) clear ; exit ;;
        *) clear ; incorrect_selection ; press_enter ;;
        esac
done


