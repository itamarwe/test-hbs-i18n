#!/usr/bin/env coffee

###
@author Itamar Weiss <weiss.itamar@gmail.com>
###

require 'coffee-script'
# HTTP routing framework and middleware
express          = require 'express'

# HTTP server
http             = require 'http'
# Handlebars Template Engine
hbs              = require 'hbs'
# I18n Multilingual Engine
i18n             = require 'i18n'

# The Web Server
app              = express()
server           = http.createServer app

###
Configuration
###

app.configure ->
  # Template rendering
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'hbs'
  app.engine 'hbs', hbs.__express

  # Parse form params, cookies
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()

  i18n.configure
  # setup some locales - other locales default to en silently
    locales   : ['en', 'fr']
    cookie    : 'locale'
    directory : "#{__dirname}/../locales"

  # the locale middleware
  app.use i18n.init

  # setting the local for the request => not needed as this is normally done by i18n.init
  # app.use (req, res, next) ->
  #   locale = i18n.getLocale req
  #   i18n.setLocale locale
  #   do next

  # binding helpers to request
  app.use (req, res, next) ->
    i18n__i = ->
      return i18n.__.apply(req, arguments);
    i18n__n = ->
      return i18n.__n.apply(req, arguments);

    # for direct use in methods
    res.__n = i18n__n;
    res.__i = i18n__i;

    # and (this is the important part) for use in templates (express 3.x way)
    res.locals.__n = i18n__n;
    res.locals.__i = i18n__i;

    do next

  # The Express router
  app.use app.router

# Register template helpers => not needed see app.use inside app.configure
# (require './lib/registerHelpers')(hbs, i18n)

# Routes/Controllers
app.get '/', (req, res) ->
  delay = req.query.delay ? 0
  setTimeout ->
    res.render 'index'
  , delay


app.get '/:locale', (req, res) ->
  res.cookie 'locale', req.params.locale
  delay = req.query.delay ? 0
  res.redirect "/?delay=#{delay}"

# Start the server
server.listen 3000
console.log "Express server listening on port #{server.address().port}
in #{app.settings.env} mode"
