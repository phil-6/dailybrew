import { Controller } from "@hotwired/stimulus"

const navbar = document.querySelector('nav'),
      navMenu = navbar.querySelector('.nav-menu'),
      navMenuBackground = navbar.querySelector('.nav-menu-background')

export default class extends Controller {
    expand() {
        navMenu.style.display = 'flex'
        navMenuBackground.style.display = 'block'
    }

    collapse() {
        navMenu.style.display = 'none'
        navMenuBackground.style.display = 'none'
    }
}
