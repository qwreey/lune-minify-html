# lune-minify-html

Simple [minify-html](https://github.com/wilsonzlin/minify-html) wrapper for lune runtime, with ffi edge feature.

## Example usage

Run `cargo build --profile=release` first to get shared object.

```luau
local minify_html = require("./")
    .new("./target/release/liblune_minify_html.so")

local result = minify_html:minify([[
    <html>
        <html>
            <title>Hello world</title>
        </html>
        <body>
            <p>Hello world</p>
        </body>
    </html>
]])

print(result) -- <title>Hello world</title></html><body><p>Hello world
```

## TODO

Minify option supports
