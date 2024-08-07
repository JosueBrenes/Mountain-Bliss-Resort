<?php
// Incluir archivo de conexión a la base de datos
include '../../../../database/database.php';

// Variable para almacenar las habitaciones
$habitaciones = [];

// Verificar si se ha enviado una solicitud para obtener la lista de habitaciones
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['estado'])) {
    // Obtener el estado del formulario
    $estado = $_POST['estado'];

    // Preparar la consulta para llamar a la función
    $query = 'BEGIN :cursor := FILTRAR_HABITACIONES_POR_ESTADO(:estado); END;';
    $stid = oci_parse($conn, $query);

    // Crear un cursor para el resultado
    $cursor = oci_new_cursor($conn);

    // Bind variables
    oci_bind_by_name($stid, ':estado', $estado);
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
        $habitaciones[] = $row;
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
    <title>Habitaciones por Estado - Mountain-Bliss-Resort</title>
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
                        <h1 style="color: #333">Habitaciones por Estado</h1>
                        <form method="POST" action="" class="mb-4">
                            <div class="form-group">
                                <label for="estado">Estado:</label>
                                <select id="estado" name="estado" class="form-control" required>
                                    <option value="">Selecciona un estado</option>
                                    <option value="Disponible">Disponible</option>
                                    <option value="Ocupada">Ocupada</option>
                                    <option value="Mantenimiento">Mantenimiento</option>
                                </select>
                            </div>
                            <button type="submit" class="button">Filtrar Habitaciones</button>
                        </form>
                        <?php if (!empty($habitaciones)): ?>
                            <div class="result">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Número de Habitación</th>
                                            <th>Tipo de Habitación</th>
                                            <th>Precio por Noche</th>
                                            <th>Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($habitaciones as $habitacion): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($habitacion['HABITACIONID'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars($habitacion['NUMEROHABITACION'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars($habitacion['TIPOHABITACION'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars(number_format($habitacion['PRECIOPORNOCHE'], 2), ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars($habitacion['ESTADO'], ENT_QUOTES); ?></td>
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
