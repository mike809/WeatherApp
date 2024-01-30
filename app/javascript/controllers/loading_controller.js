import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {

  connect() {
    console.log('Loading controller connected');

    this.element.addEventListener('turbo:before-fetch-request', this.startLoading);
    this.element.addEventListener('turbo:frame-render', this.stopLoading);
  }

  startLoading = () => {
    console.log('Start loading called');
    this.element.innerHTML = '<div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div>';
  }

  stopLoading = () => {
    console.log('Stop loading called');

    this.element.innerHTML = '';
  }
}
