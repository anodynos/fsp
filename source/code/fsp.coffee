whenNode = require "when/node"

fs = require 'fs'

whenNode.liftAll fs, (
  (pfs,  liftedFunc, name)->
    pfs["#{name}P"] =
      if name isnt 'exists'
        liftedFunc
      else
        whenNode.lift require 'fs-exists'
    pfs
), fs

module.exports = fs