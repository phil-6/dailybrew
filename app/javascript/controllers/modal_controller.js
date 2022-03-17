import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    close() {
        this.element.remove()
    }

    closeWithKeyboard(e) {
        if (e.code === "Escape") {
            this.close()
        }
    }
}