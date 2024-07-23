<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Mountain-Bliss-Resort</title>
  <link
    rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
  />
  <link rel="stylesheet" href="../public/build/css/styles.css" />
  <link rel="icon" href="../public/build/img/icon.png" type="image/x-icon" />
  <link
    rel="shortcut icon"
    href="../public/build/img/icon.png"
    type="image/x-icon"
  />
</head>

<body>
  <header class="navbar">
    <a href="../public/index.php">
      <img src="../public/build/img/logo.png" alt="Logo" />
    </a>
    <nav class="menu">
      <a href="./index.php">Inicio</a>
      <a href="../views/paginas/services.php">Servicios</a>
      <a href="../views/paginas/prices.php">Precios</a>
      <a href="../views/paginas/about_us.php">Sobre nosotros</a>
      <?php
      session_start();
      $loggedIn = isset($_SESSION['correo']);
      ?>
      <?php if ($loggedIn): ?>
        <a href="../views/paginas/bookings.php">Reservaciones</a>
        <a href="../views/auth/logout.php" class="btn-login">Cerrar sesión</a>
      <?php else: ?>
        <a href="../views/auth/login.php" class="btn-login">Iniciar sesión</a>
      <?php endif; ?>
      <a
        href="../views/paginas/contact_us.php"
        class="btn-contact"
        style="background-color: #F54670"
        >Contáctenos</a
      >
    </nav>
  </header>

  <!-- Contenido principal -->
  <div class="hero">
    <div class="hero-text">
      <h1>Bienvenido a Mountain-Bliss-Resort</h1>
      <p>Disfruta de una experiencia única en la montaña</p>
      <a href="../views/paginas/bookings.php" class="btn-booking">Reserva Ahora</a>
    </div>
  </div>

  <!-- Footer -->
  <?php include '../views/templates/footer.php'; ?>
</body>
</html>
