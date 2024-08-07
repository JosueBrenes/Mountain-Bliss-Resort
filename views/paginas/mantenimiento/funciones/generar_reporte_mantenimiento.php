<?php
// Incluir archivo de conexión a la base de datos
include '../../../../database/database.php';

// Variable para almacenar los mantenimientos
$mantenimientos = [];

// Verificar si se ha enviado una solicitud para obtener el reporte de mantenimiento
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['min_costo']) && isset($_POST['max_costo'])) {
    // Obtener los valores de costo del formulario
    $min_costo = $_POST['min_costo'];
    $max_costo = $_POST['max_costo'];

    // Preparar la consulta para llamar a la función
    $query = 'BEGIN :cursor := REPORTAR_MANTENIMIENTO_POR_COSTO(:min_costo, :max_costo); END;';
    $stid = oci_parse($conn, $query);

    // Crear un cursor para el resultado
    $cursor = oci_new_cursor($conn);

    // Bind variables
    oci_bind_by_name($stid, ':min_costo', $min_costo);
    oci_bind_by_name($stid, ':max_costo', $max_costo);
    oci_bind_by_name($stid, ':cursor', $cursor, -1, OCI_B_CURSOR);

    // Ejecutar la consulta
    if (!oci_execute($stid)) {
        $e = oci_error($stid);
        die("Error en la ejecución de la consulta: " . htmlentities($e['message'], ENT_QUOTES));
    }

    // Ejecutar el cursor
    if (!oci_execute($cursor)) {
        $e = oci_error($cursor);
        die("Error en la ejecución del cursor: " . htmlentities($e['message'], ENT_QUOTES));
    }

    // Recuperar los datos del cursor
    while (($row = oci_fetch_assoc($cursor)) !== false) {
        $mantenimientos[] = $row;
    }

    // Liberar los recursos
    oci_free_statement($stid);
    oci_free_statement($cursor);
}

// Cerrar la conexión
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Mantenimiento - Mountain-Bliss-Resort</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../../../public/build/css/styles.css">
    <link rel="icon" href="../../../../public/build/img/icon.png" type="image/x-icon">
    <link rel="shortcut icon" href="../../../../public/build/img/icon.png" type="image/x-icon">
</head>
<body>
    <!-- Sidebar -->
    <nav class="sidebar">
        <h2>Opciones Administrativas</h2>
        <a href="../../../paginas/huespedes/huespedes.php">Gestionar Huéspedes</a>
        <a href="../../../paginas/empleados/empleados.php">Gestionar Empleados</a>
        <a href="../../../paginas/habitaciones/habitaciones.php">Gestionar Habitaciones</a>
        <a href="../../../paginas/reservas/reservas.php">Gestionar Reservas</a>
        <a href="../../../paginas/servicios/servicios.php">Gestionar Servicios</a>
        <a href="../../../paginas/facturacion/facturacion.php">Gestionar Facturación</a>
        <a href="../../../paginas/inventarios/inventarios.php">Gestionar Inventarios</a>
        <a href="../../../paginas/mantenimiento/mantenimiento.php">Gestionar Mantenimiento</a>
        <a href="../../../paginas/proovedores/proveedores.php">Gestionar Proveedores</a>
    </nav>

    <!-- Content -->
    <div class="content">
        <!-- Header -->
        <header class="header_area">
            <a href="../../../public/index.php" class="header_link">
                <h1>Mountain-Bliss-Resort</h1>
            </a>
        </header>
        
        <!-- Main Content -->
        <section class="options_area">
            <div class="container">
                <div class="row">
                    <div class="container">
                        <h1 style="color: #333">Reporte de Mantenimiento por Costo</h1>
                        <form method="POST" action="" class="mb-4">
                            <div class="form-group">
                                <label for="min_costo">Costo Mínimo:</label>
                                <input type="number" id="min_costo" name="min_costo" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="max_costo">Costo Máximo:</label>
                                <input type="number" id="max_costo" name="max_costo" class="form-control" required>
                            </div>
                            <button type="submit" class="button">Generar Reporte</button>
                        </form>
                        <?php if (!empty($mantenimientos)): ?>
                            <div class="result">
                                <h2 style="color: #333;">Mantenimientos con Costo entre <?php echo htmlspecialchars($min_costo, ENT_QUOTES); ?> y <?php echo htmlspecialchars($max_costo, ENT_QUOTES); ?></h2>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>ID Habitacion</th>
                                            <th>Fecha</th>
                                            <th>Descripción</th>
                                            <th>Costo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($mantenimientos as $mantenimiento): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($mantenimiento['MANTENIMIENTOID'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars($mantenimiento['HABITACIONID'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars(date('d/m/Y', strtotime($mantenimiento['FECHAMANTENIMIENTO'])), ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars($mantenimiento['DESCRIPCION'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars(number_format($mantenimiento['COSTO'], 2), ENT_QUOTES); ?></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer_area">
            <p class="footer_text">
                &copy; 2024 Mountain-Bliss-Resort. Todos los derechos reservados.
            </p>
        </footer>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
