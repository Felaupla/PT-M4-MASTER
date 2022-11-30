const { Router } = require("express");
const { Op, Character, Role } = require("../db");
const router = Router();

router.post("/", async (req, res) => {
  const { code, name, hp, mana } = req.body;
  if (!code || !name || !hp || !mana)
    return res.status(404).send("datos incompletos");
  try {
    const character = await Character.create(req.body);
    res.status(201).json(character);
  } catch (e) {
    res.status(404).send("Error en datos provistos");
  }
});

router.get("/", async (req, res) => {
  const { race } = req.query;
  try {
    if (!race) {
      const character = await Character.findAll();
      res.send(character);
    } else {
      const character = await Character.findAll({
        where: {
          race,
        },
      });
      res.send(character);
    }
  } catch (e) {
    console.log(e);
  }
});
router.get("/character/:code", async (req, res) => {
  const { code } = req.params;
  const character = await Character.findbyPK(code);
  if (!character || !code)
    return res
      .status(404)
      .send(`El código ${code} no corresponde a un personaje existente`);
  res.json(character);
});

module.exports = router;
