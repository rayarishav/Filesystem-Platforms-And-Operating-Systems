#!/bin/bash

cowsay -f tux "Welcome to filesystem
               Greetings form this Penguin"

while true; do

    echo ""
    echo "Select an option:"
    echo "1. Work with a file"
    echo "2. Work with a directory"
    
    echo ""
    echo "Enter 'exi' to exit"
    read choice

    if [ "$choice" = "exi" ]; then
        echo "Exiting..."
        break
    fi

    if [ "$choice" -eq 1 ]; then
	echo ""
        echo "Choose an operation for the file:"
        echo "0. REMOVE file"
        echo "1. Create file"
        echo "2. Read file"
        echo "3. Edit file"
        echo "4. Change permissions"
        echo "5. Add or change User or group"
        echo "6. Change file path"
        echo "7. Long list"
        echo "8. Show present working directory"
        echo "9. Change directory"
        read operation

        case "$operation" in
            0)
                read -p "Enter the filename to remove: " filename
                rm -i "$filename"
                ;;
            1)
                read -p "Enter the filename: " filename
                touch "$filename"
                echo "File created: $filename"
                ;;
            2)
                read -p "Enter the filename to read: " filename
                if [ -f "$filename" ]; then
                    cat "$filename"
                else
                    echo "File not found: $filename"
                fi
                ;;
            3)
                read -p "Enter the filename to edit: " filename
                if [ -f "$filename" ]; then
                    read -p "Choose a text editor (Vim/Nano): " editor
                    case "$editor" in
                        "Vim" | "vim")
                            vim "$filename"
                            ;;
                        "Nano" | "nano")
                            nano "$filename"
                            ;;
                        *)
                            echo "Invalid editor choice."
                            ;;
                    esac
                else
                    echo "File not found: $filename"
                fi
                ;;
           
            4)
                read -p "Enter the path to change permissions: " path
                if [ -e "$path" ]; then
                    read -p "Enter new permissions (r=4, w=2, x=1): " permissions
                    chmod "$permissions" "$path"
                    echo "Permissions changed for $path"
                else
                    echo "Path not found: $path"
                fi
                ;;
            5)
                read -p "Enter the user or group: " user_or_group
                read -p "Enter the path: " path
                read -p "Enter 'U' to change owner or 'G' to change group: " change

                if [ "$change" == "U" ]; then
                    chown "$user_or_group" "$path"
                    echo "Owner changed to $user_or_group for $path"
                elif [ "$change" == "G" ]; then
                    chgrp "$user_or_group" "$path"
                    echo "Group changed to $user_or_group for $path"
                else
                    echo "Invalid choice."
                fi
                ;;
            6)
                read -p "Enter the current filename: " current_file
                read -p "Enter the new filename or path: " new_file
                mv "$current_file" "$new_file"
                echo "File path changed."
                ;;
            7)
                ls -al
                ;;
            8)
                pwd
                ;;
            9)
                read -p "Enter the directory path: " new_dir
                cd "$new_dir" || echo "Directory not found."
                ;;
            *)
                echo "Invalid operation choice."
                ;;
        esac

    elif [ "$choice" -eq 2 ]; then
	echo ""
        echo "Choose an operation for the directory:"
        echo "0. REMOVE directory"
        echo "1. Create directory"
        echo "2. Execute directory"
        echo "3. Change permissions"
        echo "4. Add or change User or group"
        echo "5. Change directory path"
        echo "6. Compress directory"
        echo "7. Decompress directory"
        echo "8. Long list"
        echo "9. Show present working directory"
        echo "10. Change current directory"
        read operation

        case "$operation" in
            0)
                read -p "Enter the directory name to remove: " dirname
                rm -ri "$dirname"
                ;;
            1)
                read -p "Enter the directory name: " dirname
                mkdir "$dirname"
                echo "Directory created: $dirname"
                ;;
            2)
                read -p "Enter the path to execute: " path
                if [ -e "$path" ]; then
                    chmod +x "$path"
                    "$path"
                else
                    echo "Path not found: $path"
                fi
                ;;
            3)
                read -p "Enter the path to change permissions: " path
                if [ -e "$path" ]; then
                    read -p "Enter new permissions (e.g., 755): " permissions
                    chmod "$permissions" "$path"
                    echo "Permissions changed for $path"
                else
                    echo "Path not found: $path"
                fi
                ;;
            4)
                read -p "Enter the user or group: " user_or_group
                read -p "Enter the path: " path
                chown "$user_or_group" "$path"
                echo "Owner changed to $user_or_group for $path"
                ;;
            5)
                read -p "Enter the current directory name: " current_dir
                read -p "Enter the new directory name or path: " new_dir
                mv "$current_dir" "$new_dir"
                echo "Directory path changed."
                ;;
            6)
                read -p "Enter the directory name to compress: " dirname
                tar -czvf "$dirname.tar.gz" "$dirname"
                ;;
            7)
                read -p "Enter the compressed file name: " compressed_filename
                tar -xzvf "$compressed_filename"
                ;;
            8)
                ls -al
                ;;
            9)
                pwd
                ;;
            10)
                read -p "Enter the directory path: " new_dir
                cd "$new_dir" || echo "Directory not found."
                ;;
            *)
                echo "Invalid operation choice."
                ;;
        esac

    else
        echo "Invalid choice."
    fi
done
