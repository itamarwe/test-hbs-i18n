# load the server
require '../web/server'

should  = require 'should'
Browser = require 'zombie'
async   = require 'async'

browserEn = new Browser
browserFr = new Browser

visitLinks = (asyncMethod) ->
  it 'should show /en in English and /fr in French', (done)->
    async[asyncMethod] [
      (cb)->
        browserEn.visit 'http://localhost:3000/en?delay=1500', ->
          textEn = browserEn.html '#text'
          textOneCat = browserEn.html '#onecat'
          textTwoCats = browserEn.html '#twocats'
          should.equal textEn, '<span id="text">text to test</span>'
          should.equal textOneCat, '<span id="onecat">1 cat</span>'
          should.equal textTwoCats, '<span id="twocats">2 cats</span>'
          do cb
      ,
       (cb)->
        setTimeout ->
          browserFr.visit 'http://localhost:3000/fr', ->
            textFr = browserFr.html '#text'
            textOneCat = browserFr.html '#onecat'
            textTwoCats = browserFr.html '#twocats'
            should.equal browserFr.cookies().get('locale'), 'fr'
            should.equal textFr, '<span id="text">Texte à tester</span>'
            should.equal textOneCat, '<span id="onecat">1 chat</span>'
            should.equal textTwoCats, '<span id="twocats">2 chats</span>'
            do cb
        , 200
      ], done

describe 'non concurrent template rendering in different languages', ->
  visitLinks 'series'
describe 'concurrent template rendering in different languages', ->
  visitLinks 'parallel'
