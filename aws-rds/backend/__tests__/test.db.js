const db = require('../db');
const { test, expect } = require('@jest/globals');


// Teste da função connect()
test('Deve conectar no banco de dados', async () => {
  const connection = await db.connect();
  expect(connection).toBeTruthy();
});

// Teste da função insertCustomer()
test('Deve inserir um cliente no banco de dados', async () => {
  const text = 'Cliente de teste';
  const result = await db.insertCustomer(text);
  expect(result[0].affectedRows).toBe(1);
});
