import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview_img"
export default class extends Controller {
  // connect() {
  //   console.log("hola")
  // }

  readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev')
          .attr('src', e.target.result)
          .width(150)
          .height(200);
      };

      reader.readAsDataURL(input.files[0]);
      $('#img_prev').css(display, 'block');
    }
  }
}
