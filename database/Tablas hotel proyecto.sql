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
--actualizar el precio de la habitacion
CREATE OR REPLACE PROCEDURE UPDATE_ROOM_PRICE (
    ROOM_TYPE IN VARCHAR2,
    NEW_PRICE IN NUMBER
) AS
BEGIN
    UPDATE Habitaciones
    SET PrecioPorNoche = NEW_PRICE
    WHERE TipoHabitacion = ROOM_TYPE;
END;
/

CREATE OR REPLACE PROCEDURE LISTAR_HABITACIONES_DISPONIBLES (
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE
) AS
BEGIN
    FOR rec IN (
        SELECT HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche
        FROM Habitaciones
        WHERE HabitacionID NOT IN (
            SELECT HabitacionID
            FROM Reservas
            WHERE (FechaEntrada BETWEEN p_fecha_inicio AND p_fecha_fin)
               OR (FechaSalida BETWEEN p_fecha_inicio AND p_fecha_fin)
               OR (p_fecha_inicio BETWEEN FechaEntrada AND FechaSalida)
               OR (p_fecha_fin BETWEEN FechaEntrada AND FechaSalida)
        )
        AND Estado = 'Disponible'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('HabitacionID: ' || rec.HabitacionID);
        DBMS_OUTPUT.PUT_LINE('NumeroHabitacion: ' || rec.NumeroHabitacion);
        DBMS_OUTPUT.PUT_LINE('TipoHabitacion: ' || rec.TipoHabitacion);
        DBMS_OUTPUT.PUT_LINE('PrecioPorNoche: ' || rec.PrecioPorNoche);
    END LOOP;
END;
/
-- calcular precio de la reserva

CREATE OR REPLACE PROCEDURE CALCULAR_PRECIO_RESERVA (
    p_reserva_id IN Reservas.ReservaID%TYPE,
    p_costo_total OUT NUMBER
) AS
BEGIN
    SELECT SUM(PrecioPorNoche * (FechaSalida - FechaEntrada))
    INTO p_costo_total
    FROM Reservas R
    JOIN Habitaciones H ON R.HabitacionID = H.HabitacionID
    WHERE R.ReservaID = p_reserva_id;
END;
/


-- ver cuartos disponibles para una fecha esp.
CREATE OR REPLACE PROCEDURE LISTAR_HABITACIONES_DISPONIBLES (
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE
) AS
BEGIN
    FOR rec IN (
        SELECT HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche
        FROM Habitaciones
        WHERE HabitacionID NOT IN (
            SELECT HabitacionID
            FROM Reservas
            WHERE (FechaEntrada BETWEEN p_fecha_inicio AND p_fecha_fin)
               OR (FechaSalida BETWEEN p_fecha_inicio AND p_fecha_fin)
               OR (p_fecha_inicio BETWEEN FechaEntrada AND FechaSalida)
               OR (p_fecha_fin BETWEEN FechaEntrada AND FechaSalida)
        )
        AND Estado = 'Disponible'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('HabitacionID: ' || rec.HabitacionID);
        DBMS_OUTPUT.PUT_LINE('NumeroHabitacion: ' || rec.NumeroHabitacion);
        DBMS_OUTPUT.PUT_LINE('TipoHabitacion: ' || rec.TipoHabitacion);
        DBMS_OUTPUT.PUT_LINE('PrecioPorNoche: ' || rec.PrecioPorNoche);
    END LOOP;
END;
/


-- ver info huesped por buscar id
CREATE OR REPLACE PROCEDURE OBTENER_HUESPED_POR_RESERVA (
    p_reserva_id IN Reservas.ReservaID%TYPE
) AS
    v_huesped_id Huespedes.HuespedID%TYPE;
    v_nombre Huespedes.Nombre%TYPE;
    v_apellido Huespedes.Apellido%TYPE;
    v_fecha_nacimiento Huespedes.FechaNacimiento%TYPE;
    v_direccion Huespedes.Direccion%TYPE;
    v_telefono Huespedes.Telefono%TYPE;
    v_email Huespedes.Email%TYPE;
BEGIN
    SELECT HuespedID
    INTO v_huesped_id
    FROM Reservas
    WHERE ReservaID = p_reserva_id;

    SELECT Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email
    INTO v_nombre, v_apellido, v_fecha_nacimiento, v_direccion, v_telefono, v_email
    FROM Huespedes
    WHERE HuespedID = v_huesped_id;

    DBMS_OUTPUT.PUT_LINE('HuespedID: ' || v_huesped_id);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Apellido: ' || v_apellido);
    DBMS_OUTPUT.PUT_LINE('FechaNacimiento: ' || v_fecha_nacimiento);
    DBMS_OUTPUT.PUT_LINE('Direccion: ' || v_direccion);
    DBMS_OUTPUT.PUT_LINE('Telefono: ' || v_telefono);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
END;
/
BEGIN
    OBTENER_HUESPED_POR_RESERVA(1); 
END;
/
-- cambiar de cuarto calcular precios

CREATE OR REPLACE PROCEDURE ACTUALIZAR_PRECIO_HABITACION (
    p_tipo_habitacion IN Habitaciones.TipoHabitacion%TYPE,
    p_nuevo_precio IN Habitaciones.PrecioPorNoche%TYPE
) AS
BEGIN
    UPDATE Habitaciones
    SET PrecioPorNoche = p_nuevo_precio
    WHERE TipoHabitacion = p_tipo_habitacion;
END;
/




-- agregar empleado con dbms
CREATE SEQUENCE Empleados_SEQ
START WITH 1
INCREMENT BY 1;
CREATE OR REPLACE PROCEDURE AGREGAR_EMPLEADO(
    p_nombre IN Empleados.Nombre%TYPE,
    p_apellido IN Empleados.Apellido%TYPE,
    p_puesto IN Empleados.Puesto%TYPE,
    p_fecha_contratacion IN Empleados.FechaContratacion%TYPE,
    p_salario IN Empleados.Salario%TYPE
)
IS
BEGIN
    INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario)
    VALUES (Empleados_SEQ.NEXTVAL, p_nombre, p_apellido, p_puesto, p_fecha_contratacion, p_salario);
    
    DBMS_OUTPUT.PUT_LINE('Empleado agregado exitosamente!!');
END;
/

-- agregar factura con dbms
CREATE SEQUENCE Facturacion_SEQ
START WITH 1
INCREMENT BY 1;
CREATE OR REPLACE PROCEDURE AGREGAR_FACTURA(
    p_reserva_id IN Facturacion.ReservaID%TYPE,
    p_fecha_factura IN Facturacion.FechaFactura%TYPE,
    p_total IN Facturacion.Total%TYPE
)
IS
BEGIN
    INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total)
    VALUES (Facturacion_SEQ.NEXTVAL, p_reserva_id, p_fecha_factura, p_total);
    
    DBMS_OUTPUT.PUT_LINE('Factura agregada exitosamente!!!!');
