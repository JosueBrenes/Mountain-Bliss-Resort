<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

$sql = 'SELECT * FROM Facturacion';
$stid = oci_parse($conn, $sql);

oci_execute($stid);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Facturación - Mountain-Bliss-Resort</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../../public/build/css/styles.css" />
    <link rel="icon" href="../public/build/img/icon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="../public/build/img/icon.png" type="image/x-icon" />
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
                <h1 style="color: #333">Facturación</h1>
                <a href="agregar_facturacion.php" class="button">Agregar Nueva Factura</a>
                <a href="funciones/generar_reporte_facturacion.php" class="button">Filtrar Factura por fecha</a>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Reserva ID</th>
                            <th>Fecha de Factura</th>
                            <th>Total</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($row = oci_fetch_assoc($stid)): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($row['FACTURAID'], ENT_QUOTES); ?></td>
                                <td><?php echo htmlspecialchars($row['RESERVAID'], ENT_QUOTES); ?></td>
                                <td><?php echo htmlspecialchars(date('d-m-Y', strtotime($row['FECHAFACTURA'])), ENT_QUOTES); ?></td>
                                <td><?php echo htmlspecialchars(number_format($row['TOTAL'], 2), ENT_QUOTES); ?></td>
                                <td>
                                    <a href="editar_factura.php?id=<?php echo htmlspecialchars($row['FACTURAID'], ENT_QUOTES); ?>" class="btn btn-sm" style="background-color: #013e6a; color: white;">Editar</a>
                                    <a href="eliminar_factura.php?id=<?php echo htmlspecialchars($row['FACTURAID'], ENT_QUOTES); ?>" class="btn btn-sm" style="background-color: #013e6a; color: white;" onclick="return confirm('¿Estás seguro de que deseas eliminar esta factura?');">Eliminar</a>
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
    oci_close($conn); 
    ?>
</body>
</html>
