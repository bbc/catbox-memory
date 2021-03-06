# @bbc/serverless-catbox-memory

# This package is now hosted on the NPM Registry.

Memory adapter for [catbox](https://github.com/hapijs/catbox).
This adapter is not designed to share a common cache between multiple processes (e.g. in a cluster mode).

Lead Maintainer - [Wyatt Preul](https://github.com/geek)

Current version: [![Current Version](https://img.shields.io/npm/v/catbox-memory.svg)](https://www.npmjs.org/package/catbox-memory) [![Build Status](https://api.travis-ci.org/hapijs/catbox-memory.svg)](https://travis-ci.org/hapijs/catbox-memory)

### Options

- `maxByteSize` - sets an upper limit on the number of bytes that can be stored in the
  cache. Once this limit is reached no additional items will be added to the cache
  until some expire. The utilized memory calculation is a rough approximation and must
  not be relied on. Defaults to `104857600` (100MB).
- `allowMixedContent` - by default, all data is cached as JSON strings, and converted
  to an object using `JSON.parse()` on retrieval. By setting this option to `true`,
  `Buffer` data can be stored alongside the stringified data. `Buffer`s are not
  stringified, and are copied before storage to prevent the value from changing while
  in the cache. Defaults to `false`.
