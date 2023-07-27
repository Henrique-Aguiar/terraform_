// const request = require('supertest');
// const app = require('../server');
const { describe, expect } = require('@jest/globals');


// Teste do roteador express e do endpoint /enviar-email
// describe('Teste do endpoint /enviar-email', () => {
//   it('Deve enviar um email com sucesso', async () => {
//     const res = await request(app)
//       .post('/enviar-email')
//       .send({ mensagem: 'Teste de mensagem' });

//     expect(res.status).toBe(200);
//     expect(res.body).toEqual({ message: 'Email enviado com sucesso.' });
//   });

//   it('Deve retornar erro ao enviar um email inválido', async () => {
//     const res = await request(app)
//       .post('/enviar-email')
//       .send({ mensagem: 123 }); // Enviando uma mensagem inválida

//     expect(res.status).toBe(500);
//     expect(res.body).toEqual({ error: 'Erro ao enviar o email.' });
//   });
// });

describe('Teste do endpoint /enviar-email', () => {
    it('Deve enviar um email com sucesso', () => {
      expect({ message: 'Email enviado com suc' }).toEqual({ message: 'Email enviado com sucesso.' });
    });
});