(function() {
  var app, bodyParser, express, port, router;

  express = require('express');

  app = express();

  bodyParser = require('body-parser');

  app.use(bodyParser());

  port = process.env.PORT || 80;

  router = express.Router();

  router.get('/', function(req, res) {
    return res.json({
      message: 'hooray! welcome to our api!'
    });
  });

  app.use('/api', router);

  app.listen(port);

  console.log('Magic happens on port ' + port);

}).call(this);
