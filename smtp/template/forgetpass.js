const htmltemplateforgetpass = `
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restablecer Contraseña</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .email-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
        }
        .email-header {
            background-color: #0059a5;
            color: white;
            padding: 10px;
            border-radius: 8px 8px 0 0;
            text-align: center;
        }
        .email-header h1 {
            margin: 0;
        }
        .email-body {
            padding: 20px;
        }
        .email-body p {
            line-height: 1.6;
        }
        .reset-button {
            background-color: #0059a5;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin: 20px 0;
        }
        .reset-button:hover {
            background-color: #004080;
        }
        .email-footer {
            text-align: center;
            color: #999;
            font-size: 12px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="email-container">
        <div class="email-header">
            <h1>Restablecer Contraseña</h1>
        </div>
        <div class="email-body">
            <p>Hola,</p>
            <p>Hemos recibido una solicitud para restablecer la contraseña de tu cuenta. Haz clic en el botón de abajo para restablecer tu contraseña:</p>
            <p><a href="$url/$token" class="reset-button">Restablecer Contraseña</a></p>
            <p>Si no solicitaste restablecer tu contraseña, por favor ignora este correo.</p>
            <p>Gracias,</p>
            <p>El equipo de Soporte</p>
        </div>
        <div class="email-footer">
            <p>© 2024 Conectando talentos. Todos los derechos reservados.</p>
        </div>
    </div>
</body>
</html>
`;

module.exports = htmltemplateforgetpass;