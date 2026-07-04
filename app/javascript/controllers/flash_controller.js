import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add("opacity-0", "-translate-y-8")

      setTimeout(() => {
        this.element.remove()
      }, 700)
    }, 2500)
  }
}
