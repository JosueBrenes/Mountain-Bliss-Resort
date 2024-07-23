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

--PROCEDIMIENTOS
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
    AND Estado = 'Disponible';
END;
/


-- ver info huesped por buscar id

CREATE OR REPLACE PROCEDURE OBTENER_HUESPED_POR_RESERVA (
    p_reserva_id IN Reservas.ReservaID%TYPE
) AS
BEGIN
    SELECT HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email
    FROM Huespedes
    WHERE HuespedID = (
        SELECT HuespedID
        FROM Reservas
        WHERE ReservaID = p_reserva_id
    );
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


-- actualizar precio habitacion por cambio de habitacion
CREATE OR REPLACE PROCEDURE UPDATE_ROOM_PRICE (
    ROOM_TYPE IN VARCHAR(50),
    NEW_PRICE IN NUMBER
) AS
BEGIN
    UPDATE ROOMS
    SET PRICE_PER_NIGHT = NEW_PRICE
    WHERE ROOM_TYPE = ROOM_TYPE;
END;
/

-- agregar empleado con dbms
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
