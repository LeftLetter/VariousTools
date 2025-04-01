# Function to check and connect a device based on its status
pair_device() {
    local DEVICE_ID="$1"

    # ペアリング状態をチェック（paired-devicesの出力から確認）
    local is_paired=$(/opt/homebrew/bin/blueutil --paired | grep -i "$DEVICE_ID" > /dev/null && echo "1" || echo "0")
    # 接続状態をチェック
    local connected=$(/opt/homebrew/bin/blueutil --is-connected $DEVICE_ID)

    if [[ "$connected" = '1' ]]; then
        # すでに接続済みの場合は何もしない
        echo "デバイス $DEVICE_ID は既に接続されています"
    elif [[ "$is_paired" = '1' ]]; then
        # ペアリング済みだが未接続の場合は接続を試みる
        echo "デバイス $DEVICE_ID は未接続です。接続を試みます..."
        /opt/homebrew/bin/blueutil --connect $DEVICE_ID
        sleep 1
        # 接続が成功したか確認
        if [[ $(/opt/homebrew/bin/blueutil --is-connected $DEVICE_ID) = '1' ]]; then
            echo "接続に成功しました"
        else
            echo "接続に失敗しました"
        fi
    else
        # ペアリングされていない場合は、ペアリングして接続
        echo "デバイス $DEVICE_ID は未ペアリングです。ペアリングを試みます..."
        /opt/homebrew/bin/blueutil --pair $DEVICE_ID
        sleep 1
        /opt/homebrew/bin/blueutil --connect $DEVICE_ID
        sleep 1
        # ペアリングと接続が成功したか確認
        if [[ $(/opt/homebrew/bin/blueutil --is-connected $DEVICE_ID) = '1' ]]; then
            echo "ペアリングと接続に成功しました"
        else
            echo "ペアリングまたは接続に失敗しました"
        fi
    fi
}

# Magic Keyboard ID
MAGIC_KEYBOARD_ID="1c-1d-d3-7c-b0-80"

# Call the function with the Magic Keyboard ID
pair_device $MAGIC_KEYBOARD_ID
