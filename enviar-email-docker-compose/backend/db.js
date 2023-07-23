async function connect(){
    if(global.connection && global.connection.state !== 'disconnected')
        return global.connection;
 
    const mysql = require("mysql2/promise");
    const connection = await mysql.createConnection("mysql://henrique:root@db:3306/db_1");
    console.log("Conectou no MySQL!");
    global.connection = connection;
    return connection;
}


async function insertCustomer(text){
  const conn = await connect();
  const sql = 'INSERT INTO message(text) VALUES (?);';
  return await conn.query(sql, text);
}

module.exports = {insertCustomer}
// module.exports = connect