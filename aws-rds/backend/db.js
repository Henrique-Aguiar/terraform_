async function connect(){
    if(global.connection && global.connection.state !== 'disconnected')
        return global.connection;
 
    const mysql = require("mysql2/promise");
    const connection = await mysql.createConnection("mysql://admin:12345678@database-1.chacnvuwqiul.us-east-1.rds.amazonaws.com:3306/db_2");
    console.log("Conectou no MySQL!");
    global.connection = connection;
    return connection;
}


async function insertCustomer(text){
  try {
    const conn = await connect();
    const sql = 'INSERT INTO message(text) VALUES (?);';
    return await conn.query(sql, text);
  } catch (error) {
    // Aqui você pode fazer o tratamento do erro, por exemplo, registrar o erro em um log ou retornar uma mensagem de erro ao usuário.
    console.error('Erro ao inserir o cliente:', error);
    // throw new Error('Erro ao inserir o cliente. Por favor, tente novamente mais tarde.');
  }
}

module.exports = {insertCustomer}