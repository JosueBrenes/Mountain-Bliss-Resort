<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

$sql = 'SELECT * FROM Empleados';
$stid = oci_parse($conn, $sql);

oci_execute($stid);
?>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Empleados - Mountain-Bliss-Resort</title>
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />
    <link rel="stylesheet" href="../../../public/build/css/styles.css" />
    <link rel="icon" href="../public/build/img/icon.png" type="image/x-icon" />
    <link
      rel="shortcut icon"
      href="../public/build/img/icon.png"
      type="image/x-icon"
    />
  </head>
  <body>
    <!-- Sidebar -->
    <nav class="sidebar">
      <h2>Opciones Administrativas</h2>
      <a href="../../paginas/huespedes/huespedes.php">Gestionar Huéspedes</a>
      <a href="../../paginas/empleados/empleados.php">Gestionar Empleados</a>
      <a href="../../paginas/habitaciones/habitaciones.php"
        >Gestionar Habitaciones</a
      >
      <a href="../../paginas/reservas/reservas.php">Gestionar Reservas</a>
      <a href="../../paginas/servicios/servicios.php">Gestionar Servicios</a>
      <a href="../../paginas/facturacion/facturacion.php"
        >Gestionar Facturación</a
      >
      <a href="../../paginas/inventarios/inventarios.php"
        >Gestionar Inventarios</a
      >
      <a href="../../paginas/inventarios/cantidad_inventario_por_habitacion.php"
        >Ver Cantidades de Inventario</a
      >
      <a href="../../paginas/mantenimiento/mantenimiento.php"
        >Gestionar Mantenimiento</a
      >
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
          <div class="row">
            <div class="container">
              <h1 style="color: #333">Empleados</h1>
              <a href="agregar_empleado.php" class="button"
                >Agregar Nuevo Empleado</a
              >
              <table>
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Puesto</th>
                    <th>Fecha de Contratación</th>
                    <th>Salario</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <?php while (($row = oci_fetch_assoc($stid)) !== false): ?>
                  <tr>
                    <td>
                      <?php echo htmlspecialchars($row['EMPLEADOID'], ENT_QUOTES); ?>
                    </td>
                    <td>
                      <?php echo htmlspecialchars($row['NOMBRE'], ENT_QUOTES); ?>
                    </td>
                    <td>
                      <?php echo htmlspecialchars($row['APELLIDO'], ENT_QUOTES); ?>
                    </td>
                    <td>
                      <?php echo htmlspecialchars($row['PUESTO'], ENT_QUOTES); ?>
                    </td>
                    <td>
                      <?php echo htmlspecialchars($row['FECHACONTRATACION'], ENT_QUOTES); ?>
                    </td>
                    <td>
                      <?php echo htmlspecialchars($row['SALARIO'], ENT_QUOTES); ?>
                    </td>
                    <td>
                      <a
                        href="editar_empleado.php?id=<?php echo urlencode($row['EMPLEADOID']); ?>"
                        >Editar</a
                      >
                      |
                      <a
                        href="eliminar_empleado.php?id=<?php echo urlencode($row['EMPLEADOID']); ?>"
                        >Eliminar</a
                      >
                    </td>
                  </tr>
                  <?php endwhile; ?>
                </tbody>
              </table>
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

    <?php 
    oci_free_statement($stid);
    oci_close($conn); 
    ?>
  </body>
</html>