END;
/

CREATE SEQUENCE Huespedes_SEQ
START WITH 1
INCREMENT BY 1;
--Procedimiento para agregar un huesped
CREATE OR REPLACE PROCEDURE AGREGAR_HUESPED(
    p_nombre IN Huespedes.Nombre%TYPE,
    p_apellido IN Huespedes.Apellido%TYPE,
    p_fecha_nacimiento IN Huespedes.FechaNacimiento%TYPE,
    p_direccion IN Huespedes.Direccion%TYPE,
    p_telefono IN Huespedes.Telefono%TYPE,
    p_email IN Huespedes.Email%TYPE
)
IS
BEGIN
    INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email)
    VALUES (Huespedes_SEQ.NEXTVAL, p_nombre, p_apellido, p_fecha_nacimiento, p_direccion, p_telefono, p_email);
    DBMS_OUTPUT.PUT_LINE('Huésped agregado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END AGREGAR_HUESPED;

BEGIN
    AGREGAR_HUESPED('Carlos', 'Pérez', TO_DATE('1985-04-23', 'YYYY-MM-DD'), 'Calle Falsa 123', '123456789', 'carlos.perez@example.com');
END;

SET SERVEROUTPUT ON;
/
--Procedimeinto para actualizar el estado de una Reserva
CREATE OR REPLACE PROCEDURE ACTUALIZAR_ESTADO_RESERVA(
    p_reservaID IN Reservas.ReservaID%TYPE,
    p_estado IN Reservas.Estado%TYPE
)
IS
BEGIN
    UPDATE Reservas
    SET Estado = p_estado
    WHERE ReservaID = p_reservaID;
    DBMS_OUTPUT.PUT_LINE('Estado de la reserva actualizado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ACTUALIZAR_ESTADO_RESERVA;
/
CREATE SEQUENCE Mantenimiento_SEQ
START WITH 1
INCREMENT BY 1;
--Procedimiento para registrar un nuevo mantenimento
CREATE OR REPLACE PROCEDURE REGISTRAR_MANTENIMIENTO(
    p_habitacionID IN Mantenimiento.HabitacionID%TYPE,
    p_fecha_mantenimiento IN Mantenimiento.FechaMantenimiento%TYPE,
    p_descripcion IN Mantenimiento.Descripcion%TYPE,
    p_costo IN Mantenimiento.Costo%TYPE
)
IS
BEGIN
    INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, FechaMantenimiento, Descripcion, Costo)
    VALUES (Mantenimiento_SEQ.NEXTVAL, p_habitacionID, p_fecha_mantenimiento, p_descripcion, p_costo);
    DBMS_OUTPUT.PUT_LINE('Mantenimiento registrado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END REGISTRAR_MANTENIMIENTO;


BEGIN
    REGISTRAR_MANTENIMIENTO(1, SYSDATE, 'Cambio de sábanas y limpieza', 50);
END;
/

CREATE SEQUENCE Servicios_SEQ
START WITH 1
INCREMENT BY 1;
--Procedimiento para agregar un nuevo servicio
CREATE OR REPLACE PROCEDURE AGREGAR_SERVICIO(
    p_nombre_servicio IN Servicios.NombreServicio%TYPE,
    p_descripcion IN Servicios.Descripcion%TYPE,
    p_precio IN Servicios.Precio%TYPE
)
IS
BEGIN
    INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio)
    VALUES (Servicios_SEQ.NEXTVAL, p_nombre_servicio, p_descripcion, p_precio);
    DBMS_OUTPUT.PUT_LINE('Servicio agregado exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END AGREGAR_SERVICIO;

BEGIN
    AGREGAR_SERVICIO('Spa', 'Servicio de spa con masaje relajante', 100);
END;


--Procedimiento para listar los empleados contratados en despues de una fecha específica
CREATE OR REPLACE PROCEDURE LISTA_EMPLEADOS_CONTRATADOS_DESPUES(
    p_fecha IN DATE
)
IS
BEGIN
    FOR rec IN (SELECT Nombre, Apellido FROM Empleados WHERE FechaContratacion > p_fecha)
    LOOP
        DBMS_OUTPUT.PUT_LINE(rec.Nombre || ' ' || rec.Apellido);
    END LOOP;
END LISTA_EMPLEADOS_CONTRATADOS_DESPUES;


--Actualizar la cantidad de inventario por habitacion
CREATE OR REPLACE PROCEDURE ACTUALIZAR_CANTIDAD_INVENTARIO(
    p_habitacionID IN CantidadInventarioPorHabitacion.HabitacionID%TYPE,
    p_inventarioID IN CantidadInventarioPorHabitacion.InventarioID%TYPE,
    p_cantidad IN CantidadInventarioPorHabitacion.Cantidad%TYPE
)
IS
BEGIN
    UPDATE CantidadInventarioPorHabitacion
    SET Cantidad = p_cantidad
    WHERE HabitacionID = p_habitacionID AND InventarioID = p_inventarioID;
    DBMS_OUTPUT.PUT_LINE('Cantidad de inventario actualizada exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ACTUALIZAR_CANTIDAD_INVENTARIO;