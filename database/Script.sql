CREATE TABLE Huespedes (
    HuespedID NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100) NOT NULL,
    Apellido VARCHAR2(100) NOT NULL,
    FechaNacimiento DATE,
    Direccion VARCHAR2(255),
    Telefono VARCHAR2(20),
    Email VARCHAR2(100)
);


CREATE TABLE Empleados (
    EmpleadoID NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100) NOT NULL,
    Apellido VARCHAR2(100) NOT NULL,
    Puesto VARCHAR2(100),
    FechaContratacion DATE,
    Salario NUMBER(10, 2)
);

CREATE TABLE Reservas (
    ReservaID NUMBER PRIMARY KEY,
    HuespedID NUMBER REFERENCES Huespedes(HuespedID),
    HabitacionID NUMBER REFERENCES Habitaciones(HabitacionID),
    FechaEntrada DATE NOT NULL,
    FechaSalida DATE NOT NULL,
    Estado VARCHAR2(50) CHECK (Estado IN ('Pendiente', 'Confirmada', 'Cancelada'))
);


CREATE TABLE Habitaciones (
    HabitacionID NUMBER PRIMARY KEY,
    NumeroHabitacion VARCHAR2(10) NOT NULL,
    TipoHabitacion VARCHAR2(50),
    PrecioPorNoche NUMBER(10, 2),
    Estado VARCHAR2(50) CHECK (Estado IN ('Disponible', 'Ocupada', 'Mantenimiento'))
);



CREATE TABLE Servicios (
    ServicioID NUMBER PRIMARY KEY,
    NombreServicio VARCHAR2(100) NOT NULL,
    Descripcion VARCHAR2(255),
    Precio NUMBER(10, 2)
);


CREATE TABLE Facturacion (
    FacturaID NUMBER PRIMARY KEY,
    ReservaID NUMBER REFERENCES Reservas(ReservaID),
    FechaFactura DATE NOT NULL,
    Total NUMBER(10, 2) NOT NULL
);

CREATE TABLE Inventarios (
    InventarioID NUMBER PRIMARY KEY,
    NombreProducto VARCHAR2(100) NOT NULL,
    CantidadTotal NUMBER NOT NULL,
    UnidadMedida VARCHAR2(50)
);

CREATE TABLE CantidadInventarioPorHabitacion (
    HabitacionID NUMBER REFERENCES Habitaciones(HabitacionID),
    InventarioID NUMBER REFERENCES Inventarios(InventarioID),
    Cantidad NUMBER NOT NULL,
    PRIMARY KEY (HabitacionID, InventarioID)
);

CREATE TABLE Mantenimiento (
    MantenimientoID NUMBER PRIMARY KEY,
    HabitacionID NUMBER REFERENCES Habitaciones(HabitacionID),
    FechaMantenimiento DATE NOT NULL,
    Descripcion VARCHAR2(255),
    Costo NUMBER(10, 2)
);

CREATE TABLE Proveedores (
    ProveedorID NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100) NOT NULL,
    Direccion VARCHAR2(255),
    Telefono VARCHAR2(20),
    Email VARCHAR2(100)
);

--INSERTS

