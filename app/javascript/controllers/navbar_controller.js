import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    expand() {
        const navbar = this.element
        const expandBtn = navbar.querySelector('.nav-left-mobile .btn.btn-primary-border')
        const iconClassList = expandBtn.querySelector('i').classList

        if (navbar.classList.toggle('expanded')) {
            iconClassList.replace('la-bars', 'la-times')
        } else {
            iconClassList.replace('la-times', 'la-bars')
        }
    }
}
