const router = require("express").Router();
const pool = require("../database");
//const authorization = require("../middleware/authorization");


/*-------------------------------
| Retornar as receitas de acordo com os ids das preferências
|--------------------------------*/
router.post("/", async (req, res) => {
  
  try {
    
    const {preferenciasArray} = req.body;

    const receitas = await pool.query(
      "Select distinct r.id,r.nome, r.tempo_preparo,array_agg(distinct i.nome) as ingredientes, im.filename "+
      "from receita as r, receita_categoria as rc,categoria as c, ingrediente as i, ingrediente_receita as ir, imagem as im "+
      "where r.id = rc.id_receita and c.id = rc.id_categoria and r.id = ir.id_receita and i.id = ir.id_ingrediente "+
      "and c.id = ANY($1) "+
      "and r.id_imagem = im.id "+
      "group by r.nome, r.id, r.tempo_preparo, im.filename "+
      "order by r.nome asc",
      //"and c.id = ANY(ARRAY[1, 2]) ",
      [preferenciasArray]
    );
    res.json(receitas.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


/*-------------------------------
| Retornar as receitas de acordo com os ingredientes inclusos
|--------------------------------*/
router.post("/resultados", async (req, res) => {
  try {
    
    const {ingredientesArray} = req.body;

    const receitasBusca = await pool.query(
      "select * from (Select distinct r.id,r.nome, r.tempo_preparo, im.filename, array_agg(distinct i.nome) as ingredientes, array_agg(distinct i.id) as ids "+
      "from receita as r, receita_categoria as rc,categoria as c, ingrediente as i, ingrediente_receita as ir, imagem as im "+
      "where r.id = rc.id_receita and c.id = rc.id_categoria and r.id = ir.id_receita and i.id = ir.id_ingrediente and r.id_imagem = im.id "+ 
      "group by r.nome, r.id, r.tempo_preparo, im.filename order by r.nome asc)as queryreceitas where ids && $1",
      //group by r.nome, r.id, r.tempo_preparo order by r.nome asc)as queryreceitas where ids && array[2]
      [ingredientesArray]
    );
    res.json(receitasBusca.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


/*-------------------------------
| Retornar dados de um receita específica
|--------------------------------*/
router.get("/:id", async (req, res) => {
  
  try {
    const {id} = req.params;

    const receita = await pool.query(
      "select r.id,r.nome,r.tempo_preparo,r.modo_preparo,im.filename from receita as r, imagem as im "+
      "where r.id_imagem = im.id "+
      "and r.id = $1",
      [id]
    );
    res.json(receita.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


/*-------------------------------
| Retornar ingredientes de um receita específica
|--------------------------------*/
router.get("/:id/ingredientes", async (req, res) => {
  
  try {
    const {id} = req.params;

    const receitaIngredientes = await pool.query(
      "select i.id, i.nome, ir.quantidade, ir.unidade, im.filename "+
      "from receita as r, ingrediente as i, ingrediente_receita as ir , imagem as im "+
      "where r.id = ir.id_receita "+ 
      "and i.id = ir.id_ingrediente "+ 
      "and i.id_imagem = im.id "+
      "and r.id = $1 "+
      "order by i.nome asc",
      [id]
    );
    res.json(receitaIngredientes.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


/*-------------------------------
| Ingredientes da receita unica e media de valores do ingrediente
|--------------------------------*/
router.get("/:id/ingredientes/medias", async (req, res) => {
  
  try {
    const {id} = req.params;

    const receitaIngredientesMedia = await pool.query(
      "select i.nome,trunc(sum(ie.valor)/COUNT(*),2) as media, ie.unidade, im.filename "+
      "from ingrediente_receita as ir, ingrediente as i, receita as r, ingrediente_estabelecimento as ie, imagem as im "+
      "where i.id = ir.id_ingrediente "+
      "and r.id = ir.id_receita "+
      "and i.id_imagem = im.id "+
      "and i.id = ie.id_ingrediente "+
      "and r.id = $1 "+
      "group by i.nome, ie.unidade, im.filename",
      [id]
    );
    res.json(receitaIngredientesMedia.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


module.exports = router;