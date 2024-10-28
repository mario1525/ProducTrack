var express = require('express');
const nodemailer = require('nodemailer');
require('dotenv').config();

var router = express.Router();


router.get('/', function (req, res, next) {
  res.sendStatus('running smtp service');
});

router.post('/smtp', function (req, res) {

  const { to, subject, message } = req.body;

  if (!to || !subject || !message) {
    res.status(400).send('Por favor, proporciona todos los campos requeridos: to, subject, y message');
    return;
  }

  try {
    sendNotification(to, subject, message);
    res.status(200).send('Notificación enviada con éxito');
  } catch (error) {
    console.error('Error al enviar la notificación: ', error);
    res.status(500).send('Error al enviar la notificación');
  }
 
});



// Configurar el transporte SMTP usando las variables de entorno
const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: Number(process.env.SMTP_PORT),
  secure: false, // true para puerto 465, false para otros puertos como 587
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS,
  },
});

const sendNotification = async (to, subject, html) => {
  try {
    const info = await transporter.sendMail({
      from: `"Notificaciones" <${process.env.SMTP_USER}>`,
      to: to,
      subject: subject,
      html: html,
    });

    console.log('Correo enviado: %s', info.messageId);
  } catch (error) {
    console.error('Error enviando correo: %s', error);
  }
};

module.exports = router;
