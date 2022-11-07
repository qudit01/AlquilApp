import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbomodals"
export default class extends Controller {
  // connect() {
  //   console.log("hola")
  // }

  submitEnd(e) {
      this.hideModal()
  }
  
  hideModal(){
    this.element.remove()
  }
}
