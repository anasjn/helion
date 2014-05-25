(function() {
  var app, bodyParser, express, geolib, port, router;

  express = require('express');

  app = express();

  bodyParser = require('body-parser');

  geolib = require('geolib');

  app.use(bodyParser());

  port = process.env.PORT || 8080;

  router = express.Router();

  router.use(function(req, res, next) {
    console.log('Something is happening');
    return next();
  });

  router.get('/', function(req, res) {
    var myData;
    myData = geolib.getDistance({
      latitude: 40.459834,
      longitude: 3.616937
    }, {
      latitude: 40.4636094,
      longitude: 3.6189755
    });
    console.log(myData);
    return res.json({
      dist: myData
    });
  });

  router.post('/isPointInEndesa', function(req, res) {
    var distance, endesa, isClose, location;
    endesa = {
      latitude: 40.459834,
      longitude: 3.616937
    };
    location = {
      latitude: req.body.latitude,
      longitude: req.body.longitude
    };
    isClose = geolib.isPointInCircle(endesa, location, 500);
    distance = geolib.getDistance(endesa, location);
    return res.json({
      "isClose": isClose,
      "dist": distance
    });
  });

  app.use('/v1', router);

  app.listen(port);

  console.log('Magic happens on port ' + port);

}).call(this);
