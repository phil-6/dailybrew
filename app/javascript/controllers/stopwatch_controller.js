import {Controller} from "@hotwired/stimulus"

let startTime;
let elapsedTime = 0;
let timerInterval;

function timeToString(time) {
    let diffInHrs = time / 3600000;
    let hh = Math.floor(diffInHrs);

    let diffInMin = (diffInHrs - hh) * 60;
    let mm = Math.floor(diffInMin);

    let diffInSec = (diffInMin - mm) * 60;
    let ss = Math.floor(diffInSec);

    let diffInMs = (diffInSec - ss) * 100;
    let ms = Math.floor(diffInMs);

    let formattedMM = mm.toString().padStart(2, "0");
    let formattedSS = ss.toString().padStart(2, "0");
    let formattedMS = ms.toString().padStart(2, "0");

    return `${formattedMM}:${formattedSS}:${formattedMS}`;
}

export default class extends Controller {
    static targets = ["display", "start", "pause", "reset"]
    initialize() {
        this.pauseTarget.hidden = true
    }

    start() {
        let display = this.displayTarget
        startTime = Date.now() - elapsedTime;

        timerInterval = setInterval(function printTime() {
            elapsedTime = Date.now() - startTime;
            display.textContent = (timeToString(elapsedTime));
        }, 10);

        this.startTarget.hidden = true
        this.pauseTarget.hidden = false
    }

    pause() {
        clearInterval(timerInterval);
        this.pauseTarget.hidden = true
        this.startTarget.hidden = false
    }

    reset() {
        clearInterval(timerInterval);
        this.displayTarget.textContent = "00:00:00";
        elapsedTime = 0;
        this.pauseTarget.hidden = true
        this.startTarget.hidden = false
    }
}