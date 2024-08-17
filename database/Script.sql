
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

CREATE TABLE Servicios (
    ServicioID NUMBER PRIMARY KEY,
    NombreServicio VARCHAR2(100) NOT NULL,
    Descripcion VARCHAR2(255),
    Precio NUMBER(10, 2)
);

CREATE TABLE Inventarios (
    InventarioID NUMBER PRIMARY KEY,
    NombreProducto VARCHAR2(100) NOT NULL,
    CantidadTotal NUMBER NOT NULL,
    UnidadMedida VARCHAR2(50)
);

CREATE TABLE Proveedores (
    ProveedorID NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100) NOT NULL,
    Direccion VARCHAR2(255),
    Telefono VARCHAR2(20),
    Email VARCHAR2(100)
);


CREATE TABLE Habitaciones (
    HabitacionID NUMBER PRIMARY KEY,
    NumeroHabitacion VARCHAR2(10) NOT NULL,
    TipoHabitacion VARCHAR2(50),
    PrecioPorNoche NUMBER(10, 2),
    Estado VARCHAR2(50) CHECK (Estado IN ('Disponible', 'Ocupada', 'Mantenimiento'))
);

CREATE TABLE Reservas (
    ReservaID NUMBER PRIMARY KEY,
    HuespedID NUMBER REFERENCES Huespedes(HuespedID),
    HabitacionID NUMBER REFERENCES Habitaciones(HabitacionID),
    FechaEntrada DATE NOT NULL,
    FechaSalida DATE NOT NULL,
    Estado VARCHAR2(50) CHECK (Estado IN ('Pendiente', 'Confirmada', 'Cancelada'))
);

