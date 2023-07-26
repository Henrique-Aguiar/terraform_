const express = require('express');
const cors = require('cors');
const nodemailer = require('nodemailer');
const db = require("./db");
// require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors())

app.get('/', (req, res) =>
  res.send("<h3>Rotas no Express</h3><p>Rota '/'")
);
app.post('/enviar-email', (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  const text = req.body;

  // Configurar o transporte SMTP
  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: process.env.SMTP_PORT,
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASSWORD,
    },
  });

  const emails = process.env.EMAIL_DESTINATION.split(',')

  // Configurar o email
  const mailOptions = {
    from: process.env.SMTP_USER,
    to: emails,
    subject: "contato",
    html: `<h1>${text.mensagem}</h1>`,
  };

  console.log('INSERT INTO CLIENTES');
  const result = db.insertCustomer(text.mensagem);
  console.log(result);

  // Enviar o email
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Erro ao enviar o email.' });
    } else {
      console.log('Email enviado:', info.response);
      res.json({ message: 'Email enviado com sucesso.' });
    }
  });
});
console.log(process.env.PORT)
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor iniciado na porta ${PORT}`);
});
