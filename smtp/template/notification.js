const htmltemplatenotification = `
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuevo Mensaje Recibido</title>
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
        .message-button {
            background-color: #0059a5;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin: 20px 0;
        }
        .message-button:hover {
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
            <h1>Nuevo Mensaje Recibido</h1>
        </div>
        <div class="email-body">
        <p>Has recibido un nuevo mensaje de <strong>$Remitenteemail</strong>.</p>
        <p>su nombre es: <strong>$Remitente</strong>.</p>
        <p>Hola, Desarroladores</p>
        <p>Este es el mensaje:</p>
            <p>$message</p>
        </div>
        <div class="email-footer">
            <p>© 2024 Conectando Talentos. Todos los derechos reservados.</p>
        </div>
    </div>
</body>
</html>
 `
module.exports = htmltemplatenotification;