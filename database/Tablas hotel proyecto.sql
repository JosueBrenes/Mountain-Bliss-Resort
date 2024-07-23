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




