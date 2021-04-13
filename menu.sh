
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
user_history() {
        echo ""
        user1="Dylan Poelstra"
        user2="Eduard Regenboog"
        user3="Theo Kastermans"
        echo "History of user $user1"
        echo ""
        cat /home/a-poelstd/.bash_history
        echo ""
        echo "History of user $user2"
        cat /home/a-eregenboog/.bash_history
        echo ""
        echo "History of user $user3"
        cat /home/a-tkastermans/.bash_history
        echo ""
        echo "          1. Save history of specific user"
        echo "          2. Return to main menu"
        echo ""
        echo "Select action: "
        read action
        case $action in
        1) save_user_history ;;
        2) clear ;;
        esac
}
save_user_history(){
        echo ""
        echo "Which users history would you like to save?"
        echo "1. Dylan Poelstra"
        echo "2. Theo Kastermans"
        echo "3. Eduard Regenboog"
        echo "4. root"
        echo ""
        echo "Select user: "
        read action
        case $action in
        1) save_user_history_poelstra ;;
        2) save_user_history_kastermans ;;
        3) save_user_history_regenboog ;;
        4) save_user_history_root ;;
        esac
}
save_user_history_poelstra() {
        cat /home/a-poelstd/.bash_history >> /tmp/PoelstraHistory.txt
        echo ""
        echo "Saved as /tmp/PoelstraHistory.txt"
}
save_user_history_kastermans() {
        cat /home/a-tkastermans/.bash_history >> /tmp/KastermansHistory.txt
        echo ""
        echo "Saved as /tmp/KastermansHistory.txt"
}
save_user_history_regenboog() {
        cat /home/a-eregenboog/.bash_history >> /tmp/RegenboogHistory.txt
        echo ""
        echo "Saved as /tmp/RegenboogHistory.txt"
}
save_user_history_root() {
        cat /root/.bash_history >> /tmp/RootHistory.txt
        echo ""
        echo "Saved as /tmp/root.txt"
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
                author="Dylan Poelstra"
                printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"
                printf "%*s\n" $(((${#author}+$COLUMNS)/2)) "$author"
        fi
        echo ""
        echo "          1 - Check for updates with yum                          5- List current running processes"
        echo "          2 - Host Information                                    6- Command history"
        echo "          3 - Currently logged in users / History                 7- Test "
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
