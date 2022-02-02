function alerts() {
    const btn_close = document.querySelectorAll('.btn-close'),
        remove_alert = (alert) => {
            var fadeEffect = setInterval(function () {
                if (!alert.style.opacity) {
                    alert.style.opacity = 1;
                }
                if (alert.style.opacity > 0) {
                    alert.style.opacity -= 0.1;
                } else {
                    clearInterval(fadeEffect);
                    alert.style.display = 'none';
                }
            }, 50);
        }

    btn_close.forEach(btn => {
        const alert = btn.closest('.alert')

        setTimeout(() => remove_alert(alert), 5000);
        btn.addEventListener('click', () => remove_alert(alert))
    })
}
export { alerts }