function navbar() {

    const navbar = document.querySelector('nav.navbar'),
        nav_mobile_expand = navbar.querySelector('.nav-mobile-expand'),
        icon_class_list = nav_mobile_expand.querySelector('i').classList

    nav_mobile_expand.addEventListener('click', () => {
        if (navbar.classList.toggle('expanded')) {
            icon_class_list.replace('fa-bars', 'fa-times')
        } else {
            icon_class_list.replace('fa-times', 'fa-bars')
        }
    })
}
export { navbar }