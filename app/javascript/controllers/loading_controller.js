import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {

  connect() {
    document.addEventListener('turbo:before-fetch-request', this.startLoading);
    document.addEventListener('turbo:before-fetch-response', this.stopLoading);
  }

  startLoading = () => {
    // Show the spinner element if it exists, otherwise do nothing
    const spinner_html = `
      <div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
          <span class="sr-only">Loading...</span>
        </div>
      </div>`;
    this.element.innerHTML = spinner_html
  }

  stopLoading = () => {
    // Hide the spinner element if it exists, otherwise do nothing
    this.element.innerHTML = '';
  }
}
