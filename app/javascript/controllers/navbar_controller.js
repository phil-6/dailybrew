import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "menu", "background" ]

    initialize() {
        this.menuTarget.hidden = true
        this.backgroundTarget.hidden = true
    }

    open() {
        this.menuTarget.hidden = false
        this.backgroundTarget.hidden = false
    }

    close() {
        this.menuTarget.hidden = true
        this.backgroundTarget.hidden = true
    }
}
