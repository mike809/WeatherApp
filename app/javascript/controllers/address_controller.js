import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if(window.google) {
      this.initGoogle()
    }
  }

  initGoogle() {
    const input = document.getElementById('autocomplete')
    new google.maps.places.Autocomplete(input)
  }

}
