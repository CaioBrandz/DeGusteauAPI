const express = require('express');
const app = express();
const path = require('path');
const cors = require("cors");

app.use(cors());
app.use(express.json());


app.use("/preferencias", require("./routes/preferencias"));
app.use("/receitas", require("./routes/receitas"));
app.use("/ingredientes", require("./routes/ingredientes"));

/*
app.use("/auth", require("./routes/jwtAuth"));
*/

app.get('/', (request,response) =>{
    return response.json({message:'server is up'});
})

app.listen(process.env.PORT || 5000);
console.log("server on!");