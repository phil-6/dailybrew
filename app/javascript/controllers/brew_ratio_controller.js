import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["waterWeight", "coffeeWeight", "ratio"]

    connect() {
        this.ratioTarget.innerHTML = (this.waterWeight / this.coffeeWeight).toPrecision(3)
    }

    get waterWeight() {
        return this.waterWeightTarget.value ? this.waterWeightTarget.value : this.waterWeightTarget.innerHTML
    }

    get coffeeWeight() {
        return this.coffeeWeightTarget.value ? this.coffeeWeightTarget.value : this.coffeeWeightTarget.innerHTML
    }
}