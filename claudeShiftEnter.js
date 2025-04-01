// Claude DesltopをEnter改行にするスクリプト

const handleKeydown = (event) => {
  if (!event.isTrusted) {
    console.log('シミュレートされたイベントなのでスキップします')
    return
  }

  console.log('keydownイベントが発生しました', event)
  const isEnter = event.key === 'Enter'
  const isModifierPressed = event.shiftKey || event.ctrlKey || event.altKey || event.metaKey

  if (isEnter && !isModifierPressed) {
    console.log('Enterキーが押されました')
    // デフォルトの動作を防止
    event.preventDefault()
    event.stopPropagation()

    // 現在フォーカスされている要素
    const target = event.target

    // Shift+Enterをシミュレート
    const shiftEnterEvent = new KeyboardEvent('keydown', {
      key: 'Enter',
      code: 'Enter',
      keyCode: 13,
      which: 13,
      shiftKey: true,
      bubbles: true,
      cancelable: true,
    })

    // Shift+Enterイベントをディスパッチ
    target.dispatchEvent(shiftEnterEvent)

    console.log('Enterが無効化され、Shift+Enterに変換されました')
  } else {
    console.log('Enter以外のキーが押されました')
  }
}

const entry = () => {
  window.addEventListener('keydown', handleKeydown, { capture: true })
  window.customScriptEnabled = true
}

entry() && console.log('スクリプトが正常に実行されました')
