import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    expand() {
        const navbar = this.element,
            navMenu = navbar.querySelector('.nav-menu'),
            navMenuBackground = navbar.querySelector('.nav-menu-background')

        navMenu.style.display = 'flex'
        navMenuBackground.style.display = 'block'
    }

    collapse() {
        const navbar = this.element,
            navMenu = navbar.querySelector('.nav-menu'),
            navMenuBackground = navbar.querySelector('.nav-menu-background')

        navMenu.style.display = 'none'
        navMenuBackground.style.display = 'none'
    }
}
