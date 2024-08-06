<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$puesto = $_POST['puesto'];
$fecha_contratacion = $_POST['fecha_contratacion'];
$salario = $_POST['salario'];

try {
    $fecha_contratacion_dt = new DateTime($fecha_contratacion);
    $fecha_contratacion_formateada = $fecha_contratacion_dt->format('Y-m-d');
} catch (Exception $e) {
    echo "Error al formatear la fecha: " . $e->getMessage();
    exit;
}

$query = 'SELECT Empleado_SEQ.NEXTVAL AS id_empleado FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_empleado = $row['ID_EMPLEADO'];

$sql = 'INSERT INTO Empleados (EmpleadoID, Nombre, Apellido, Puesto, FechaContratacion, Salario) 
        VALUES (:id_empleado, :nombre, :apellido, :puesto, TO_DATE(:fecha_contratacion, \'YYYY-MM-DD\'), :salario)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_empleado', $id_empleado);
oci_bind_by_name($stid, ':nombre', $nombre);
oci_bind_by_name($stid, ':apellido', $apellido);
oci_bind_by_name($stid, ':puesto', $puesto);
oci_bind_by_name($stid, ':fecha_contratacion', $fecha_contratacion_formateada);
oci_bind_by_name($stid, ':salario', $salario);

$success = oci_execute($stid);

if ($success) {
    header('Location: empleados.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar empleado: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