-- Insert into Huespedes
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (1, 'Juan', 'Perez', TO_DATE('1985-01-15', 'YYYY-MM-DD'), '123 Main St', '1234567890', 'juan.perez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (2, 'Maria', 'Lopez', TO_DATE('1990-02-20', 'YYYY-MM-DD'), '456 Elm St', '2345678901', 'maria.lopez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (3, 'Carlos', 'Gonzalez', TO_DATE('1975-03-25', 'YYYY-MM-DD'), '789 Pine St', '3456789012', 'carlos.gonzalez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (4, 'Ana', 'Martinez', TO_DATE('1980-04-30', 'YYYY-MM-DD'), '101 Maple St', '4567890123', 'ana.martinez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (5, 'Luis', 'Garcia', TO_DATE('1995-05-05', 'YYYY-MM-DD'), '202 Oak St', '5678901234', 'luis.garcia@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (6, 'Laura', 'Hernandez', TO_DATE('1988-06-10', 'YYYY-MM-DD'), '303 Cedar St', '6789012345', 'laura.hernandez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (7, 'Miguel', 'Rodriguez', TO_DATE('1983-07-15', 'YYYY-MM-DD'), '404 Birch St', '7890123456', 'miguel.rodriguez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (8, 'Elena', 'Sanchez', TO_DATE('1992-08-20', 'YYYY-MM-DD'), '505 Spruce St', '8901234567', 'elena.sanchez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (9, 'David', 'Ramirez', TO_DATE('1970-09-25', 'YYYY-MM-DD'), '606 Fir St', '9012345678', 'david.ramirez@example.com');
INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) VALUES (10, 'Patricia', 'Diaz', TO_DATE('1985-10-30', 'YYYY-MM-DD'), '707 Ash St', '0123456789', 'patricia.diaz@example.com');

-- Insert into Empleados
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (1, 'Carlos', 'Torres', 'Recepcionista', TO_DATE('2015-01-10', 'YYYY-MM-DD'), 2500.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (2, 'Ana', 'Gutierrez', 'Limpieza', TO_DATE('2016-02-15', 'YYYY-MM-DD'), 1800.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (3, 'Miguel', 'Fernandez', 'Mantenimiento', TO_DATE('2017-03-20', 'YYYY-MM-DD'), 2200.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (4, 'Laura', 'Morales', 'Cocinero', TO_DATE('2018-04-25', 'YYYY-MM-DD'), 2800.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (5, 'Luis', 'Gomez', 'Mesero', TO_DATE('2019-05-30', 'YYYY-MM-DD'), 2000.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (6, 'Elena', 'Vargas', 'Gerente', TO_DATE('2020-06-05', 'YYYY-MM-DD'), 3500.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (7, 'David', 'Castillo', 'Botones', TO_DATE('2021-07-10', 'YYYY-MM-DD'), 1500.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (8, 'Patricia', 'Mendoza', 'Recepcionista', TO_DATE('2022-08-15', 'YYYY-MM-DD'), 2500.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (9, 'Carlos', 'Rojas', 'Limpieza', TO_DATE('2023-09-20', 'YYYY-MM-DD'), 1800.00);
INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) VALUES (10, 'Ana', 'Martinez', 'Cocinero', TO_DATE('2024-10-25', 'YYYY-MM-DD'), 2800.00);

-- Insert into Habitaciones
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (1, '101', 'Simple', 50.00, 'Disponible');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (2, '102', 'Doble', 75.00, 'Disponible');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (3, '103', 'Suite', 150.00, 'Disponible');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (4, '104', 'Simple', 50.00, 'Ocupada');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (5, '105', 'Doble', 75.00, 'Ocupada');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (6, '106', 'Suite', 150.00, 'Disponible');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (7, '107', 'Simple', 50.00, 'Mantenimiento');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (8, '108', 'Doble', 75.00, 'Disponible');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (9, '109', 'Suite', 150.00, 'Disponible');
INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) VALUES (10, '110', 'Simple', 50.00, 'Disponible');

-- Insert into Reservas
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (1, 1, 1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'Confirmada');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (2, 2, 2, TO_DATE('2024-02-10', 'YYYY-MM-DD'), TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Pendiente');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (3, 3, 3, TO_DATE('2024-03-20', 'YYYY-MM-DD'), TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Cancelada');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (4, 4, 4, TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2024-04-10', 'YYYY-MM-DD'), 'Confirmada');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (5, 5, 5, TO_DATE('2024-05-15', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Pendiente');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (6, 6, 6, TO_DATE('2024-06-25', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 'Confirmada');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (7, 7, 7, TO_DATE('2024-07-05', 'YYYY-MM-DD'), TO_DATE('2024-07-10', 'YYYY-MM-DD'), 'Pendiente');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (8, 8, 8, TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-20', 'YYYY-MM-DD'), 'Cancelada');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (9, 9, 9, TO_DATE('2024-09-25', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 'Confirmada');
INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) VALUES (10, 10, 10, TO_DATE('2024-10-05', 'YYYY-MM-DD'), TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'Pendiente');

-- Insert into Servicios
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (1, 'Spa', 'Relaxing spa treatments', 100.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (2, 'Gimnasio', 'Full gym access', 50.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (3, 'Piscina', 'Access to the swimming pool', 30.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (4, 'Desayuno', 'Continental breakfast', 20.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (5, 'Cena', 'Gourmet dinner', 75.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (6, 'Lavanderia', 'Laundry services', 40.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (7, 'Transporte', 'Airport shuttle service', 60.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (8, 'Tour', 'City tour', 80.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (9, 'Masaje', 'Full body massage', 120.00);
INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) VALUES (10, 'Estacionamiento', 'Parking service', 25.00);

-- Insert into Facturacion
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (1, 1, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 200.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (2, 2, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 375.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (3, 4, TO_DATE('2024-04-10', 'YYYY-MM-DD'), 250.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (4, 5, TO_DATE('2024-05-20', 'YYYY-MM-DD'), 375.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (5, 6, TO_DATE('2024-06-30', 'YYYY-MM-DD'), 750.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (6, 7, TO_DATE('2024-07-10', 'YYYY-MM-DD'), 250.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (7, 9, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 750.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (8, 10, TO_DATE('2024-10-10', 'YYYY-MM-DD'), 250.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (9, 3, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 750.00);
INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) VALUES (10, 8, TO_DATE('2024-08-20', 'YYYY-MM-DD'), 375.00);

-- Insert into Inventarios
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (1, 'Jabón', 100, 'Piezas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (2, 'Shampoo', 200, 'Botellas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (3, 'Toallas', 300, 'Piezas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (4, 'Sábanas', 400, 'Piezas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (5, 'Almohadas', 150, 'Piezas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (6, 'Cobijas', 100, 'Piezas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (7, 'Papel Higiénico', 500, 'Rollos');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (8, 'Vasos', 200, 'Piezas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (9, 'Platos', 250, 'Piezas');
INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida) VALUES (10, 'Cucharas', 300, 'Piezas');

-- Insert into CantidadInventarioPorHabitacion
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (1, 1, 5);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (1, 2, 2);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (1, 3, 4);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (2, 1, 5);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (2, 2, 2);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (2, 3, 4);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (3, 1, 5);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (3, 2, 2);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (3, 3, 4);
INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) VALUES (4, 1, 5);

-- Insert into Mantenimiento
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (1, 1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Cambio de sábanas', 50.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (2, 2, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Reparación de aire acondicionado', 100.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (3, 3, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Limpieza de alfombra', 75.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (4, 4, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Pintura de paredes', 150.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (5, 5, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Cambio de lámparas', 60.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (6, 6, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Reparación de ventana', 90.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (7, 7, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Cambio de cortinas', 45.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (8, 8, TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'Reparación de televisión', 110.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (9, 9, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Cambio de colchón', 200.00);
INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo) VALUES (10, 10, TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Limpieza de baño', 30.00);

-- Insert into Proveedores
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (1, 'Proveedores ABC', '123 Proveedor St', '1234567890', 'contacto@proveedoresabc.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (2, 'Distribuciones XYZ', '456 Distribuidor Ave', '2345678901', 'ventas@distribucionesxyz.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (3, 'Suministros QRS', '789 Suministro Blvd', '3456789012', 'info@suministrosqrs.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (4, 'Productos LMN', '101 Producto Rd', '4567890123', 'soporte@productoslmn.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (5, 'Materiales OPQ', '202 Materiales St', '5678901234', 'contacto@materialesopq.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (6, 'Servicios DEF', '303 Servicio Ave', '6789012345', 'ventas@serviciosdef.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (7, 'Implementos UVW', '404 Implemento Blvd', '7890123456', 'info@implementosuvw.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (8, 'Distribuciones TUV', '505 Distribuidor Rd', '8901234567', 'soporte@distribucionestuv.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (9, 'Proveedores GHI', '606 Proveedor St', '9012345678', 'contacto@proveedoresghi.com');
INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono, Email) VALUES (10, 'Suministros JKL', '707 Suministro Ave', '0123456789', 'ventas@suministrosjkl.com');


--VISTAS
CREATE VIEW Vista_Proveedores AS
SELECT 
    ProveedorID, 
    Nombre, 
    Direccion, 
    Telefono, 
    Email
FROM 
    Proveedores;
/
CREATE VIEW Vista_Facturacion AS
SELECT 
    FacturaID, 
    ReservaID, 
    FechaFactura, 
    Total
FROM 
    Facturacion;
/
CREATE VIEW VistaPersonalHotel AS
SELECT 
    EmpleadoID,
    Nombre,
    Apellido,
    Puesto
FROM 
    Empleados;
/
--PARA VER LAS RESERVACIONES ACTUALES
CREATE VIEW VistaReservasActuales AS
SELECT 
    R.ReservaID,
    H.Nombre || ' ' || H.Apellido AS NombreHuesped,
    R.HabitacionID,
    HR.NumeroHabitacion,
    R.FechaEntrada,
    R.FechaSalida,
    R.Estado
FROM 
    Reservas R
JOIN 
    Huespedes H ON R.HuespedID = H.HuespedID
JOIN 
    Habitaciones HR ON R.HabitacionID = HR.HabitacionID
WHERE 
    R.Estado = 'Confirmada';

/
--PARA VER LA FACTURA DETALLADA
CREATE VIEW VistaFacturacionDetallada AS
SELECT 
    F.FacturaID,
    F.ReservaID,
    H.Nombre || ' ' || H.Apellido AS NombreHuesped,
    R.HabitacionID,
    HR.NumeroHabitacion,
    F.FechaFactura,
    F.Total
FROM 
    Facturacion F
JOIN 
    Reservas R ON F.ReservaID = R.ReservaID
JOIN 
    Huespedes H ON R.HuespedID = H.HuespedID
JOIN 
    Habitaciones HR ON R.HabitacionID = HR.HabitacionID;


/
--PARA VER LAS HABITACIONES DSPONIBLES
CREATE VIEW VistaDisponibilidadHabitaciones AS
SELECT 
    HabitacionID,
    NumeroHabitacion,
    TipoHabitacion,
    PrecioPorNoche,
    Estado
FROM 
    Habitaciones
WHERE 
    Estado = 'Disponible';

--PARA VER EL MANTENIMIENTO DE LAS HABITACIONES
CREATE VIEW VistaMantenimientoHabitaciones AS
SELECT 
    M.MantenimientoID,
    M.HabitacionID,
    HR.NumeroHabitacion,
    M.FechaMantenimiento,
    M.Descripcion,
    M.Costo
FROM 
    Mantenimiento M
JOIN 
    Habitaciones HR ON M.HabitacionID = HR.HabitacionID;

/
--PARA VER EL INVENTARIO POR HABITACION 
CREATE VIEW VistaInventarioPorHabitacion AS
SELECT 
    CH.HabitacionID,
    HR.NumeroHabitacion,
    I.NombreProducto,
    CH.Cantidad,
    I.UnidadMedida
FROM 
    CantidadInventarioPorHabitacion CH
JOIN 
    Habitaciones HR ON CH.HabitacionID = HR.HabitacionID
JOIN 
    Inventarios I ON CH.InventarioID = I.InventarioID;

/


-- Vista para ver la Ocupación por Tipo de Habitación
CREATE VIEW VistaOcupacionPorTipoHabitacion AS
SELECT 
    HR.TipoHabitacion,
    COUNT(R.ReservaID) AS ReservasTotales
FROM 
    Reservas R
JOIN 
    Habitaciones HR ON R.HabitacionID = HR.HabitacionID
WHERE 
    R.Estado = 'Confirmada'
GROUP BY 
    HR.TipoHabitacion;


-- Vista para ver el Historial de Reservas de un Huesped
CREATE VIEW VistaHistorialReservas AS
SELECT 
    H.HuespedID,
    H.Nombre || ' ' || H.Apellido AS NombreHuesped,
    R.ReservaID,
    HR.NumeroHabitacion,
    R.FechaEntrada,
    R.FechaSalida,
    R.Estado
FROM 
    Huespedes H
JOIN 
    Reservas R ON H.HuespedID = R.HuespedID
JOIN 
    Habitaciones HR ON R.HabitacionID = HR.HabitacionID;


--PROCEDIMIENTOS


CREATE OR REPLACE PROCEDURE INSERTAR_HUESPED (
  P_HUESPEDID NUMBER,
  P_NOMBRE VARCHAR2,
  P_APELLIDO VARCHAR2,
  P_FECHA_NACIMIENTO DATE,
  P_DIRECCION VARCHAR2,
  P_TELEFONO VARCHAR2,
  P_EMAIL VARCHAR2
) AS
BEGIN
  INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email)
  VALUES (P_HUESPEDID, P_NOMBRE, P_APELLIDO, P_FECHA_NACIMIENTO, P_DIRECCION, P_TELEFONO, P_EMAIL);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_EMPLEADO (
  P_EMPLEADOID NUMBER,
  P_NOMBRE VARCHAR2,
  P_APELLIDO VARCHAR2,
  P_PUESTO VARCHAR2,
  P_FECHA_CONTRATACION DATE,
  P_SALARIO NUMBER
) AS
BEGIN
  INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario)
  VALUES (P_EMPLEADOID, P_NOMBRE, P_APELLIDO, P_PUESTO, P_FECHA_CONTRATACION, P_SALARIO);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_RESERVA (
  P_RESERVAID NUMBER,
  P_HUESPEDID NUMBER,
  P_HABITACIONID NUMBER,
  P_FECHA_ENTRADA DATE,
  P_FECHA_SALIDA DATE,
  P_ESTADO VARCHAR2
) AS
BEGIN
  INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado)
  VALUES (P_RESERVAID, P_HUESPEDID, P_HABITACIONID, P_FECHA_ENTRADA, P_FECHA_SALIDA, P_ESTADO);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_HABITACION (
  P_HABITACIONID NUMBER,
  P_NUMERO_HABITACION VARCHAR2,
  P_TIPO_HABITACION VARCHAR2,
  P_PRECIO_POR_NOCHE NUMBER,
  P_ESTADO VARCHAR2
) AS
BEGIN
  INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado)
  VALUES (P_HABITACIONID, P_NUMERO_HABITACION, P_TIPO_HABITACION, P_PRECIO_POR_NOCHE, P_ESTADO);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_SERVICIO (
  P_NOMBRE_SERVICIO VARCHAR2,
  P_DESCRIPCION VARCHAR2,
  P_PRECIO VARCHAR2
) AS
  P_SERVICIOID NUMBER;
BEGIN
  SELECT Servicio_SEQ.NEXTVAL INTO P_SERVICIOID FROM dual;

  INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio)
  VALUES (P_SERVICIOID, P_NOMBRE_SERVICIO, P_DESCRIPCION, TO_NUMBER(P_PRECIO));
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_FACTURA (
  P_RESERVAID NUMBER,
  P_FECHA_FACTURA DATE,
  P_TOTAL NUMBER
) AS
BEGIN
  INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total)
  VALUES (factura_seq.NEXTVAL, P_RESERVAID, P_FECHA_FACTURA, P_TOTAL);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_INVENTARIO (
  P_INVENTARIOID NUMBER,
  P_NOMBRE_PRODUCTO VARCHAR2,
  P_CANTIDAD_TOTAL NUMBER,
  P_UNIDAD_MEDIDA VARCHAR2
) AS
BEGIN
  INSERT INTO Inventarios (InventarioID, NombreProducto, CantidadTotal, UnidadMedida)
  VALUES (P_INVENTARIOID, P_NOMBRE_PRODUCTO, P_CANTIDAD_TOTAL, P_UNIDAD_MEDIDA);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_CANTIDAD_INVENTARIO_POR_HABITACION (
  P_HABITACIONID NUMBER,
  P_INVENTARIOID NUMBER,
  P_CANTIDAD NUMBER
) AS
BEGIN
  INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad)
  VALUES (P_HABITACIONID, P_INVENTARIOID, P_CANTIDAD);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_MANTENIMIENTO (
  P_HABITACIONID NUMBER,
  P_FECHA_MANTENIMIENTO DATE,
  P_DESCRIPCION VARCHAR2,
  P_COSTO NUMBER
) AS
BEGIN
  INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo)
  VALUES (mantenimiento_seq.NEXTVAL, P_HABITACIONID, P_FECHA_MANTENIMIENTO, P_DESCRIPCION, P_COSTO);
END;
/

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE INSERTAR_PROVEEDOR (
  P_NOMBRE VARCHAR2,
  P_DIRECCION VARCHAR2,
  P_TELEFONO VARCHAR2
) AS
BEGIN
  INSERT INTO Proveedores (ProveedorID, Nombre, Direccion, Telefono)
  VALUES (proveedor_seq.NEXTVAL, P_NOMBRE, P_DIRECCION, P_TELEFONO);
END;
/

-------------------------------------------------------------------------------------
--CRUD ACTUALIZAR
-- para actualizar huesped
CREATE OR REPLACE PROCEDURE ACTUALIZAR_HUESPED (
  P_HUESPEDID NUMBER,
  P_NOMBRE VARCHAR2,
  P_APELLIDO VARCHAR2,
  P_FECHA_NACIMIENTO DATE,
  P_DIRECCION VARCHAR2,
  P_TELEFONO VARCHAR2,
  P_EMAIL VARCHAR2
) AS
BEGIN
  UPDATE Huespedes
  SET
    Nombre = P_NOMBRE,
    Apellido = P_APELLIDO,
    FechaNacimiento = P_FECHA_NACIMIENTO,
    Direccion = P_DIRECCION,
    Telefono = P_TELEFONO,
    Email = P_EMAIL
  WHERE HuespedID = P_HUESPEDID;
END;
/

-- actuakizar empleado
CREATE OR REPLACE PROCEDURE ACTUALIZAR_EMPLEADO (
  P_EMPLEADOID NUMBER,
  P_NOMBRE VARCHAR2,
  P_APELLIDO VARCHAR2,
  P_PUESTO VARCHAR2,
  P_FECHA_CONTRATACION DATE,
  P_SALARIO NUMBER
) AS
BEGIN
  UPDATE Empleados
  SET
    Nombre = P_NOMBRE,
    Apellido = P_APELLIDO,
    Puesto = P_PUESTO,
    FechaContratacion = P_FECHA_CONTRATACION,
    Salario = P_SALARIO
  WHERE EmpleadoID = P_EMPLEADOID;
END;
/

-- actualizar reserve
CREATE OR REPLACE PROCEDURE ACTUALIZAR_RESERVA (
  P_RESERVAID NUMBER,
  P_HUESPEDID NUMBER,
  P_HABITACIONID NUMBER,
  P_FECHA_ENTRADA DATE,
  P_FECHA_SALIDA DATE,
  P_ESTADO VARCHAR2
) AS
BEGIN
  UPDATE Reservas
  SET
    HuespedID = P_HUESPEDID,
    HabitacionID = P_HABITACIONID,
    FechaEntrada = P_FECHA_ENTRADA,
    FechaSalida = P_FECHA_SALIDA,
    Estado = P_ESTADO
  WHERE ReservaID = P_RESERVAID;
END;
/

-- actualizar habitaicon
CREATE OR REPLACE PROCEDURE ACTUALIZAR_HABITACION (
  P_HABITACIONID NUMBER,
  P_NUMERO_HABITACION VARCHAR2,
  P_TIPO_HABITACION VARCHAR2,
  P_PRECIO_POR_NOCHE NUMBER,
  P_ESTADO VARCHAR2
) AS
BEGIN
  UPDATE Habitaciones
  SET
    NumeroHabitacion = P_NUMERO_HABITACION,
    TipoHabitacion = P_TIPO_HABITACION,
    PrecioPorNoche = P_PRECIO_POR_NOCHE,
    Estado = P_ESTADO
  WHERE HabitacionID = P_HABITACIONID;
END;
/

-- actualizar servicio
CREATE OR REPLACE PROCEDURE ACTUALIZAR_SERVICIO (
  P_SERVICIOID NUMBER,
  P_NOMBRE_SERVICIO VARCHAR2,
  P_DESCRIPCION VARCHAR2,
  P_PRECIO NUMBER
) AS
BEGIN
  UPDATE Servicios
  SET
    NombreServicio = P_NOMBRE_SERVICIO,
    Descripcion = P_DESCRIPCION,
    Precio = P_PRECIO
  WHERE ServicioID = P_SERVICIOID;
END;
/

-- update facturas
/* tener cuidado en seguridad porque en un audit estos datos sensibles de facturacion pueden ser editados*/
CREATE OR REPLACE PROCEDURE ACTUALIZAR_FACTURA (
  P_FACTURAID NUMBER,
  P_RESERVAID NUMBER,
  P_FECHA_FACTURA DATE,
  P_TOTAL NUMBER
) AS
BEGIN
  UPDATE Facturacion
  SET
    ReservaID = P_RESERVAID,
    FechaFactura = P_FECHA_FACTURA,
    Total = P_TOTAL
  WHERE FacturaID = P_FACTURAID;
END;
/

-- actualizar inventario
CREATE OR REPLACE PROCEDURE ACTUALIZAR_INVENTARIO (
  P_INVENTARIOID NUMBER,
  P_NOMBRE_PRODUCTO VARCHAR2,
  P_CANTIDAD_TOTAL NUMBER,
  P_UNIDAD_MEDIDA VARCHAR2
) AS
BEGIN
  UPDATE Inventarios
  SET
    NombreProducto = P_NOMBRE_PRODUCTO,
    CantidadTotal = P_CANTIDAD_TOTAL,
    UnidadMedida = P_UNIDAD_MEDIDA
  WHERE InventarioID = P_INVENTARIOID;
END;
/

--  actualizar cant de objetos del invent por habitacion
CREATE OR REPLACE PROCEDURE ACTUALIZAR_CANTIDAD_INVENTARIO_POR_HABITACION (
  P_HABITACIONID NUMBER,
  P_INVENTARIOID NUMBER,
  P_CANTIDAD NUMBER
) AS
BEGIN
  UPDATE CantidadInventarioPorHabitacion
  SET
    Cantidad = P_CANTIDAD
  WHERE HabitacionID = P_HABITACIONID AND InventarioID = P_INVENTARIOID;
END;
/


-- update mantenimiento
CREATE OR REPLACE PROCEDURE ACTUALIZAR_MANTENIMIENTO (
  P_MANTENIMIENTOID NUMBER,
  P_HABITACIONID NUMBER,
  P_FECHA_MANTENIMIENTO DATE,
  P_DESCRIPCION VARCHAR2,
  P_COSTO NUMBER
) AS
BEGIN
  UPDATE Mantenimiento
  SET
    HabitacionID = P_HABITACIONID,
    FechaMantenimiento = P_FECHA_MANTENIMIENTO,
    Descripcion = P_DESCRIPCION,
    Costo = P_COSTO
  WHERE MantenimientoID = P_MANTENIMIENTOID;
END;
/


-- actulizar proveedor
CREATE OR REPLACE PROCEDURE ACTUALIZAR_PROVEEDOR (
  P_PROVEEDORID NUMBER,
  P_NOMBRE VARCHAR2,
  P_DIRECCION VARCHAR2,
  P_TELEFONO VARCHAR2,
  P_EMAIL VARCHAR2
) AS
BEGIN
  UPDATE Proveedores
  SET
    Nombre = P_NOMBRE,
    Direccion = P_DIRECCION,
    Telefono = P_TELEFONO,
    Email = P_EMAIL
  WHERE ProveedorID = P_PROVEEDORID;
END;
/

-------------------------------------------------------------------------------------------
--CRUD ELIMINAR DE LAS TABLAS

CREATE OR REPLACE PROCEDURE ELIMINAR_EMPLEADO(
    p_empleado_id IN Empleados.EmpleadoID%TYPE
)
IS
BEGIN
    DELETE FROM Empleados
    WHERE EmpleadoID = p_empleado_id;

    DBMS_OUTPUT.PUT_LINE('Empleado eliminado exitosamente!!');
END;
/


CREATE OR REPLACE PROCEDURE ELIMINAR_HUESPED(
    p_huesped_id IN Huespedes.HuespedID%TYPE
)
IS
BEGIN
    DELETE FROM Huespedes
    WHERE HuespedID = p_huesped_id;

    DBMS_OUTPUT.PUT_LINE('Huésped eliminado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_HUESPED;
/

CREATE OR REPLACE PROCEDURE ELIMINAR_SERVICIO(
    p_servicio_id IN Servicios.ServicioID%TYPE
)
IS
BEGIN
    DELETE FROM Servicios
    WHERE ServicioID = p_servicio_id;

    DBMS_OUTPUT.PUT_LINE('Servicio eliminado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_SERVICIO;
/

CREATE OR REPLACE PROCEDURE ELIMINAR_RESERVA (
    p_reservaid IN Reservas.ReservaID%TYPE
) AS
BEGIN
    DELETE FROM Reservas
    WHERE ReservaID = p_reservaid;

    DBMS_OUTPUT.PUT_LINE('Reserva eliminada exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_RESERVA;
/

CREATE OR REPLACE PROCEDURE ELIMINAR_HABITACION (
    p_habitacionid IN Habitaciones.HabitacionID%TYPE
) AS
BEGIN
    DELETE FROM Habitaciones
    WHERE HabitacionID = p_habitacionid;

    DBMS_OUTPUT.PUT_LINE('Habitación eliminada exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_HABITACION;
/
CREATE OR REPLACE PROCEDURE ELIMINAR_FACTURA (
    p_facturaid IN Facturacion.FacturaID%TYPE
) AS
BEGIN
    DELETE FROM Facturacion
    WHERE FacturaID = p_facturaid;

    DBMS_OUTPUT.PUT_LINE('Factura eliminada exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_FACTURA;
/
CREATE OR REPLACE PROCEDURE ELIMINAR_INVENTARIO (
    p_inventarioid IN Inventarios.InventarioID%TYPE
) AS
BEGIN
    DELETE FROM Inventarios
    WHERE InventarioID = p_inventarioid;

    DBMS_OUTPUT.PUT_LINE('Inventario eliminado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_INVENTARIO;
/

CREATE OR REPLACE PROCEDURE ELIMINAR_CANTIDAD_INVENTARIO_POR_HABITACION (
    p_habitacionid IN CantidadInventarioPorHabitacion.HabitacionID%TYPE,
    p_inventarioid IN CantidadInventarioPorHabitacion.InventarioID%TYPE
) AS
BEGIN
    DELETE FROM CantidadInventarioPorHabitacion
    WHERE HabitacionID = p_habitacionid AND InventarioID = p_inventarioid;

    DBMS_OUTPUT.PUT_LINE('Cantidad de inventario por habitación eliminada exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_CANTIDAD_INVENTARIO_POR_HABITACION;
/

CREATE OR REPLACE PROCEDURE ELIMINAR_MANTENIMIENTO (
    p_mantenimientoid IN Mantenimiento.MantenimientoID%TYPE
) AS
BEGIN
    DELETE FROM Mantenimiento
    WHERE MantenimientoID = p_mantenimientoid;

    DBMS_OUTPUT.PUT_LINE('Mantenimiento eliminado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_MANTENIMIENTO;
/
CREATE OR REPLACE PROCEDURE ELIMINAR_PROVEEDOR (
    p_proveedorid IN Proveedores.ProveedorID%TYPE
) AS
BEGIN
    DELETE FROM Proveedores
    WHERE ProveedorID = p_proveedorid;

    DBMS_OUTPUT.PUT_LINE('Proveedor eliminado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_PROVEEDOR;
/


-- SECUENCIAS

-- Secuencia para Huespedes
CREATE SEQUENCE Huesped_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Empleados
CREATE SEQUENCE Empleado_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Habitaciones
CREATE SEQUENCE Habitacion_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Reservas
CREATE SEQUENCE Reserva_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Servicios
CREATE SEQUENCE Servicio_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Facturacion
CREATE SEQUENCE Factura_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Inventarios
CREATE SEQUENCE Inventario_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Mantenimiento
CREATE SEQUENCE Mantenimiento_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Secuencia para Proveedores
CREATE SEQUENCE Proveedor_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


--CURSORES
CREATE OR REPLACE PROCEDURE CURSOR_HUESPEDES (
  p_apellido IN Huespedes.Apellido%TYPE
) AS
  CURSOR c_huespedes IS
    SELECT HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email
    FROM Huespedes
    WHERE Apellido = p_apellido;
  
  r_huespedes c_huespedes%ROWTYPE;
BEGIN
  OPEN c_huespedes;
  
  LOOP
    FETCH c_huespedes INTO r_huespedes;
    EXIT WHEN c_huespedes%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_huespedes.HuespedID || ', Nombre: ' || r_huespedes.Nombre || ', Apellido: ' || r_huespedes.Apellido);
  END LOOP;
  
  CLOSE c_huespedes;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_HUESPEDES;
/

--selecciona las reservas que hay de la habitacion que queramos
CREATE OR REPLACE PROCEDURE CURSOR_RESERVAS (
  p_habitacionid IN Reservas.HabitacionID%TYPE
) AS
  CURSOR c_reservas IS
    SELECT ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado
    FROM Reservas
    WHERE HabitacionID = p_habitacionid;
  
  r_reservas c_reservas%ROWTYPE;
BEGIN
  OPEN c_reservas;
  
  LOOP
    FETCH c_reservas INTO r_reservas;
    EXIT WHEN c_reservas%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_reservas.ReservaID || ', HuespedID: ' || r_reservas.HuespedID || ', Fecha Entrada: ' || r_reservas.FechaEntrada || ', Fecha Salida: ' || r_reservas.FechaSalida || ', Estado: ' || r_reservas.Estado);
  END LOOP;
  
  CLOSE c_reservas;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_RESERVAS;
/

--todos los productos del invt con una cantidad de stock menor al valor que ocupemos
CREATE OR REPLACE PROCEDURE CURSOR_INVENTARIOS (
  p_cantidad_minima IN Inventarios.CantidadTotal%TYPE
) AS
  CURSOR c_inventarios IS
    SELECT InventarioID, NombreProducto, CantidadTotal, UnidadMedida
    FROM Inventarios
    WHERE CantidadTotal < p_cantidad_minima;
  
  r_inventarios c_inventarios%ROWTYPE;
BEGIN
  OPEN c_inventarios;
  
  LOOP
    FETCH c_inventarios INTO r_inventarios;
    EXIT WHEN c_inventarios%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_inventarios.InventarioID || ', Producto: ' || r_inventarios.NombreProducto || ', Cantidad: ' || r_inventarios.CantidadTotal || ', Unidad: ' || r_inventarios.UnidadMedida);
  END LOOP;
  
  CLOSE c_inventarios;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_INVENTARIOS;
/

CREATE OR REPLACE PROCEDURE CURSOR_EMPLEADOS (
  p_puesto IN Empleados.Puesto%TYPE
) AS
  CURSOR c_empleados IS
    SELECT EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario
    FROM Empleados
    WHERE Puesto = p_puesto;
  
  r_empleados c_empleados%ROWTYPE;
BEGIN
  OPEN c_empleados;
  
  LOOP
    FETCH c_empleados INTO r_empleados;
    EXIT WHEN c_empleados%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_empleados.EmpleadoID || ', Nombre: ' || r_empleados.Nombre || ', Puesto: ' || r_empleados.Puesto);
  END LOOP;
  
  CLOSE c_empleados;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_EMPLEADOS;
/


CREATE OR REPLACE PROCEDURE CURSOR_HABITACIONES (
  p_estado IN Habitaciones.Estado%TYPE
) AS
  CURSOR c_habitaciones IS
    SELECT HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado
    FROM Habitaciones
    WHERE Estado = p_estado;
  
  r_habitaciones c_habitaciones%ROWTYPE;
BEGIN
  OPEN c_habitaciones;
  
  LOOP
    FETCH c_habitaciones INTO r_habitaciones;
    EXIT WHEN c_habitaciones%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_habitaciones.HabitacionID || ', Numero: ' || r_habitaciones.NumeroHabitacion || ', Estado: ' || r_habitaciones.Estado);
  END LOOP;
  
  CLOSE c_habitaciones;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_HABITACIONES;
/

CREATE OR REPLACE PROCEDURE CURSOR_SERVICIOS (
  p_nombre_servicio IN Servicios.NombreServicio%TYPE
) AS
  CURSOR c_servicios IS
    SELECT ServicioID, NombreServicio, Descripcion, Precio
    FROM Servicios
    WHERE NombreServicio = p_nombre_servicio;
  
  r_servicios c_servicios%ROWTYPE;
BEGIN
  OPEN c_servicios;
  
  LOOP
    FETCH c_servicios INTO r_servicios;
    EXIT WHEN c_servicios%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_servicios.ServicioID || ', Nombre: ' || r_servicios.NombreServicio || ', Precio: ' || r_servicios.Precio);
  END LOOP;
  
  CLOSE c_servicios;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_SERVICIOS;
/

CREATE OR REPLACE PROCEDURE CURSOR_FACTURAS (
  p_fecha_factura IN Facturacion.FechaFactura%TYPE
) AS
  CURSOR c_facturas IS
    SELECT FacturaID, ReservaID, FechaFactura, Total
    FROM Facturacion
    WHERE FechaFactura = p_fecha_factura;
  
  r_facturas c_facturas%ROWTYPE;
BEGIN
  OPEN c_facturas;
  
  LOOP
    FETCH c_facturas INTO r_facturas;
    EXIT WHEN c_facturas%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_facturas.FacturaID || ', ReservaID: ' || r_facturas.ReservaID || ', Total: ' || r_facturas.Total);
  END LOOP;
  
  CLOSE c_facturas;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_FACTURAS;
/

CREATE OR REPLACE PROCEDURE CURSOR_CANTIDAD_INVENTARIO_POR_HABITACION (
  p_habitacionid IN CantidadInventarioPorHabitacion.HabitacionID%TYPE
) AS
  CURSOR c_cantidad_inventario IS
    SELECT HabitacionID, InventarioID, Cantidad
    FROM CantidadInventarioPorHabitacion
    WHERE HabitacionID = p_habitacionid;
  
  r_cantidad_inventario c_cantidad_inventario%ROWTYPE;
BEGIN
  OPEN c_cantidad_inventario;
  
  LOOP
    FETCH c_cantidad_inventario INTO r_cantidad_inventario;
    EXIT WHEN c_cantidad_inventario%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('HabitacionID: ' || r_cantidad_inventario.HabitacionID || ', InventarioID: ' || r_cantidad_inventario.InventarioID || ', Cantidad: ' || r_cantidad_inventario.Cantidad);
  END LOOP;
  
  CLOSE c_cantidad_inventario;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_CANTIDAD_INVENTARIO_POR_HABITACION;
/

CREATE OR REPLACE PROCEDURE CURSOR_MANTENIMIENTO (
  p_habitacionid IN Mantenimiento.HabitacionID%TYPE
) AS
  CURSOR c_mantenimiento IS
    SELECT MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo
    FROM Mantenimiento
    WHERE HabitacionID = p_habitacionid;
  
  r_mantenimiento c_mantenimiento%ROWTYPE;
BEGIN
  OPEN c_mantenimiento;
  
  LOOP
    FETCH c_mantenimiento INTO r_mantenimiento;
    EXIT WHEN c_mantenimiento%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_mantenimiento.MantenimientoID || ', HabitacionID: ' || r_mantenimiento.HabitacionID || ', Fecha: ' || r_mantenimiento.FechaMantenimiento || ', Costo: ' || r_mantenimiento.Costo);
  END LOOP;
  
  CLOSE c_mantenimiento;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_MANTENIMIENTO;
/

--VER HUESPEDES POR FECHA DE NAC
CREATE OR REPLACE PROCEDURE CURSOR_HUESPEDES_FECHA (
  p_fecha_nacimiento IN Huespedes.FechaNacimiento%TYPE
) AS
  CURSOR c_huespedes IS
    SELECT HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email
    FROM Huespedes
    WHERE FechaNacimiento = p_fecha_nacimiento;
  
  r_huespedes c_huespedes%ROWTYPE;
BEGIN
  OPEN c_huespedes;
  
  LOOP
    FETCH c_huespedes INTO r_huespedes;
    EXIT WHEN c_huespedes%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_huespedes.HuespedID || ', Nombre: ' || r_huespedes.Nombre || ', Apellido: ' || r_huespedes.Apellido);
  END LOOP;
  
  CLOSE c_huespedes;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_HUESPEDES_FECHA;
/
--EMPLEADOS POR FECHA DE CONTRATACION
CREATE OR REPLACE PROCEDURE CURSOR_EMPLEADOS_FECHA (
  p_fecha_contratacion IN Empleados.FechaContratacion%TYPE
) AS
  CURSOR c_empleados IS
    SELECT EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario
    FROM Empleados
    WHERE FechaContratacion = p_fecha_contratacion;
  
  r_empleados c_empleados%ROWTYPE;
BEGIN
  OPEN c_empleados;
  
  LOOP
    FETCH c_empleados INTO r_empleados;
    EXIT WHEN c_empleados%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_empleados.EmpleadoID || ', Nombre: ' || r_empleados.Nombre || ', Puesto: ' || r_empleados.Puesto);
  END LOOP;
  
  CLOSE c_empleados;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_EMPLEADOS_FECHA;
/

--POR TIPO DE HAB
CREATE OR REPLACE PROCEDURE CURSOR_HABITACIONES_TIPO (
  p_tipo_habitacion IN Habitaciones.TipoHabitacion%TYPE
) AS
  CURSOR c_habitaciones IS
    SELECT HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado
    FROM Habitaciones
    WHERE TipoHabitacion = p_tipo_habitacion;
  
  r_habitaciones c_habitaciones%ROWTYPE;
BEGIN
  OPEN c_habitaciones;
  
  LOOP
    FETCH c_habitaciones INTO r_habitaciones;
    EXIT WHEN c_habitaciones%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_habitaciones.HabitacionID || ', Numero: ' || r_habitaciones.NumeroHabitacion || ', Tipo: ' || r_habitaciones.TipoHabitacion);
  END LOOP;
  
  CLOSE c_habitaciones;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_HABITACIONES_TIPO;
/

--SERV POR EL PRECIO
CREATE OR REPLACE PROCEDURE CURSOR_SERVICIOS_PRECIO (
  p_precio IN Servicios.Precio%TYPE
) AS
  CURSOR c_servicios IS
    SELECT ServicioID, NombreServicio, Descripcion, Precio
    FROM Servicios
    WHERE Precio = p_precio;
  
  r_servicios c_servicios%ROWTYPE;
BEGIN
  OPEN c_servicios;
  
  LOOP
    FETCH c_servicios INTO r_servicios;
    EXIT WHEN c_servicios%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_servicios.ServicioID || ', Nombre: ' || r_servicios.NombreServicio || ', Precio: ' || r_servicios.Precio);
  END LOOP;
  
  CLOSE c_servicios;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_SERVICIOS_PRECIO;
/

--FACT POR EL TOTAL
CREATE OR REPLACE PROCEDURE CURSOR_FACTURAS_TOTAL (
  p_total IN Facturacion.Total%TYPE
) AS
  CURSOR c_facturas IS
    SELECT FacturaID, ReservaID, FechaFactura, Total
    FROM Facturacion
    WHERE Total = p_total;
  
  r_facturas c_facturas%ROWTYPE;
BEGIN
  OPEN c_facturas;
  
  LOOP
    FETCH c_facturas INTO r_facturas;
    EXIT WHEN c_facturas%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || r_facturas.FacturaID || ', ReservaID: ' || r_facturas.ReservaID || ', Total: ' || r_facturas.Total);
  END LOOP;
  
  CLOSE c_facturas;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END CURSOR_FACTURAS_TOTAL;
/