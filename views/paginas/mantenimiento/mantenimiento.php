<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

// Llamar al procedimiento almacenado
$stid = oci_parse($conn, 'BEGIN obtener_mantenimiento(:p_cursor); END;');

// Crear y asociar el cursor de salida
$cursor = oci_new_cursor($conn);
oci_bind_by_name($stid, ':p_cursor', $cursor, -1, OCI_B_CURSOR);

oci_execute($stid);
oci_execute($cursor);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mantenimiento - Mountain Bliss Resort</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../../public/build/css/styles.css" />
    <link rel="icon" href="../../../public/build/img/icon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="../../../public/build/img/icon.png" type="image/x-icon" />
</head>
<body>
    <!-- Sidebar -->
    <nav class="sidebar">
        <h2>Opciones Administrativas</h2>
        <a href="../../paginas/huespedes/huespedes.php">Gestionar Huéspedes</a>
        <a href="../../paginas/empleados/empleados.php">Gestionar Empleados</a>
        <a href="../../paginas/habitaciones/habitaciones.php">Gestionar Habitaciones</a>
        <a href="../../paginas/reservas/reservas.php">Gestionar Reservas</a>
        <a href="../../paginas/servicios/servicios.php">Gestionar Servicios</a>
        <a href="../../paginas/facturacion/facturacion.php">Gestionar Facturación</a>
        <a href="../../paginas/inventarios/inventarios.php">Gestionar Inventarios</a>
        <a href="../../paginas/mantenimiento/mantenimiento.php">Gestionar Mantenimiento</a>
        <a href="../../paginas/proovedores/proveedores.php">Gestionar Proveedores</a>
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
                <h1 style="color: #333">Mantenimiento de Habitaciones</h1>
                <a href="agregar_mantenimiento.php" class="button">Agregar Nuevo Mantenimiento</a>
                <a href="funciones/generar_reporte_mantenimiento.php" class="button">Filtrar Mantenimiento por Costo</a>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID de Mantenimiento</th>
                            <th>ID de Habitación</th>
                            <th>Fecha de Mantenimiento</th>
                            <th>Descripción</th>
                            <th>Costo</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while (($row = oci_fetch_assoc($cursor)) !== false): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['MANTENIMIENTOID'], ENT_QUOTES); ?></td>
                                <td><?php echo htmlspecialchars($row['HABITACIONID'], ENT_QUOTES); ?></td>
                                <td><?php echo htmlspecialchars($row['FECHAMANTENIMIENTO'], ENT_QUOTES); ?></td>
                                <td><?php echo htmlspecialchars($row['DESCRIPCION'], ENT_QUOTES); ?></td>
                                <td><?php echo htmlspecialchars($row['COSTO'], ENT_QUOTES); ?></td>
                                <td>
                                    <a href="editar_mantenimiento.php?id=<?php echo urlencode($row['MANTENIMIENTOID']); ?>" class="btn" style="background-color: #013e6a; color: white;">Editar</a> |
                                    <a href="eliminar_mantenimiento.php?id=<?php echo urlencode($row['MANTENIMIENTOID']); ?>" class="btn" style="background-color: #013e6a; color: white;" onclick="return confirm('¿Estás seguro de que deseas eliminar este mantenimiento?');">Eliminar</a>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer_area">
            <p class="footer_text">
                &copy; 2024 Mountain-Bliss-Resort. Todos los derechos reservados.
            </p>
        </footer>
    </div>

    <?php 
    oci_free_statement($stid);
    oci_free_statement($cursor);
    oci_close($conn); 
    ?>
</body>
</html>
