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



--VISTAS

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
