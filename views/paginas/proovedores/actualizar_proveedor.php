<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $proveedor_id = $_POST['proveedor_id'];
    $nombre = $_POST['nombre'];
    $direccion = $_POST['direccion'];
    $telefono = $_POST['telefono'];
    $email = $_POST['email'];

    if (empty($proveedor_id) || empty($nombre)) {
        die("El ID del proveedor y el nombre son requeridos.");
    }

    $sql = 'UPDATE Proveedores SET Nombre = :nombre, Direccion = :direccion, Telefono = :telefono, Email = :email WHERE ProveedorID = :proveedor_id';
    $stid = oci_parse($conn, $sql);

    oci_bind_by_name($stid, ':proveedor_id', $proveedor_id);
    oci_bind_by_name($stid, ':nombre', $nombre);
    oci_bind_by_name($stid, ':direccion', $direccion);
    oci_bind_by_name($stid, ':telefono', $telefono);
    oci_bind_by_name($stid, ':email', $email);

    if (oci_execute($stid)) {
        header('Location: proveedores.php?msg=Proveedor actualizado con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar el proveedor: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
