import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "button", "label", "panel", "option", "checkmark"]

  connect() {
    this.closeOnOutsideClick = (event) => {
      if (!this.element.contains(event.target)) this.close()
    }
    document.addEventListener("click", this.closeOnOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnOutsideClick)
  }

  toggle(event) {
    event.stopPropagation()
    this.panelTarget.classList.toggle("hidden")
  }

  close() {
    this.panelTarget.classList.add("hidden")
  }

  select(event) {
    const option = event.currentTarget
    const { value, label } = option.dataset

    this.selectTarget.value = value
    this.selectTarget.dispatchEvent(new Event("change", { bubbles: true }))
    this.labelTarget.textContent = label

    this.optionTargets.forEach((el) => {
      el.classList.toggle("bg-green-50", el.dataset.value === value)
      el.classList.toggle("text-green-700", el.dataset.value === value)
      el.classList.toggle("font-medium", el.dataset.value === value)
    })

    this.checkmarkTargets.forEach((el) => {
      el.classList.toggle("hidden", el.dataset.value !== value)
    })

    this.close()
  }
}
