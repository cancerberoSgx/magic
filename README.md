# Magic

## Contents

<!-- toc -->

<!-- tocstop -->

## Summary 

 * Portable API for ImageMagick `convert` commands.
 * Supports all targets including Node.js and browser.
 * In targets different than js ImageMagick needs to be installed locally
 * In node.js and the browser uses [magica]() ImageMagick emscripten port
 * The API is the same as ImageMagick commands like `convert`, `identify`, etc
 * In the browser ArrayBuffers are used instead of files for IO

**See the [Online Playground](https://cancerberosgx.github.io/magic/playground/TODO) to see what's this is all about!**

## Install

```sh
haxelib install magic
```

And don't forget to use `-lib magic` in your projects.

## How it works

 * In sys targets (cpp, java, neko, etc) or in node.js it will first try to execute native image magick command using `sys.io.Process`
 * If the command is not found (imagemagick is not installed in the local system) it will try to execute magica command line tool using node.js (more below)
 * is node.js is installed and imagemagick is not, the first time is executed, it will install magica (npm install magica) if its not. 
   * It will install it in an independent folder like $HOME/.magic/node_modules/magica or the same haxe lib folder.
 * Then and in the future it will run magica with node.js from that folder. 
 * If none imagemagick nor node.js are installed it gives up
 * The verification to see if native image magick is available will be performed on each startup
 * the verification to see if magica is installed will be performed on each startup.

## API Reference

[API Reference](https://cancerberosgx.github.io/magic/index.html)

## Usage

TODO:

```haxe
import magic.*;

//TODO
```

## Scripts

### Run tests locally

You will need java, php, g++, node.js to run all targets:

```sh
sh scripts/test.sh
```

### Run tests with docker

```sh
sh scripts/test-docker.sh
```

### Other

```sh
sh scripts/clean.sh
sh scripts/pack.sh
sh scripts/publish.sh
```

## Tests

### Run locally

You will need java, php, g++, node.js to run all targets:

```sh
sh scripts/test.sh
```

### Run with docker

```sh
sh test-docker.sh
```

## Status / TODO / Road map / Changelog

See [TODO.md](TODO.md)
