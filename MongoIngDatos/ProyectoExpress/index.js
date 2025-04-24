const express=require('express');
const app=express();
const port=3000;

//ruta principal
app.get('/',(req,res) =>{
    res.send('Hola mundo');
});

//Iniciar servidor
app.listen(port,()=>{
    console.log(`Servidor corriendo sobre http://localhost:${port}`);
});