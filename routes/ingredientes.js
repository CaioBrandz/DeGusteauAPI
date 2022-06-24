const router = require("express").Router();
const pool = require("../database");
//const authorization = require("../middleware/authorization");


/*-------------------------------
| Todos os ingredientes e as médias de valores
|--------------------------------*/
router.get("/ingredientes", async (req, res) => {
  
  try {
    const ingredientes = await pool.query(
      "select i.nome,trunc(sum(ie.valor)/COUNT(*),2) as media "+ 
      "from ingrediente as i, estabelecimento as e,ingrediente_estabelecimento as ie "+
      "where i.id = ie.id_ingrediente "+
      "and e.id = ie.id_estabelecimento "+
      "group by i.nome",
      []
    );
    res.json(ingredientes.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


/*-------------------------------
| Ingrediente local e valor
|--------------------------------*/
router.get("/ingredientes/:id", async (req, res) => {
  
  try {
    const {id} = req.params;

    const ingredienteEstabelecimento= await pool.query(
      "select i.nome, e.id, e.nome, e.local_logradouro, "+
      "e.local_numero, e.geolocalizacao_lat, e.geolocalizacao_long, "+
      "ie.valor, ie.unidade from ingrediente as i, "+
      "estabelecimento as e, ingrediente_estabelecimento as ie "+
      "where i.id = ie.id_ingrediente "+
      "and e.id = ie.id_estabelecimento "+
      "and i.id = $1",
      [id]
    );
    res.json(ingredienteEstabelecimento.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});
module.exports = router;