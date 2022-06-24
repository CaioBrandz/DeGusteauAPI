const router = require("express").Router();
const pool = require("../database");
//const authorization = require("../middleware/authorization");


/*-------------------------------
| Retornar todas as preferências
|--------------------------------*/
router.get("/", async (req, res) => {
  
  try {
    const preferencias = await pool.query(
      "SELECT * FROM categoria WHERE tipo = 'PREF'",
      []
    );
    res.json(preferencias.rows);

  } catch (err) {
    console.error(err.message);
    res.status(500).send("Server Error!");
  }
});


module.exports = router;