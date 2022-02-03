import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect(){
        setTimeout(() => this.dismiss(), 5000);
    }

    dismiss () {
        const alert = this.element

        const fadeEffect = setInterval(function () {
            if (!alert.style.opacity) {
                alert.style.opacity = 1;
            }
            if (alert.style.opacity > 0) {
                alert.style.opacity -= 0.1;
            } else {
                clearInterval(fadeEffect);
                alert.style.display = 'none';
            }
        }, 50);

    }
}
