# A module to register all of the template helpers
# @author: Itamar Weiss

module.exports = (hbs, i18n) ->

  #register template helper function to translate texts
  hbs.registerHelper '__i', (options)->
    if i18n?
      #FIXME find a way to see the res scope (this hack doesn't work
      #for block expressions since "this" is in the block scope
      return i18n.__.apply this, [options.fn this]
    return options.fn this
  
  hbs.registerHelper '__n', (options)->
    if i18n?
      return i18n.__n.apply this, [options.fn this]
    return options.fn this
