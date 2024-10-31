DROP DATABASE IF EXISTS scotiabank;
CREATE DATABASE scotiabank CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE scotiabank;

CREATE TABLE clientes (
    idCliente INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dni CHAR(10),
    nombres VARCHAR(50),
    apellidoPat VARCHAR(100),
    apellidoMat VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    tarjeta VARCHAR(100),
    claveCaj CHAR(4), -- clave de cajero
    password VARCHAR(100)
);

CREATE TABLE cuentas (
    idCuenta INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idCliente INT UNSIGNED NOT NULL,
    numeroCuenta VARCHAR(20) NOT NULL, 
    tipoCuenta VARCHAR(50) NOT NULL,
    saldo DECIMAL(15, 2) NOT NULL DEFAULT 0,
    estado ENUM('activa', 'inactiva', 'bloqueada') NOT NULL DEFAULT 'activa',
    fechaApertura DATE NOT NULL,
    CONSTRAINT fk_cuentas_clientes FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE transacciones (
    idTransaccion INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idCuenta INT UNSIGNED NOT NULL,
    tipoTransaccion ENUM('deposito', 'retiro', 'transferencia') NOT NULL,
    monto DECIMAL(15, 2) NOT NULL,
    fechaTransaccion DATETIME NOT NULL,
    idCuentaDestino INT UNSIGNED,
    CONSTRAINT fk_transacciones_cuentas FOREIGN KEY (idCuenta) REFERENCES cuentas(idCuenta),
    CONSTRAINT fk_transacciones_cuentas_destino FOREIGN KEY (idCuentaDestino) REFERENCES cuentas(idCuenta)
);

CREATE TABLE prestamos (
    idPrestamo INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idCliente INT UNSIGNED NOT NULL,
    montoPrestamo DECIMAL(15, 2) NOT NULL,
    fechaInicio DATE NOT NULL,
    plazoMeses INT NOT NULL,
    tasaInteres DECIMAL(5, 2) NOT NULL,
    estado ENUM('aprobado', 'rechazado', 'pendiente') NOT NULL DEFAULT 'pendiente',
    CONSTRAINT fk_prestamos_clientes FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE pagosProgramados (
    idPago INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idPrestamo INT UNSIGNED NOT NULL,
    fechaPago DATE NOT NULL,
    montoPago DECIMAL(15, 2) NOT NULL,
    estado ENUM('pendiente', 'realizado') NOT NULL DEFAULT 'pendiente',
    CONSTRAINT fk_pagos_prestamos FOREIGN KEY (idPrestamo) REFERENCES prestamos(idPrestamo)
);

CREATE TABLE seguros (
    idSeguro INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    tipoSeguro VARCHAR(100) NOT NULL,
    cobertura TEXT,
    primaMensual DECIMAL(15, 2) NOT NULL,
    CONSTRAINT fk_seguros_clientes FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

INSERT INTO clientes (dni, nombres, apellidoPat, apellidoMat, telefono, email, tarjeta, claveCaj, password)
VALUES 
('11111111', 'Edward', 'Hinojosa', 'Cardenas', '999888888', 'ehinojosa@unsa.edu.pe', '4837123412349999', '1234', 'mypassword'),
('22222222', 'María', 'García', 'Pérez', '999777777', 'mgarcia@example.com', '4837123412348888', '5678', 'password1'),
('33333333', 'Juan', 'López', 'Gómez', '999666666', 'jlopez@example.com', '4837123412347777', '4321', 'password2'),
('44444444', 'Ana', 'Martínez', 'Sánchez', '999555555', 'amartinez@example.com', '4837123412346666', '9876', 'password3'),
('55555555', 'Pedro', 'Rodríguez', 'Fernández', '999444444', 'prodriguez@example.com', '4837123412345555', '7890', 'password4');

INSERT INTO cuentas (idCliente, numeroCuenta, tipoCuenta, saldo, estado, fechaApertura)
VALUES
(1, '001-001-000000001', 'Cuenta Corriente', 10000.00, 'activa', '2023-01-01'),
(2, '001-001-000000002', 'Cuenta de Ahorros', 5000.00, 'activa', '2023-01-15'),
(3, '001-001-000000003', 'Cuenta Corriente', 8000.00, 'activa', '2023-02-01'),
(4, '001-001-000000004', 'Cuenta de Ahorros', 3000.00, 'inactiva', '2023-02-15'),
(5, '001-001-000000005', 'Cuenta Corriente', 12000.00, 'activa', '2023-03-01');

INSERT INTO transacciones (idCuenta, tipoTransaccion, monto, fechaTransaccion, idCuentaDestino)
VALUES
(1, 'deposito', 500.00, '2023-01-02 10:00:00', NULL),
(2, 'retiro', 200.00, '2023-01-16 15:30:00', NULL),
(3, 'transferencia', 1000.00, '2023-02-02 12:00:00', 2),
(4, 'deposito', 800.00, '2023-02-16 09:45:00', NULL),
(5, 'retiro', 300.00, '2023-03-02 14:20:00', NULL);

INSERT INTO prestamos (idCliente, montoPrestamo, fechaInicio, plazoMeses, tasaInteres, estado)
VALUES
(1, 8000.00, '2023-01-10', 12, 12.0, 'aprobado'),
(2, 5000.00, '2023-01-20', 6, 15.0, 'pendiente'),
(3, 10000.00, '2023-02-05', 24, 10.0, 'aprobado'),
(4, 3000.00, '2023-02-20', 12, 8.0, 'rechazado'),
(5, 12000.00, '2023-03-05', 18, 11.0, 'pendiente');

INSERT INTO pagosProgramados (idPrestamo, fechaPago, montoPago, estado)
VALUES
(1, '2023-02-10', 700.00, 'pendiente'),
(2, '2023-02-25', 1000.00, 'pendiente'),
(3, '2023-03-05', 500.00, 'pendiente'),
(4, '2023-03-20', 400.00, 'realizado'),
(5, '2023-04-05', 1500.00, 'pendiente');

INSERT INTO seguros (idCliente, tipoSeguro, cobertura, primaMensual)
VALUES
(1, 'Salud', 'Cobertura completa de salud', 100.00),
(2, 'Vida', 'Cobertura completa de vida', 200.00),
(3, 'Automóvil', 'Cobertura completa de automóvil', 150.00),
(4, 'Hogar', 'Cobertura completa de hogar', 80.00),
(5, 'Viaje', 'Cobertura completa de viaje', 50.00);