CREATE TABLE Facturacion (
    FacturaID NUMBER PRIMARY KEY,
    ReservaID NUMBER REFERENCES Reservas(ReservaID),
    FechaFactura DATE NOT NULL,
    Total NUMBER(10, 2) NOT NULL
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

----------------------------------------------------------------------------
-- SECUENCIAS

-- Secuencia para Huespedes
CREATE SEQUENCE Huesped_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Empleados
CREATE SEQUENCE Empleado_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Habitaciones
CREATE SEQUENCE Habitacion_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Reservas
CREATE SEQUENCE Reserva_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Servicios
CREATE SEQUENCE Servicio_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Facturacion
CREATE SEQUENCE Factura_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Inventarios
CREATE SEQUENCE Inventario_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Mantenimiento
CREATE SEQUENCE Mantenimiento_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/
-- Secuencia para Proveedores
CREATE SEQUENCE Proveedor_SEQ
START WITH 11
INCREMENT BY 1
NOCACHE
NOCYCLE;
/

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


CREATE OR REPLACE PROCEDURE ELIMINAR_HUESPED(p_huesped_id NUMBER) IS
BEGIN
    DELETE FROM Facturacion WHERE ReservaID IN (SELECT ReservaID FROM Reservas WHERE HuespedID = p_huesped_id);

    DELETE FROM Reservas WHERE HuespedID = p_huesped_id;

    DELETE FROM Huespedes WHERE HuespedID = p_huesped_id;

    COMMIT;
END;
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
    DELETE FROM Facturacion
    WHERE ReservaID = p_reservaid;

    DELETE FROM Reservas
    WHERE ReservaID = p_reservaid;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Reserva y referencias eliminadas exitosamente.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
END ELIMINAR_RESERVA;
/

CREATE OR REPLACE PROCEDURE ELIMINAR_HABITACION (
    p_habitacionid IN Habitaciones.HabitacionID%TYPE
) AS
BEGIN
    DELETE FROM Reservas WHERE HabitacionID = p_habitacionid;
    DELETE FROM Mantenimiento WHERE HabitacionID = p_habitacionid;

    DELETE FROM Habitaciones WHERE HabitacionID = p_habitacionid;

    DBMS_OUTPUT.PUT_LINE('Habitación eliminada exitosamente.');
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error: ' || SQLERRM);
        ROLLBACK;
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


----------------------------------------------------------------------------------
----PROC DE SELECTS-----

-- OBTENER RESERVAS
CREATE OR REPLACE PROCEDURE obtener_reservas (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM Reservas;
END obtener_reservas;
/
 
 
-- OBTENER SERVICIOS
CREATE OR REPLACE PROCEDURE obtener_servicios (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM Servicios;
END obtener_servicios;
/
 
 
-- OBTENER FACTURAS
CREATE OR REPLACE PROCEDURE obtener_facturas (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM Facturacion;
END obtener_facturas;
/
 
 
-- OBTENER INVENTARIOS
CREATE OR REPLACE PROCEDURE obtener_inventarios (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM Inventarios;
END obtener_inventarios;
/
 
 
-- OBTENER MANTENIMIENTO
CREATE OR REPLACE PROCEDURE obtener_mantenimiento (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM Mantenimiento;
END obtener_mantenimiento;
/
 
 
--OBTENER HUESPUEDES
CREATE OR REPLACE PROCEDURE obtener_huespedes (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM huespedes;
END obtener_huespedes;
/
-- OBTENER EMPLEADOS
CREATE OR REPLACE PROCEDURE obtener_empleados (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM empleados;
END obtener_empleados;
/

 
-- OBTENER HABITACIONES
CREATE OR REPLACE PROCEDURE obtener_habitaciones (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM habitaciones;
END obtener_habitaciones;
/
 
CREATE OR REPLACE PROCEDURE obtener_proveedores (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM PROVEEDORES;
END obtener_proveedores;
/

--FUNCIONES-------------

CREATE OR REPLACE FUNCTION LISTA_EMPLEADOS_CON_PUESTO (
    p_puesto IN VARCHAR2
) RETURN SYS_REFCURSOR
IS
    c_empleados SYS_REFCURSOR;
BEGIN
    OPEN c_empleados FOR
        SELECT EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario
        FROM Empleados
        WHERE Puesto = p_puesto;

    RETURN c_empleados;
END;
/

---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION LISTA_HUESPEDES_ORDENADOS
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Huespedes
        ORDER BY Nombre ASC;
    RETURN resultado;
END;
/

----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION FILTRAR_HABITACIONES_POR_ESTADO(p_estado IN VARCHAR2)
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Habitaciones
        WHERE Estado = p_estado;
    RETURN resultado;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION REPORTAR_INVENTARIO_POR_CANTIDAD(min_cantidad IN NUMBER, max_cantidad IN NUMBER)
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Inventarios
        WHERE CantidadTotal BETWEEN min_cantidad AND max_cantidad;
    RETURN resultado;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION REPORTAR_MANTENIMIENTO_POR_COSTO(min_costo IN NUMBER, max_costo IN NUMBER)
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Mantenimiento
        WHERE Costo BETWEEN min_costo AND max_costo;
    RETURN resultado;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION REPORTAR_PROVEEDORES_POR_NOMBRE(nombre_busqueda IN VARCHAR2)
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Proveedores
        WHERE Nombre LIKE '%' || nombre_busqueda || '%';
    RETURN resultado;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION REPORTAR_RESERVAS_POR_ESTADO(estado_busqueda IN VARCHAR2)
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Reservas
        WHERE Estado = estado_busqueda;
    RETURN resultado;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION REPORTAR_FACTURACION_POR_FECHA(
    fecha_inicio IN DATE,
    fecha_fin IN DATE
)
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Facturacion
        WHERE FechaFactura BETWEEN fecha_inicio AND fecha_fin;
    RETURN resultado;
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION REPORTAR_SERVICIOS_POR_PRECIO(
    precio_minimo IN NUMBER,
    precio_maximo IN NUMBER
)
RETURN SYS_REFCURSOR
IS
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR
        SELECT * FROM Servicios
        WHERE Precio BETWEEN precio_minimo AND precio_maximo;
    RETURN resultado;
END;
/

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





---------------------------------------------------------------------------------
--PAQUETES--

-- Paquete 1: Huespedes
CREATE OR REPLACE PACKAGE HUESPED_MAN AS
  -- Constantes para los estados
  ESTADO_ACTIVO CONSTANT VARCHAR2(10) := 'Activo';
  ESTADO_INACTIVO CONSTANT VARCHAR2(10) := 'Inactivo';

  -- Obtenemos aca los datos del huesped
  CURSOR CUR_HUESPED(P_HUESPED_ID NUMBER) IS
    SELECT Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email
    FROM Huespedes
    WHERE HuespedID = P_HUESPED_ID;

  -- Función para obtener la edad del huésped
  FUNCTION OBTENER_EDAD(P_HUESPED_ID NUMBER) RETURN NUMBER;
  
  -- Función para obtener el total de huéspedes activos
  FUNCTION TOTAL_HUESPEDES_ACTIVOS RETURN NUMBER;
END HUESPED_MAN;
/

CREATE OR REPLACE PACKAGE BODY HUESPED_MAN AS
  FUNCTION OBTENER_EDAD(P_HUESPED_ID NUMBER) RETURN NUMBER
  AS
    V_FECHA_NACIMIENTO DATE;
    V_EDAD NUMBER;
  BEGIN
    SELECT FechaNacimiento INTO V_FECHA_NACIMIENTO
    FROM Huespedes
    WHERE HuespedID = P_HUESPED_ID;

    V_EDAD := FLOOR(MONTHS_BETWEEN(SYSDATE, V_FECHA_NACIMIENTO) / 12);
    RETURN V_EDAD;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END OBTENER_EDAD;

  FUNCTION TOTAL_HUESPEDES_ACTIVOS RETURN NUMBER
  AS
    V_TOTAL NUMBER;
  BEGIN
    SELECT COUNT(*) INTO V_TOTAL
    FROM Huespedes;

    RETURN V_TOTAL;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END TOTAL_HUESPEDES_ACTIVOS;
END HUESPED_MAN;
/

-- Paquete 2: Empleados
CREATE OR REPLACE PACKAGE EMPLEADO_MAN AS
  -- Constantes DE los puestos
  PUESTO_MANAGER CONSTANT VARCHAR2(20) := 'Manager';
  PUESTO_CLERK CONSTANT VARCHAR2(20) := 'Clerk';

  -- Cursor para obtener datos del empleado
  CURSOR CUR_EMPLEADO(P_EMPLEADO_ID NUMBER) IS
    SELECT Nombre, Apellido, Puesto, FechaContratacion, Salario
    FROM Empleados
    WHERE EmpleadoID = P_EMPLEADO_ID;

  -- CON ESTA FUNCION PODEMOS VER EL SALARIO TOTAL  
  FUNCTION SALARIO_TOTAL RETURN NUMBER;

  -- CON ESTA FUNCION PODEMOS OBTENER EL PROMEDIO DE UN PUESTO  
  FUNCTION SALARIO_PROMEDIO(P_PUESTO VARCHAR2) RETURN NUMBER;
END EMPLEADO_MAN;
/

CREATE OR REPLACE PACKAGE BODY EMPLEADO_MAN AS
  FUNCTION SALARIO_TOTAL RETURN NUMBER
  AS
    V_TOTAL NUMBER;
  BEGIN
    SELECT SUM(Salario) INTO V_TOTAL
    FROM Empleados;

    RETURN V_TOTAL;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END SALARIO_TOTAL;

  FUNCTION SALARIO_PROMEDIO(P_PUESTO VARCHAR2) RETURN NUMBER
  AS
    V_PROMEDIO NUMBER;
  BEGIN
    SELECT AVG(Salario) INTO V_PROMEDIO
    FROM Empleados
    WHERE Puesto = P_PUESTO;

    RETURN V_PROMEDIO;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
      RETURN NULL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END SALARIO_PROMEDIO;
END EMPLEADO_MAN;
/

-- Paquete 3: Reservas
CREATE OR REPLACE PACKAGE RESERVA_MAN AS
  -- Constantes de los estados de reserva
  ESTADO_CONFIRMADO CONSTANT VARCHAR2(20) := 'Confirmada';
  ESTADO_CANCELADA CONSTANT VARCHAR2(20) := 'Cancelada';

  -- Cursor para obtener  los detalles de una reserva
  CURSOR CUR_RESERVA(P_RESERVA_ID NUMBER) IS
    SELECT HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado
    FROM Reservas
    WHERE ReservaID = P_RESERVA_ID;

  -- obtenemos el número de reservas activas
  FUNCTION NUMERO_RESERVAS_ACTIVAS RETURN NUMBER;
  
  -- Función para obtener la fecha de salida de una reserva
  FUNCTION FECHA_SALIDA(P_RESERVA_ID NUMBER) RETURN DATE;
END RESERVA_MAN;
/

CREATE OR REPLACE PACKAGE BODY RESERVA_MAN AS
  FUNCTION NUMERO_RESERVAS_ACTIVAS RETURN NUMBER
  AS
    V_NUMERO NUMBER;
  BEGIN
    SELECT COUNT(*) INTO V_NUMERO
    FROM Reservas
    WHERE Estado = ESTADO_CONFIRMADO;

    RETURN V_NUMERO;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END NUMERO_RESERVAS_ACTIVAS;

  FUNCTION FECHA_SALIDA(P_RESERVA_ID NUMBER) RETURN DATE
  AS
    V_FECHA_SALIDA DATE;
  BEGIN
    SELECT FechaSalida INTO V_FECHA_SALIDA
    FROM Reservas
    WHERE ReservaID = P_RESERVA_ID;

    RETURN V_FECHA_SALIDA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Reserva no encontrada.');
      RETURN NULL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END FECHA_SALIDA;
END RESERVA_MAN;
/

-- Paquete 4: Habitaciones
CREATE OR REPLACE PACKAGE HABITACION_MAN AS
  -- Constantes 
  ESTADO_DISPONIBLE CONSTANT VARCHAR2(20) := 'Disponible';
  ESTADO_OCUPADA CONSTANT VARCHAR2(20) := 'Ocupada';

  -- Cursor para obtener detalles de una habitación
  CURSOR CUR_HABITACION(P_HABITACION_ID NUMBER) IS
    SELECT NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado
    FROM Habitaciones
    WHERE HabitacionID = P_HABITACION_ID;

  -- Función para obtener el precio total de todas las habitaciones
  FUNCTION PRECIO_TOTAL RETURN NUMBER;

  -- Función para obtener el número de habitaciones disponibles
  FUNCTION NUMERO_HABITACIONES_DISPONIBLES RETURN NUMBER;
END HABITACION_MAN;
/

CREATE OR REPLACE PACKAGE BODY HABITACION_MAN AS
  FUNCTION PRECIO_TOTAL RETURN NUMBER
  AS
    V_TOTAL NUMBER;
  BEGIN
    SELECT SUM(PrecioPorNoche) INTO V_TOTAL
    FROM Habitaciones;

    RETURN V_TOTAL;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END PRECIO_TOTAL;

  FUNCTION NUMERO_HABITACIONES_DISPONIBLES RETURN NUMBER
  AS
    V_NUMERO NUMBER;
  BEGIN
    SELECT COUNT(*) INTO V_NUMERO
    FROM Habitaciones
    WHERE Estado = ESTADO_DISPONIBLE;

    RETURN V_NUMERO;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END NUMERO_HABITACIONES_DISPONIBLES;
END HABITACION_MAN;
/

-- Paquete 5: Servicios
CREATE OR REPLACE PACKAGE SERVICIO_MAN AS
  -- Cursor para obtener detalles de un servicio
  CURSOR CUR_SERVICIO(P_SERVICIO_ID NUMBER) IS
    SELECT NombreServicio, Descripcion, Precio
    FROM Servicios
    WHERE ServicioID = P_SERVICIO_ID;

  -- Función para obtener el costo total de todos los servicios
  FUNCTION COSTO_TOTAL RETURN NUMBER;

  -- Función para obtener el servicio más caro
  FUNCTION SERVICIO_MAS_CARO RETURN VARCHAR2;
END SERVICIO_MAN;
/

CREATE OR REPLACE PACKAGE BODY SERVICIO_MAN AS
  FUNCTION COSTO_TOTAL RETURN NUMBER
  AS
    V_TOTAL NUMBER;
  BEGIN
    SELECT SUM(Precio) INTO V_TOTAL
    FROM Servicios;

    RETURN V_TOTAL;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END COSTO_TOTAL;

  FUNCTION SERVICIO_MAS_CARO RETURN VARCHAR2
  AS
    V_SERVICIO VARCHAR2(100);
  BEGIN
    SELECT NombreServicio INTO V_SERVICIO
    FROM Servicios
    WHERE Precio = (SELECT MAX(Precio) FROM Servicios);

    RETURN V_SERVICIO;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No se encontraron servicios.');
      RETURN NULL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END SERVICIO_MAS_CARO;
END SERVICIO_MAN;
/

-- Paquete 6: Facturación
CREATE OR REPLACE PACKAGE FACTURACION_MAN AS
  -- Cursor para obtener detalles de una factura
  CURSOR CUR_FACTURA(P_FACTURA_ID NUMBER) IS
    SELECT ReservaID, FechaFactura, Total
    FROM Facturacion
    WHERE FacturaID = P_FACTURA_ID;

  -- Función para obtener el total de facturación
  FUNCTION TOTAL_FACTURACION RETURN NUMBER;

  -- Función para obtener la última factura
  FUNCTION ULTIMA_FACTURA RETURN NUMBER;
END FACTURACION_MAN;
/

CREATE OR REPLACE PACKAGE BODY FACTURACION_MAN AS
  FUNCTION TOTAL_FACTURACION RETURN NUMBER
  AS
    V_TOTAL NUMBER;
  BEGIN
    SELECT SUM(Total) INTO V_TOTAL
    FROM Facturacion;

    RETURN V_TOTAL;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END TOTAL_FACTURACION;

  FUNCTION ULTIMA_FACTURA RETURN NUMBER
  AS
    V_FACTURA_ID NUMBER;
  BEGIN
    SELECT MAX(FacturaID) INTO V_FACTURA_ID
    FROM Facturacion;

    RETURN V_FACTURA_ID;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END ULTIMA_FACTURA;
END FACTURACION_MAN;
/

-- Paquete 7: Proveedores
CREATE OR REPLACE PACKAGE PROVEEDOR_MAN AS
  -- Cursor para obtener detalles de un proveedor
  CURSOR CUR_PROVEEDOR(P_PROVEEDOR_ID NUMBER) IS
    SELECT Nombre, Direccion, Telefono, Email
    FROM Proveedores
    WHERE ProveedorID = P_PROVEEDOR_ID;

  -- Función para obtener el número total de proveedores
  FUNCTION TOTAL_PROVEEDORES RETURN NUMBER;

  -- Función para obtener el proveedor con el mayor ID
  FUNCTION PROVEEDOR_MAYOR_ID RETURN NUMBER;
END PROVEEDOR_MAN;
/

CREATE OR REPLACE PACKAGE BODY PROVEEDOR_MAN AS
  FUNCTION TOTAL_PROVEEDORES RETURN NUMBER
  AS
    V_TOTAL NUMBER;
  BEGIN
    SELECT COUNT(*) INTO V_TOTAL
    FROM Proveedores;

    RETURN V_TOTAL;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END TOTAL_PROVEEDORES;

  FUNCTION PROVEEDOR_MAYOR_ID RETURN NUMBER
  AS
    V_ID NUMBER;
  BEGIN
    SELECT MAX(ProveedorID) INTO V_ID
    FROM Proveedores;

    RETURN V_ID;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END PROVEEDOR_MAYOR_ID;
END PROVEEDOR_MAN;
/

-- Paquete 8: Mantenimiento
CREATE OR REPLACE PACKAGE MANTENIMIENTO_MAN AS
  -- Cursor para obtener detalles de mantenimiento
  CURSOR CUR_MANTENIMIENTO(P_MANTENIMIENTO_ID NUMBER) IS
    SELECT HabitacionID, FechaMantenimiento, Descripcion, Costo
    FROM Mantenimiento
    WHERE MantenimientoID = P_MANTENIMIENTO_ID;

  -- Función para obtener el costo total de mantenimiento
  FUNCTION COSTO_TOTAL_MANTENIMIENTO RETURN NUMBER;

  -- Función para obtener el mantenimiento más reciente
  FUNCTION MANTENIMIENTO_MAS_RECIENTE RETURN DATE;
END MANTENIMIENTO_MAN;
/

CREATE OR REPLACE PACKAGE BODY MANTENIMIENTO_MAN AS
  FUNCTION COSTO_TOTAL_MANTENIMIENTO RETURN NUMBER
  AS
    V_TOTAL NUMBER;
  BEGIN
    SELECT SUM(Costo) INTO V_TOTAL
    FROM Mantenimiento;

    RETURN V_TOTAL;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END COSTO_TOTAL_MANTENIMIENTO;

  FUNCTION MANTENIMIENTO_MAS_RECIENTE RETURN DATE
  AS
    V_FECHA DATE;
  BEGIN
    SELECT MAX(FechaMantenimiento) INTO V_FECHA
    FROM Mantenimiento;

    RETURN V_FECHA;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No se encontraron mantenimientos.');
      RETURN NULL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END MANTENIMIENTO_MAS_RECIENTE;
END MANTENIMIENTO_MAN;
/

-- Paquete 9: Inventarios
CREATE OR REPLACE PACKAGE INVENTARIO_MAN AS
  -- Cursor para obtener detalles del inventario
  CURSOR CUR_INVENTARIO(P_INVENTARIO_ID NUMBER) IS
    SELECT NombreProducto, CantidadTotal, UnidadMedida
    FROM Inventarios
    WHERE InventarioID = P_INVENTARIO_ID;

  -- Función para obtener la cantidad total de inventario
  FUNCTION CANTIDAD_TOTAL RETURN NUMBER;

  -- Función para obtener el inventario con el menor ID
  FUNCTION INVENTARIO_MENOR_ID RETURN NUMBER;
END INVENTARIO_MAN;
/

CREATE OR REPLACE PACKAGE BODY INVENTARIO_MAN AS
  FUNCTION CANTIDAD_TOTAL RETURN NUMBER
  AS
    V_CANTIDAD NUMBER;
  BEGIN
    SELECT SUM(CantidadTotal) INTO V_CANTIDAD
    FROM Inventarios;

    RETURN V_CANTIDAD;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END CANTIDAD_TOTAL;

  FUNCTION INVENTARIO_MENOR_ID RETURN NUMBER
  AS
    V_ID NUMBER;
  BEGIN
    SELECT MIN(InventarioID) INTO V_ID
    FROM Inventarios;

    RETURN V_ID;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END INVENTARIO_MENOR_ID;
END INVENTARIO_MAN;
/

-- Paquete 10: CantidadInventarioPorHabitacion
CREATE OR REPLACE PACKAGE CANTIDAD_INVENTARIO_HABITACION_MAN AS
  -- Cursor para obtener detalles de cantidad de inventario por habitación
  CURSOR CUR_CANTIDAD_INVENTARIO_HABITACION(P_HABITACION_ID NUMBER, P_INVENTARIO_ID NUMBER) IS
    SELECT Cantidad
    FROM CantidadInventarioPorHabitacion
    WHERE HabitacionID = P_HABITACION_ID
    AND InventarioID = P_INVENTARIO_ID;

  -- Función para obtener la cantidad total de inventario en una habitación
  FUNCTION CANTIDAD_TOTAL_EN_HABITACION(P_HABITACION_ID NUMBER) RETURN NUMBER;

  -- Función para obtener el inventario con mayor cantidad en una habitación
  FUNCTION INVENTARIO_MAYOR_CANTIDAD(P_HABITACION_ID NUMBER) RETURN NUMBER;
END CANTIDAD_INVENTARIO_HABITACION_MAN;
/

CREATE OR REPLACE PACKAGE BODY CANTIDAD_INVENTARIO_HABITACION_MAN AS
  FUNCTION CANTIDAD_TOTAL_EN_HABITACION(P_HABITACION_ID NUMBER) RETURN NUMBER
  AS
    V_CANTIDAD NUMBER;
  BEGIN
    SELECT SUM(Cantidad) INTO V_CANTIDAD
    FROM CantidadInventarioPorHabitacion
    WHERE HabitacionID = P_HABITACION_ID;

    RETURN V_CANTIDAD;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END CANTIDAD_TOTAL_EN_HABITACION;

  FUNCTION INVENTARIO_MAYOR_CANTIDAD(P_HABITACION_ID NUMBER) RETURN NUMBER
  AS
    V_INVENTARIO_ID NUMBER;
  BEGIN
    SELECT InventarioID INTO V_INVENTARIO_ID
    FROM CantidadInventarioPorHabitacion
    WHERE HabitacionID = P_HABITACION_ID
    ORDER BY Cantidad DESC
    FETCH FIRST 1 ROW ONLY;

    RETURN V_INVENTARIO_ID;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
      RETURN NULL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      RETURN NULL;
  END INVENTARIO_MAYOR_CANTIDAD;
END CANTIDAD_INVENTARIO_HABITACION_MAN;
/

-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------
------TRIGGERS-----

--evita reservar alguna habitacion ocupada
CREATE OR REPLACE TRIGGER trg_hab_ocupada
BEFORE INSERT ON Reservas
FOR EACH ROW
DECLARE
    v_estado VARCHAR2(50);
BEGIN
    SELECT Estado INTO v_estado
    FROM Habitaciones
    WHERE HabitacionID = :NEW.HabitacionID;

    IF v_estado IN ('Mantenimiento', 'Ocupada') THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede hacer una reserva para una habitación en mantenimiento o ya ocupada.');
    END IF;
END;
/

--cambia estado de la reservacion a 'ocupada'
CREATE OR REPLACE TRIGGER trg_act_estado
AFTER UPDATE OF Estado ON Reservas
FOR EACH ROW
WHEN (NEW.Estado = 'Confirmada')
BEGIN
    UPDATE Habitaciones
    SET Estado = 'Ocupada'
    WHERE HabitacionID = :NEW.HabitacionID;
END;
/

--no se puede eliminar empleado con alguna reserva activa
CREATE OR REPLACE TRIGGER trg_elim_emp_reserva
BEFORE DELETE ON Empleados
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Reservas r
    JOIN Habitaciones h ON r.HabitacionID = h.HabitacionID
    WHERE h.NumeroHabitacion = :OLD.EmpleadoID
      AND r.Estado IN ('Pendiente', 'Confirmada');

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar un empleado con reservas activas.');
    END IF;
END;
/


--mantiene el inv actualizado
CREATE OR REPLACE TRIGGER trg_act_inv
AFTER INSERT ON CantidadInventarioPorHabitacion
FOR EACH ROW
BEGIN
    UPDATE Inventarios
    SET CantidadTotal = CantidadTotal - :NEW.Cantidad
    WHERE InventarioID = :NEW.InventarioID;
END;
/

CREATE SEQUENCE SEQ_FACTURACION
START WITH 1
INCREMENT BY 1
NOCACHE;


--fecha y el total para la factura
CREATE OR REPLACE TRIGGER trg_fact
AFTER UPDATE OF Estado ON Reservas
FOR EACH ROW
WHEN (NEW.Estado = 'Confirmada')
BEGIN
    INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total)
    VALUES (
        SEQ_FACTURACION.NEXTVAL, 
        :NEW.ReservaID, 
        SYSDATE, 
        (SELECT PrecioPorNoche * (:NEW.FechaSalida - :NEW.FechaEntrada)
         FROM Habitaciones
         WHERE HabitacionID = :NEW.HabitacionID)
    );
END;
/