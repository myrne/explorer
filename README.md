# explorer [![Build Status](https://travis-ci.org/meryn/explorer.png?branch=master)](https://travis-ci.org/meryn/explorer) [![Dependency Status](https://david-dm.org/meryn/explorer.png)](https://david-dm.org/meryn/explorer)

Explore directories in various ways.

## Main function: explorer.explore (root[, options])

`explore` returns an [`EventEmitter`](http://nodejs.org/api/events.html).

It recursively goes through the directories under `root`, and while doing so, emits various events.

### Events emitted

* `directory` `(root, entryName, stat)`
* `file` `(root, entryName, stat)`
* `symlink` `(root, entryName, stat)`
* `enter` `(root, entryName)` - when it enters a subdirectory
* `leave` `(root, entryName)` - when it has left a subdirectory
* `start`
* `end` `(error)`

### Notes

* It starts doing it work on the next tick, so you are able to bind event listeners.
* It stops exploration after an error occurs. This error will be made available as the first argument to the `end` event listener. If exploration finishes without errors, the `error` argument will be `null`.
* It currently does not follow symlinks.

## Convenience functions

### explorer.getFiles  (root[, options], cb)

`cb` gets called with `(err, filePaths)`.

### explorer.getDirectories (root[, options], cb)

`cb` gets called with `(err, directoryPaths)`.

### explorer.countFiles (root[, options], cb)

`cb` gets called with `(err, numFiles)`.

### explorer.countDirectories  (root[, options], cb)

`cb` gets called with `(err, numDirectories)`.

### explorer.getDirectoryTree  (root[, options], cb)

`cb` gets called with `(err, tree)`. `tree` is the root node of a tree structure where each node has a `label` (string) and `nodes` (array) property. This can be given to [archy](https://npmjs.org/package/archy) as is.

### explorer.getNamespaceObject  (root[, options], cb)

`cb` gets called with `(err, nsObject)`. `nsObject` is the root node of a namespace structure where each node has properties named after the name subdirectories it contains, the value being another directory node.

This is useful when you use a hierarchical global namespace for your application components and the folder structure of your application closely matches the namespace you use. You may want to recursively change the property names with a tool like [tower-strcase](https://npmjs.org/package/tower-strcase) or [change-case](https://npmjs.org/package/change-case).

## Options

Each function takes an optional `options` object as second-last argument. Currently, the following options are available:

### Boolean, defaulting to false

* `ignoreNodeModules` - ignore `node_modules` directory
* `ignoreVersionControl` - ignore version control directories: `.git`, `.svn`, `.hg`
* `sort` - entries in each directory are processed in alphabetical order

### Other

* `ignoreDirectories` - array with names of directories to ignore. This array is augmented with any directories following from other options.

## Credits

The initial structure of this module was generated by [Jumpstart](https://github.com/meryn/jumpstart), using the [Jumpstart Black Coffee](https://github.com/meryn/jumpstart-black-coffee) template.

The interface for the `explore` function - on which the other functions rely - was inspired by [node-walk](https://github.com/coolaj86/node-walk) by [AJ ONeal](http://blog.coolaj86.com/)

## License

explorer is released under the [MIT License](http://opensource.org/licenses/MIT).  
Copyright (c) 2013 Meryn Stol  