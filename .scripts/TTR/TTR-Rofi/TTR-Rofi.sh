#!/usr/bin/env bash

# File paths
BOOKMARKS_FILE="$HOME/.scripts/TTR/TTR-Rofi/bookmarks.txt"
DIRECTORIES_FILE="$HOME/.scripts/TTR/TTR-Rofi/directories.txt"
APPS_FILE="$HOME/.scripts/TTR/TTR-Rofi/apps.txt"
FILES_FILE="$HOME/.scripts/TTR/TTR-Rofi/files.txt"
SHORTCUTS_FILE="$HOME/.scripts/TTR/TTR-Rofi/shortcuts.txt"
SCRIPTS_FILE="$HOME/.scripts/TTR/TTR-Rofi/scripts.txt"
CHEATSHEET_FILE="$HOME/.scripts/TTR/TTR-Rofi/cheatsheet.txt"

# Temporary file to store the combined list
TEMP_FILE=$(mktemp)

# Command for "All Apps" option
SHOW_DRUN_COMMAND="rofi -show drun -show-icons"
echo "All Apps: $SHOW_DRUN_COMMAND" >> "$TEMP_FILE"

# Combine all entries into the temporary file
{
    echo "Bookmarks:"
    awk -F, '{print "BOOKMARK: " $1}' "$BOOKMARKS_FILE"
    echo "Directories:"
    awk -F, '{print "DIRECTORY: " $1}' "$DIRECTORIES_FILE"
    echo "Applications:"
    awk -F, '{print "APPS: " $1}' "$APPS_FILE"
    echo "Files:"
    awk -F, '{print "FILE: " $1}' "$FILES_FILE"
    echo "Shortcuts:"
    awk -F, '{print "SHORTCUT: " $1, $2}' "$SHORTCUTS_FILE"
    echo "Scripts:"
    awk -F, '{print "CF: " $1}' "$CF_FILE"
    echo "Cheatsheet:"
    awk -F'!!' '{print "CHEATSHEET: " $1 "!!" $2}' "$CHEATSHEET_FILE"
} >> "$TEMP_FILE"

# Display the Rofi menu and get the user's selection
SELECTION=$(cat "$TEMP_FILE" | rofi -dmenu -i -p "Search" -no-fixed-num-lines)

# Debugging output to verify selection
echo "Selection: $SELECTION" >> /tmp/universal_rofi_debug.log

# Process the selection
if [[ $SELECTION == "All Apps: "* ]]; then
    CMD="${SELECTION#"All Apps: "}"
    echo "Executing Command: $CMD" >> /tmp/universal_rofi_debug.log
    setsid $CMD >/dev/null 2>&1 &
elif [[ $SELECTION == BOOKMARK:* ]]; then
    TITLE="${SELECTION#BOOKMARK: }"
    URL=$(awk -F, -v title="$TITLE" '$1 == title {print $2}' "$BOOKMARKS_FILE")
    echo "Opening URL: $URL" >> /tmp/universal_rofi_debug.log
    xdg-open "$URL" && i3-msg workspace 1
elif [[ $SELECTION == DIRECTORY:* ]]; then
    TITLE="${SELECTION#DIRECTORY: }"
    DIRECTORY=$(awk -F, -v title="$TITLE" '$1 == title {print $2}' "$DIRECTORIES_FILE")
    DIRECTORY="${DIRECTORY//\~/$HOME}"
    echo "Opening Directory: $DIRECTORY" >> /tmp/universal_rofi_debug.log
    xdg-open "$DIRECTORY"
elif [[ $SELECTION == APPS:* ]]; then
    TITLE="${SELECTION#APPS: }"
    CMD=$(awk -F, -v title="$TITLE" '$1 == title {print $2}' "$APPS_FILE")
    echo "Executing Command: $CMD" >> /tmp/universal_rofi_debug.log
    $CMD &
elif [[ $SELECTION == FILE:* ]]; then
    TITLE="${SELECTION#FILE: }"
    FILE=$(awk -F, -v title="$TITLE" '$1 == title {print $2}' "$FILES_FILE")
    FILE="${FILE//\~/$HOME}"
    echo "Opening File: $FILE" >> /tmp/universal_rofi_debug.log
    gnome-text-editor "$FILE"
elif [[ $SELECTION == SHORTCUT:* ]]; then
    TITLE="${SELECTION#SHORTCUT: }"
    DESCRIPTION=$(awk -F, -v title="$TITLE" '$1 == title {print $2}' "$SHORTCUTS_FILE")
    echo "Shortcut Description: $DESCRIPTION" >> /tmp/universal_rofi_debug.log
elif [[ $SELECTION == SCRIPT:* ]]; then
    TITLE="${SELECTION#SCRIPT: }"
    SCRIPT_PATH=$(awk -F, -v title="$TITLE" '$1 == title {print $2}' "$SCRIPTS_FILE")
    SCRIPT_PATH="${SCRIPT_PATH//\~/$HOME}"
    echo "Running Script: $SCRIPT_PATH" >> /tmp/universal_rofi_debug.log
    nohup "$SCRIPT_PATH" > /dev/null 2>&1 &
elif [[ $SELECTION == CHEATSHEET:* ]]; then
    # Use awk to extract only the description part
    COMMAND=$(echo "$SELECTION" | awk -F'!!' '{
        # Trim leading and trailing whitespace from the second field
        gsub(/^[ \t]+|[ \t]+$/, "", $2)
        # Print only the second field (the description)
        print $2
    }')

    echo "Formatted Command: $COMMAND" >> /tmp/universal_rofi_debug.log

    # Debugging the clipboard copy process
    if printf "%s" "$COMMAND" | xclip -selection clipboard; then
        notify-send "Command copied to clipboard" "$COMMAND"
    else
        echo "Failed to copy to clipboard using xclip" >> /tmp/universal_rofi_debug.log
        exit 1
    fi
else
    echo "No valid selection made or selection not recognized." >> /tmp/universal_rofi_debug.log
fi

# Clean up
rm "$TEMP_FILE"
