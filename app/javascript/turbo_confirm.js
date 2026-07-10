import { Turbo } from "@hotwired/turbo-rails"

function showTurboConfirm(message) {
  const dialog = document.getElementById("turbo-confirm-dialog")
  if (!dialog) return Promise.resolve(window.confirm(message))

  dialog.querySelector("[data-turbo-confirm-message]").textContent = message

  return new Promise((resolve) => {
    const acceptButton = dialog.querySelector("[data-turbo-confirm-accept]")
    const cancelButton = dialog.querySelector("[data-turbo-confirm-cancel]")

    const cleanUp = (result) => {
      dialog.close()
      acceptButton.removeEventListener("click", onAccept)
      cancelButton.removeEventListener("click", onCancel)
      dialog.removeEventListener("cancel", onCancel)
      resolve(result)
    }

    const onAccept = () => cleanUp(true)
    const onCancel = () => cleanUp(false)

    acceptButton.addEventListener("click", onAccept)
    cancelButton.addEventListener("click", onCancel)
    dialog.addEventListener("cancel", onCancel)

    dialog.showModal()
  })
}

Turbo.config.forms.confirm = showTurboConfirm
