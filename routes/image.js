const router = require("express").Router();
const pool = require("../database");
const multer = require('multer');
const path = require('path');

// Create multer object
const imageUpload = multer({
    storage: multer.diskStorage(
        {
            destination: function (req, file, cb) {
                cb(null, 'images/');
            },
            filename: function (req, file, cb) {
                cb(
                    null,
                    new Date().valueOf() + 
                    '_' +
                    file.originalname
                );
            }
        }
    ), 
});

/*-------------------------------
| Fazer upload da imagem
|--------------------------------*/
router.post('/', imageUpload.single('image'), async (req, res) => {
    try {
    
        const { filename, mimetype, size } = req.file;
        const filepath = req.file.path;
        const tabela = req.body.tabela;

        const upload = await pool.query(
            "insert into imagem(filename,filepath,mimetype,size,tabela) "+
            "values($1,$2,$3,$4,$5) ",
            [filename,filepath,mimetype,size,tabela]
        );
        res.json(upload.rows);

    } catch (err) {
        console.error(err.message);
        res.status(500).send(err.message);
    }
});
    
    
/*-------------------------------
| Retornar a imagem de acordo com o nome do arquivo
|--------------------------------*/
router.get('/:filename', async (req, res) => {

try {
        const { filename } = req.params;

        const getFile = await pool.query(
            "select * from imagem as if where if.filename = $1 ",
            [filename]
        )
        console.log(getFile.rows[0].filepath)
        const dirname = path.resolve();
        const fullfilepath = path.join(dirname, getFile.rows[0].filepath);
        res.sendFile(fullfilepath);
    } 
    catch (err) {
        console.error(err.message);
        res.status(500).send("Server Error!");
    }
});


/*-------------------------------
| Retornar os dados das imagens armazenadas
|--------------------------------*/
router.get('/dados/todas', async (req, res) => {

    try {
        const getNames = await pool.query(
            "select * from imagem",
            []
        )
        res.json(getNames.rows);
    } 
    catch (err) {
        console.error(err.message);
        res.status(500).send("Server Error!");
    }
});

module.exports = router;