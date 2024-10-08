<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $factura_id = $_POST['factura_id'];
    $reserva_id = $_POST['reserva_id'];
    $fecha_factura = $_POST['fecha_factura'];
    $total = $_POST['total'];

    if (empty($factura_id) || empty($reserva_id) || empty($fecha_factura) || empty($total)) {
        die("Todos los campos son requeridos.");
    }

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN ACTUALIZAR_FACTURA(:factura_id, :reserva_id, TO_DATE(:fecha_factura, \'YYYY-MM-DD\'), :total); END;';
    $stid = oci_parse($conn, $sql);

    // Enlazar los parámetros
    oci_bind_by_name($stid, ':factura_id', $factura_id);
    oci_bind_by_name($stid, ':reserva_id', $reserva_id);
    oci_bind_by_name($stid, ':fecha_factura', $fecha_factura);
    oci_bind_by_name($stid, ':total', $total);

    // Ejecutar la llamada al procedimiento almacenado
    if (oci_execute($stid)) {
        header('Location: facturacion.php?msg=Factura actualizada con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar la factura: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
