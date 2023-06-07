#!/bin/bash

# User Addition Script
add_user() {
    read -p "Enter username: " username
    read -p "Enter password: " -s password
    echo
    useradd $username
    echo "$username:$password" | chpasswd
    echo "User $username successfully created."
}

# User Removal Script
remove_user() {
    read -p "Enter username to delete: " username
    userdel $username
    echo "User $username successfully deleted."
}

# User Update Script
update_user() {
    read -p "Enter username to update: " username
    read -p "Enter new username (leave blank to keep the same): " new_username
    if [ -n "$new_username" ]; then
        usermod -l $new_username $username
        username=$new_username
    fi
    read -p "Enter new password (leave blank to keep the same): " -s new_password
    echo
    if [ -n "$new_password" ]; then
        echo "$username:$new_password" | chpasswd
    fi
    echo "User $username successfully updated."
}

# Permission Modification Script
modify_permissions() {
    read -p "Enter file/directory path: " filepath
    read -p "Enter new owner (leave blank to keep the same): " new_owner
    read -p "Enter new permissions in octal format (leave blank to keep the same): " new_permissions
    if [ -n "$new_owner" ]; then
        chown $new_owner $filepath
    fi
    if [ -n "$new_permissions" ]; then
        chmod $new_permissions $filepath
    fi
    echo "Permissions for $filepath successfully modified."
}

# Main Menu
while true; do
    echo "User Management and Permission Scripting"
    echo "1. Add User"
    echo "2. Remove User"
    echo "3. Update User"
    echo "4. Modify Permissions"
    echo "5. Exit"
    read -p "Enter your choice (1-5): " choice

    case $choice in
        1) add_user ;;
        2) remove_user ;;
        3) update_user ;;
        4) modify_permissions ;;
        5) exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac

    echo
done
