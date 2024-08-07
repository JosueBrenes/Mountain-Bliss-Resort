<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Obtener los datos del formulario
    $reserva_id = isset($_POST['reserva_id']) ? $_POST['reserva_id'] : '';
    $fecha_factura = isset($_POST['fecha_factura']) ? $_POST['fecha_factura'] : '';
    $total = isset($_POST['total']) ? $_POST['total'] : '';

    // Verificar que todos los campos están presentes
    if (empty($reserva_id) || empty($fecha_factura) || empty($total)) {
        die("Todos los campos son requeridos.");
    }

    // Verificar si el ReservaID existe
    $check_query = 'SELECT COUNT(*) AS count FROM Reservas WHERE ReservaID = :reserva_id';
    $check_stid = oci_parse($conn, $check_query);
    oci_bind_by_name($check_stid, ':reserva_id', $reserva_id);
    oci_execute($check_stid);
    $check_row = oci_fetch_assoc($check_stid);

    if ($check_row['COUNT'] == 0) {
        die("El ID de reserva proporcionado no existe.");
    }

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN INSERTAR_FACTURA(:reserva_id, TO_DATE(:fecha_factura, \'YYYY-MM-DD\'), :total); END;';
    $stid = oci_parse($conn, $sql);

    // Enlazar los parámetros
    oci_bind_by_name($stid, ':reserva_id', $reserva_id);
    oci_bind_by_name($stid, ':fecha_factura', $fecha_factura);
    oci_bind_by_name($stid, ':total', $total);

    // Ejecutar la llamada al procedimiento almacenado
    if (oci_execute($stid)) {
        header('Location: facturacion.php?msg=Factura agregada con éxito');
        exit();
    } else {
        $error = oci_error($stid);
        die("Error al agregar la factura: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_free_statement($check_stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
?>
