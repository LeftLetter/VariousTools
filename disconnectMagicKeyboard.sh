unpair_device() {
    local DEVICE_ID="$1"
    local res=$(/opt/homebrew/bin/blueutil --is-connected $DEVICE_ID)
    if [[ "$res" = '1' ]]; then
        /opt/homebrew/bin/blueutil --unpair $DEVICE_ID
    fi
}

# Magic Keyboard ID and Magic Trackpad ID
MAGIC_KEYBOARD_ID="1c-1d-d3-7c-b0-80"

# Call the function with the Magic Keyboard and Trackpad IDs
unpair_device $MAGIC_KEYBOARD_ID
