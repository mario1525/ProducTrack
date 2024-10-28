var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Servicio Express de smtp para proyecto solficsas' });
});

module.exports = router;
