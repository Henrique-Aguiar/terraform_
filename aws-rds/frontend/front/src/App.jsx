import { useState } from 'react';
import './App.css'

function App() {
  const [mensagem, setMensagem] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    // Enviar os dados para a rota /enviar-email da API
    fetch("http://api.dves.cloud/enviar-email", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ mensagem })
      
    })
      .then(response => response.json())
      .then(data => {
        console.log('Resposta da API:', data);
        // Aqui você pode exibir uma mensagem de sucesso ou fazer qualquer ação desejada após o envio do email
      })
      .catch(error => {
        console.error('Erro ao enviar o formulário:', error);
        // Aqui você pode exibir uma mensagem de erro ou fazer qualquer tratamento de erro desejado
      });
  };

  return (
    <div className='form'>
      <form onSubmit={handleSubmit}>
        <label htmlFor="mensagem">Mensagem:</label><br />
        <textarea id="mensagem" value={mensagem} onChange={(e) => setMensagem(e.target.value)} rows="4" required></textarea><br /><br />

        <button type="submit">Enviar</button>
      </form>
    </div>
  );
}

export default App;
