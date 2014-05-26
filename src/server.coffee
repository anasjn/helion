# server.js

# BASE SETUP
# =======================================

# call the packages we need
express = require 'express'     # Call express
app = express()                 # Define our app
bodyParser = require 'body-parser' 
geolib = require 'geolib'

# configure app to use bodyParser()
# this will let us get the data from POST
app.use bodyParser()

port = process.env.PORT || 8080 # set our port

# ROUTES FOR OUR API
# ======================================
router = express.Router()       # get an instance of the express Router

# middleware to use for all requests
router.use (req, res, next) ->
  # do logging
  console.log 'Something is happening'
  
  next() # make sure we go to the next routes and don't stop here

# test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get '/', (req, res) ->
  
  res.json 
    serverApp: "helion"
    buildVersion: "0.1"

router.post '/isPointInEndesa', (req, res) ->

  # position where Endesa HQ is located in google maps
  endesa = 
    latitude: 40.459834
    longitude: 3.616937

  # this is the location recieved by the request of a client.
  location = 
    latitude: req.body.latitude
    longitude: req.body.longitude

  # this var stores a boolean declaring that the client's pos. is below 500 mts
  isClose = geolib.isPointInCircle endesa, location, 500

  # this var stores the distance in meters
  distance = geolib.getDistance endesa, location

  res.json
    "isClose": isClose
    "dist": distance

# REGISTER OUR ROUTES
# all of our routes will be prefixed with / api
app.use '/v1', router 

# START THE SERVER
# ======================================
app.listen port
console.log 'Magic happens on port ' + port