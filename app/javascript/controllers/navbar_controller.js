import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    expand() {
        const navMenu = this.element.querySelector('.nav-menu')
        navMenu.style.display = 'flex';
    }

    collapse() {
        const navMenu = this.element.querySelector('.nav-menu')
        navMenu.style.display = 'none';
    }
}
