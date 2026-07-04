import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "preview", "placeholder" ]

  openFileWindow() {
    this.inputTarget.click()
  }

  previewImage() {
    const file = this.inputTarget.files[0]
    if (!file) return

    this.previewTarget.src = URL.createObjectURL(file)
    this.previewTarget.classList.remove("hidden")
    this.placeholderTarget.classList.add("hidden")
  }
}
