import { Turbo } from "@hotwired/turbo-rails"

document.addEventListener("click", (event) => {
  const row = event.target.closest("[data-row-link]")
  if (!row) return
  if (event.target.closest("a, button")) return

  Turbo.visit(row.dataset.rowLink)
})
