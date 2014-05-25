# server.js

# BASE SETUP
# =======================================

# call the packages we need
express = require 'express'     # Call express
app = express()                 # Define our app
bodyParser = require 'body-parser' 

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
    message: 'hooray! welcome to our api!' 

# REGISTER OUR ROUTES
# all of our routes will be prefixed with / api
app.use '/api', router 

# START THE SERVER
# ======================================
app.listen port
console.log 'Magic happens on port ' + port