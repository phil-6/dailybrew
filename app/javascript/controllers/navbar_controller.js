import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    expand() {
        const navbar = this.element,
            nav_mobile_expand = navbar.querySelector('.nav-mobile-expand'),
            icon_class_list = nav_mobile_expand.querySelector('i').classList

        if (navbar.classList.toggle('expanded')) {
            icon_class_list.replace('fa-bars', 'fa-times')
        } else {
            icon_class_list.replace('fa-times', 'fa-bars')
        }
    }
}
