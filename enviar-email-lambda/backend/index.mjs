import nodemailer from 'nodemailer'
import dotenv from 'dotenv'
dotenv.config()

export const handler = async (event, context, callback) => {
  const response = {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': true,
      "Access-Control-Allow-Methods": "OPTIONS,POST,GET",
      'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'
    },
    body: JSON.stringify({ message: 'Email enviado com sucesso!' }),
  };
  
  const transportador = nodemailer.createTransport({ 
    host: process.env.SMTP_HOST,
    port: process.env.SMTP_PORT,
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASSWORD,
    },
  });
  
  console.log(event);
  const requestBody = JSON.parse(event.body);
  const message = requestBody.mensagem;

  const mailOptions = {
    from: process.env.SMTP_USER,
    to: process.env.EMAIL_DESTINATION,
    subject: 'contato',
    html: `<h1>${message}</h1>`,
  };
  
  try {
    const info = await transportador.sendMail(mailOptions);
    console.log('Email enviado:', info.response);
    callback(null, response);
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ message: 'Erro ao enviar o email.' }),
    };
  }
};

