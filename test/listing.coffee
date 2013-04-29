require("source-map-support").install()
assert = require "assert"
walk = require "walk"

explorer = require ".."

getDirectories = (path, next) ->
  paths = []
  walker = walk.walk path
  walker.on "directory", (root, stat, next) -> 
    paths.push root + "/" + stat.name
    next()
  walker.on "end", -> next null, paths

getFiles = (path, next) ->
  paths = []
  walker = walk.walk path
  walker.on "file", (root, stat, next) -> 
    paths.push root + "/" + stat.name
    next()
  walker.on "end", -> next null, paths

options = {}
  
describe "getDirectories", ->
  it "gets directories in .", (next) ->
    explorer.getDirectories ".", (err, paths) ->
      getDirectories ".", (err, walkPaths) ->
        assert.deepEqual walkPaths.sort(), paths.sort()
        next null

describe "getFiles", ->
  it "gets files in .", (next) ->
    explorer.getFiles ".", (err, paths) ->
      getFiles ".", (err, walkPaths) ->
        assert.deepEqual walkPaths.sort(), paths.sort()
        next null
        