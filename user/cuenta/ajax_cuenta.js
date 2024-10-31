const isEmpty = (str) => typeof str !== 'string' || str.trim() === '';

function obtenerFechaActual() {
    var fechaActual = new Date();
    var anio = fechaActual.getFullYear();
    var mes = fechaActual.getMonth() + 1; // Los meses van de 0 (enero) a 11 (diciembre)
    var dia = fechaActual.getDate();
    var horas = fechaActual.getHours();
    var minutos = fechaActual.getMinutes();
    var segundos = fechaActual.getSeconds();
    
    var fechaFormateada = anio + '-' + (mes < 10 ? '0' : '') + mes + '-' + (dia < 10 ? '0' : '') + dia;
    var horaFormateada = (horas < 10 ? '0' : '') + horas + ':' + (minutos < 10 ? '0' : '') + minutos + ':' + (segundos < 10 ? '0' : '') + segundos;

    return fechaFormateada;
}

function generarNumeroCuenta() {
    // Genera un número de cuenta en el formato '001-001-000000005'
    var banco = '001';
    var sucursal = '001';
    var cuenta = Math.floor(Math.random() * 1000000000).toString().padStart(9, '0');
    return `${banco}-${sucursal}-${cuenta}`;
}

function agregar(event) {
    event.preventDefault();  

    var idCliente = document.getElementById('idCliente').value;
    var numeroCuenta = generarNumeroCuenta(); 
    var tipoCuenta = document.getElementById('tipoCuenta').value; // Obtiene el tipo de cuenta del select
    var saldo = document.getElementById('saldo').value;
    var estado = document.getElementById('estado').value;
    var fechaApertura = obtenerFechaActual(); 

    if (tipoCuenta === 'Tipo de Cuenta:') {
        alert('Debe seleccionar el tipo de cuenta');
        return;
    }

    if (isEmpty(saldo)) {
        alert('Debe ingresar un monto');
        return;
    }

    console.log("Datos a enviar:", { idCliente, numeroCuenta, tipoCuenta, saldo, estado, fechaApertura });

    var contenido = document.getElementById("contenido");

    var ajax;
    if (window.XMLHttpRequest) {
        ajax = new XMLHttpRequest();
    } else {
        ajax = new ActiveXObject("Microsoft.XMLHTTP");
    }

    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4 && ajax.status == 200) {
            console.log("Respuesta del servidor:", ajax.responseText);
            contenido.innerHTML = ajax.responseText;
        } else {
            console.error("Error al cargar los datos:", ajax.status, ajax.statusText);
            console.error("\nReadyState:", ajax.readyState);
            contenido.innerHTML = "<img width='50' src='../../img/carga.gif'>";
        }
    };

    /*
    ajax.onreadystatechange = function() {
        if (ajax.readyState == 4) {
            if (ajax.status == 200) {
                console.log("Respuesta del servidor:", ajax.responseText);
                contenido.innerHTML = ajax.responseText;
            } else {
                console.error("problemas en state\n");
                console.error("Error al cargar los datos:", ajax.status, ajax.statusText);
                console.error("\nReadyState:", ajax.readyState);
                contenido.innerHTML = "<img width='50' src='../../img/carga.gif'>";
            }
        } else {
            console.error("\nel problemas en ReadyState:", ajax.readyState);
            return;
        }
    };
    */


    ajax.open("POST", "ajax_cuenta.jsp", true); // true para activar el modo asíncrono
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("idCliente=" + encodeURIComponent(idCliente) +
                "&numeroCuenta=" + encodeURIComponent(numeroCuenta) +
                "&tipoCuenta=" + encodeURIComponent(tipoCuenta) +
                "&saldo=" + encodeURIComponent(saldo) +
                "&estado=" + encodeURIComponent(estado) +
                "&fechaApertura=" + encodeURIComponent(fechaApertura)
            );


}

function validar() {
    var btnAgregar = document.getElementById("btnAgregar");
    btnAgregar.addEventListener("click", agregar);
}

window.addEventListener("load", validar);
