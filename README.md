# Magic

[Haxe](https://haxe.org) API for running [ImageMagick](https://github.com/ImageMagick/ImageMagick) (`convert`, `identify`), commands, supporting all haxe targets, **even the browser** (!) thanks to [magica](https://cancerberosgx.github.io/magica/), an [emscripten](https://emscripten.org/) port of [ImageMagick](https://github.com/ImageMagick/ImageMagick) that allows to programmatically call its `convert`, `identify`, etc. commands in a programmatic way.

## Contents

<!-- toc -->

- [Summary](#summary)
- [Install](#install)
- [How it works](#how-it-works)
- [API Reference](#api-reference)
- [Usage](#usage)
  * [Browser setup](#browser-setup)
  * [API usage](#api-usage)
  * [Run tests with docker](#run-tests-with-docker)
  * [Other](#other)
- [Tests](#tests)
  * [Run locally](#run-locally)
  * [Run with docker](#run-with-docker)
- [Status / TODO / Road map / Changelog](#status--todo--road-map--changelog)

<!-- tocstop -->

## Summary 

 * Portable API for running ImageMagick `convert`, `identify`, etc.
 * Supports all targets including Node.js and **browser**.
 * In the server, if ImageMagick is installed, it will use it. 
 * In the browser, it will use [magica](https://cancerberosgx.github.io/magica/) to run ImageMagick commands. 
 * If ImageMagick is not installed locally it will install [magica](https://cancerberosgx.github.io/magica/) and use its Command line Interface to run [ImageMagick](https://github.com/ImageMagick/ImageMagick) commands, even in targets different than `js`.
 * [magica](https://cancerberosgx.github.io/magica/) is an [emscripten](https://emscripten.org/) port of [ImageMagick](https://github.com/ImageMagick/ImageMagick) with support for almost all its features and performing with acceptable speed and memory consumption. In the browser it uses optimal data types to represent and transfer files using web-workers.

**See the [Magic Online Playground](https://cancerberosgx.github.io/magic/playground/index.html) to see what's this is all about!**

**See [test](test) running in all haxe targets.**

## Install

```sh
haxelib install magic
```

And don't forget to use `-lib magic` in your projects.

<!-- ## How it works
 
 * Users access ImageMagick by calling commands like `convert`, `identify`, etc.
 * When running on the server (cpp, java, neko, Node.js, etc) it will first try to execute native ImageMagick commands using `sys.io.Process`
 * If the command is not found (imagemagick is not installed in the local system) it will try to execute magica command line tool using node.js (more below)
 * is node.js is installed and imagemagick is not, the first time is executed, it will install magica (npm install magica) if its not. 
   * It will install it in an independent folder like $HOME/.magic/node_modules/magica or the same haxe lib folder.
 * Then and in the future it will run magica with node.js from that folder. 
 * If none imagemagick nor node.js are installed it gives up
 * The verification to see if native image magick is available will be performed on each startup
 * the verification to see if magica is installed will be performed on each startup. -->

<!-- ## Usage -->

### Browser setup

Magica is a standard commons.js library that can easily bundled with tools such as parcel, browserify, webpack. But since I don't know how to do that in a haxe project (and until I learn) in this example we will be loading the two libraries, separately. `magica` will expose a global variable from which we only need one function to execute ImageMagick commands:

**Generating magica bundle***

```sh
mkdir -o tmp
cd tmp
npm i magica browserify
npx browserify node_modules/magica/dist/src/index.js -o magica.js
cp node_modules/magica/dist/src/imageMagick/compiled/magick.wasm .
```

If everything was OK we should have this two files: `tmp/magica.js` and `tmp/magick.wasm`. Those are the library files for magica. We just need to make sure to copy them into our application's files, and load `magica.js` from our html. **Make sure both are in the same folder**. 

Checkout `browser-project/static` for a working browser application containing both and how are loaded in `index.html`. 

Checkout `browser-project/src/main.hx` to see how we get a reference to the library entry point. Again, normally you souldn't have to access it like this, but just importing it like any other JavaScript library. This is temporary.

Checkout [magica project page](https://github.com/cancerberoSgx/magica) for details.

Beside this difference, the rest of the API and setup is the same for all haxe target languages. 


## API Reference

[API Reference](https://cancerberosgx.github.io/magic/index.html)


## Usage

<!-- ### API usage -->

<!-- ```haxe
import magic.*;
var c:Magic.MagicCallOptions = {
  command: ['convert', 'rose:', '-scale', '50%', '-rotate', '33', 'output.gif'],
  files: []
};
Magic.call(c).then(result -> {
  if(result.code!=0){
    trace('Error!', result.stderr);
  }else {
    Magic.call({
      commands: 'identify'
    })
    // in thw server a new file output.gif should be generated

  }
  Assert.same(result.code, 0);
    Assert.isTrue(IOUtil.fileExists('tmp/tmpconvertNoInput.gif'));
    ImageUtil.identical(File.fromFile('tmp/tmpconvertNoInput.gif', true), File.fromFile('test/assets/expects/convertNoInput.gif', true)).then(result->{
  Assert.isTrue(true);

    async.done();
    });
  });
//TODO -->
<!-- ``` -->

## Tests

### Run locally

You will need java, php, g++, node.js to run all targets:

```sh
sh scripts/test.sh
```

### Run with docker

```sh
sh scripts/test-docker.sh
```

## Other scripts

```sh
sh scripts/clean.sh
sh scripts/pack.sh
sh scripts/publish.sh
```


## Status / TODO / Road map / Changelog

See [TODO.md](TODO.md)
