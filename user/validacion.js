

function isEmpty(value) {
    return (value === null || value.trim() === '');
}

function login() {

    var dni = document.getElementById('dni').value;
    var tarjeta = document.getElementById('tarjeta').value;
    var claveCaj = document.getElementById('claveCaj').value;
    var password = document.getElementById('password').value;

    if (isEmpty(dni) || isEmpty(tarjeta) || isEmpty(claveCaj) || isEmpty(password)) {
        alert('Todos los campos son obligatorios');
        return false;
    }
    return true;
 }

 function validarRegister() {
    var dni = document.getElementById('dni').value.trim();
    var nombres = document.getElementById('nombres').value.trim();
    var apellidoPat = document.getElementById('apellidoPat').value.trim();
    var apellidoMat = document.getElementById('apellidoMat').value.trim();
    var telefono = document.getElementById('telefono').value.trim();
    var email = document.getElementById('email').value.trim();
    var tarjeta = document.getElementById('tarjeta').value.trim();
    var claveCaj = document.getElementById('claveCaj').value.trim();
    var password = document.getElementById('password').value.trim();

    if (isEmpty(dni) || isEmpty(nombres) || isEmpty(apellidoPat) || isEmpty(apellidoMat) || isEmpty(telefono) || isEmpty(email) || isEmpty(tarjeta) || isEmpty(claveCaj) || isEmpty(password)) {
        alert('Todos los campos son obligatorios');
        return false;
    }

    // Aquí puedes agregar más validaciones si es necesario, como por ejemplo:
    // - Validación específica para cada campo (longitud, formato, etc.)
    // - Validación de correo electrónico usando expresiones regulares

    return true;
}