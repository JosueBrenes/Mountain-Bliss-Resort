<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $empleado_id = $_POST['empleado_id'];
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $puesto = $_POST['puesto'];
    $fecha_contratacion = $_POST['fecha_contratacion'];
    $salario = $_POST['salario'];

    if (empty($empleado_id) || empty($nombre) || empty($apellido)) {
        die("Los campos Nombre y Apellido son requeridos.");
    }

    $sql = 'UPDATE Empleados SET Nombre = :nombre, Apellido = :apellido, Puesto = :puesto, FechaContratacion = TO_DATE(:fecha_contratacion, \'YYYY-MM-DD\'), Salario = :salario WHERE EmpleadoID = :empleado_id';
    $stid = oci_parse($conn, $sql);

    oci_bind_by_name($stid, ':empleado_id', $empleado_id);
    oci_bind_by_name($stid, ':nombre', $nombre);
    oci_bind_by_name($stid, ':apellido', $apellido);
    oci_bind_by_name($stid, ':puesto', $puesto);
    oci_bind_by_name($stid, ':fecha_contratacion', $fecha_contratacion);
    oci_bind_by_name($stid, ':salario', $salario);

    if (oci_execute($stid)) {
        header('Location: empleados.php?msg=Empleado actualizado con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar el empleado: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
