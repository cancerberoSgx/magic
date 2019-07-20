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

### API usage

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
