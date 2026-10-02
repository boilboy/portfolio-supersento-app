import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form", "sortInput"]

  submit(event) {
    this.sortInputTarget.value = event.target.value

    this.formTarget.requestSubmit()
  }
}
