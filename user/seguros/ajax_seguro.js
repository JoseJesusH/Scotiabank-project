


const isEmpty = (str) => typeof str !== 'string' || str.trim() === '';

function agregar(event) {
    event.preventDefault();  

    var idCliente = document.getElementById('idCliente').value;
    var tipoSeguro = document.getElementById('tipoSeguro').value;
    var cobertura = document.getElementById('cobertura').value;
    var primaMensual = document.getElementById('primaMensual').value;

    if (isEmpty(tipoSeguro) || isEmpty(cobertura) || isEmpty(primaMensual)) {
        alert('Debe ingresar todos los campos');
        return;
    }

    console.log("Datos a enviar:", { idCliente, tipoSeguro, cobertura, primaMensual });

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

    ajax.open("POST", "ajax_seguro.jsp", true); // true para activar el modo asíncrono
    ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    ajax.send("idCliente=" + encodeURIComponent(idCliente) +
                "&tipoSeguro=" + encodeURIComponent(tipoSeguro) +
                "&cobertura=" + encodeURIComponent(cobertura) +
                "&primaMensual=" + encodeURIComponent(primaMensual)
            );
}

function validar() {
    var btnAgregar = document.getElementById("btnAgregar");
    btnAgregar.addEventListener("click", agregar);
}

window.addEventListener("load", validar);

