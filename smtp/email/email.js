const nodemailer = require('nodemailer');
require('dotenv').config();


class GmailService {
    async sendEmail(To, subject, html) {
        const config = {
            host: "smtp.gmail.com",
            port: 587,
            auth: {
                user: process.env.EMAILFRON,
                pass: process.env.SENDEMAILTOKEN,
            },
        };

        const head = {
            from: process.env.EMAILFRON,
            to: To,
            subject: subject,
            html: html,
        };

        const transporter = nodemailer.createTransport(config);

         const response = new Promise((resolve, reject) => {
            transporter.sendMail(head, (error, info) => {
                if (error) {
                    reject(new BadRequestException(error));
                } else {
                    resolve(info);
                }
            });
        });
        return await response;
    }
}



module.exports = GmailService;


