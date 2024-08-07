<?php
// Incluir archivo de conexión a la base de datos
include '../../../../database/database.php';

// Variable para almacenar los servicios
$servicios = [];

// Verificar si se ha enviado una solicitud para obtener el reporte de servicios
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['precio_minimo']) && isset($_POST['precio_maximo'])) {
    // Obtener los precios del formulario
    $precio_minimo = $_POST['precio_minimo'];
    $precio_maximo = $_POST['precio_maximo'];

    // Preparar la consulta para llamar a la función
    $query = 'BEGIN :cursor := REPORTAR_SERVICIOS_POR_PRECIO(:precio_minimo, :precio_maximo); END;';
    $stid = oci_parse($conn, $query);

    // Crear un cursor para el resultado
    $cursor = oci_new_cursor($conn);

    // Bind variables
    oci_bind_by_name($stid, ':precio_minimo', $precio_minimo);
    oci_bind_by_name($stid, ':precio_maximo', $precio_maximo);
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
        $servicios[] = $row;
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
    <title>Reporte de Servicios - Mountain-Bliss-Resort</title>
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
        <a href="../../../paginas/inventarios/cantidad_inventario_por_habitacion.php">Ver Cantidades de Inventario</a>
        <a href="../../../paginas/mantenimiento/mantenimiento.php">Gestionar Mantenimiento</a>
        <a href="../../../paginas/proveedores/proveedores.php">Gestionar Proveedores</a>
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
                        <h1 style="color: #333">Reporte de Servicios</h1>
                        <form method="POST" action="" class="mb-4">
                            <div class="form-group">
                                <label for="precio_minimo">Precio Mínimo:</label>
                                <input type="number" id="precio_minimo" name="precio_minimo" class="form-control" step="0.01" min="0" required>
                            </div>
                            <div class="form-group">
                                <label for="precio_maximo">Precio Máximo:</label>
                                <input type="number" id="precio_maximo" name="precio_maximo" class="form-control" step="0.01" min="0" required>
                            </div>
                            <button type="submit" class="button">Generar Reporte</button>
                        </form>
                        <?php if (!empty($servicios)): ?>
                            <div class="result">
                                <h2 style="color: #333;">Servicios con Precio entre <?php echo htmlspecialchars($precio_minimo, ENT_QUOTES); ?> y <?php echo htmlspecialchars($precio_maximo, ENT_QUOTES); ?></h2>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID Servicio</th>
                                            <th>Nombre Servicio</th>
                                            <th>Descripción</th>
                                            <th>Precio</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($servicios as $servicio): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($servicio['SERVICIOID'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars($servicio['NOMBRESERVICIO'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars($servicio['DESCRIPCION'], ENT_QUOTES); ?></td>
                                                <td><?php echo htmlspecialchars(number_format($servicio['PRECIO'], 2), ENT_QUOTES); ?></td>
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
