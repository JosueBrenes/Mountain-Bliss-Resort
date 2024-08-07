<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Obtener los datos del formulario
    $nombre_proveedor = isset($_POST['nombre_proveedor']) ? $_POST['nombre_proveedor'] : '';
    $direccion = isset($_POST['direccion']) ? $_POST['direccion'] : '';
    $telefono = isset($_POST['telefono']) ? $_POST['telefono'] : '';

    // Verificar que todos los campos están presentes
    if (empty($nombre_proveedor) || empty($direccion) || empty($telefono)) {
        die("Todos los campos son requeridos.");
    }

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN INSERTAR_PROVEEDOR(:nombre_proveedor, :direccion, :telefono); END;';
    $stid = oci_parse($conn, $sql);

    // Enlazar los parámetros
    oci_bind_by_name($stid, ':nombre_proveedor', $nombre_proveedor);
    oci_bind_by_name($stid, ':direccion', $direccion);
    oci_bind_by_name($stid, ':telefono', $telefono);

    // Ejecutar la llamada al procedimiento almacenado
    if (oci_execute($stid)) {
        header('Location: proveedores.php?msg=Proveedor agregado con éxito');
        exit();
    } else {
        $error = oci_error($stid);
        die("Error al agregar el proveedor: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
?>
