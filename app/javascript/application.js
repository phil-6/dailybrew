// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import * as Navbar from "./custom/navbar.js"
window.Navbar = Navbar
