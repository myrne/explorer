require("source-map-support").install()
assert = require "assert"
walk = require "walk"

explorer = require "../"

countDirectories = (path, next) ->
  paths = 0
  walker = walk.walk path
  walker.on "directory", (root, stat, next) -> 
    paths++
    next()
  walker.on "end", -> next null, paths

countFiles = (path, next) ->
  paths = 0
  walker = walk.walk path
  walker.on "file", (root, stat, next) -> 
    paths++
    next()
  walker.on "end", -> next null, paths

options = {}
  
describe "countDirectories", ->
  it "counts directories in ./", (next) ->
    explorer.countDirectories "./", (err, count) ->
      countDirectories "./", (err, walkCount) ->
        assert.equal walkCount, count
        next null

describe "countFiles", ->
  it "counts files in ./", (next) ->
    explorer.countFiles "./", (err, count) ->
      countFiles "./", (err, walkCount) ->
        assert.equal walkCount, count
        next null
        