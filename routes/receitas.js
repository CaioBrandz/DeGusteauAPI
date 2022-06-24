const router = require("express").Router();
const pool = require("../database");
//const authorization = require("../middleware/authorization");


/*-------------------------------
| Retornar as receitas de acordo com os ids das preferências
|--------------------------------*/
router.get("/receitas", async (req, res) => {
  
  try {
    
    const {preferenciasArray} = req.body;

    const receitas = await pool.query(
      "Select distinct r.nome from receita as r, receita_categoria as rc,categoria as c "+
      "where r.id = rc.id_receita "+
      "and c.id = rc.id_categoria "+
      //"and c.id = ANY(ARRAY[1, 2])",
      "and c.id = ANY($1)",
      [preferenciasArray]
    );
    res.json(receitas.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


/*-------------------------------
| Retornar dados de um receita específica
|--------------------------------*/
router.get("/receitas/:id", async (req, res) => {
  
  try {
    const {id} = req.params;

    const receita = await pool.query(
      "select * from receita as r where r.id = $1",
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
router.get("/receitas/:id/ingredientes", async (req, res) => {
  
  try {
    const {id} = req.params;

    const receitaIngredientes = await pool.query(
      "select i.id, i.nome, ir.quantidade, ir.unidade "+
      "from receita as r, ingrediente as i, ingrediente_receita as ir "+
      "where r.id = ir.id_receita "+
      "and i.id = ir.id_ingrediente "+
      "and r.id = $1",
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
router.get("/receitas/:id/ingredientes/medias", async (req, res) => {
  
  try {
    const {id} = req.params;

    const receitaIngredientesMedia = await pool.query(
      "select i.nome,trunc(sum(ie.valor)/COUNT(*),2) as media "+
      "from ingrediente_receita as ir, ingrediente as i, receita as r, ingrediente_estabelecimento as ie "+
      "where i.id = ir.id_ingrediente "+
      "and r.id = ir.id_receita "+
      "and i.id = ie.id_ingrediente "+
      "and r.id = $1 "+
      "group by i.nome",
      [id]
    );
    res.json(receitaIngredientesMedia.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


module.exports = router;