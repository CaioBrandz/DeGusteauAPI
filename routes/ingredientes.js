const router = require("express").Router();
const pool = require("../database");
//const authorization = require("../middleware/authorization");


/*-------------------------------
| Todos os ingredientes e as médias de valores (só os que estão em venda)
|--------------------------------*/
router.get("/", async (req, res) => {
  
  try {
    const ingredientes = await pool.query(
      "select i.id,i.nome,im.filename "+
      "from ingrediente as i,imagem as im "+
      "where i.id_imagem = im.id "+
      "order by i.nome asc",
      []
    );
    res.json(ingredientes.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


/*-------------------------------
| Todos os ingredientes
|--------------------------------*/
router.get("/venda", async (req, res) => {
  
  try {
    const ingredientes = await pool.query(
      "select i.id,i.nome,im.filename,trunc(sum(ie.valor)/COUNT(*),2) as media "+
      "from ingrediente as i, estabelecimento as e,ingrediente_estabelecimento as ie, imagem as im "+
      "where i.id = ie.id_ingrediente "+
      "and e.id = ie.id_estabelecimento "+
      "and i.id_imagem = im.id "+
      "group by i.id,i.nome,im.filename "+
      "order by i.nome asc",
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
router.get("/:id", async (req, res) => {
  
  try {
    const {id} = req.params;

    const ingredienteEstabelecimento= await pool.query(
      "select i.nome as ingrediente, e.id, e.nome, e.local_logradouro, "+
      "e.local_numero, e.geolocalizacao_lat, e.geolocalizacao_long, "+
      "ie.valor, ie.unidade, im.filename from ingrediente as i, "+
      "estabelecimento as e, ingrediente_estabelecimento as ie, imagem as im "+
      "where i.id = ie.id_ingrediente "+
      "and e.id_imagem = im.id "+
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