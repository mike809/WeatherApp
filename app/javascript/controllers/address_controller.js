import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if(window.google) {
      this.initGoogle()
    }
  }

  initGoogle() {
    const options = { componentRestrictions: { country: "us"} }
    const input = document.getElementById('autocomplete')

    const autocomplete = new google.maps.places.Autocomplete(input, options)
    autocomplete.addListener('place_changed', this.locationChanged.bind(this))
  }

  locationChanged() {
    const event = new Event("submit")
    this.element.dispatchEvent(event)
  }

  preventSubmit(event) {
    console.log('Prevent submit called')
    // event.preventDefault()
  }

}
