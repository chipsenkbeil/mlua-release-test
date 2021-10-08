# mlua-release-test

## Instructions

Run `make` to build a universal `dylib` of an mlua module. You can run
`make x86` or `make aarch64` to build each of the targets respectively. The
universal lib is placed into `target/release`.

Run `make verify` to build the universal `dylib` and attempt to load and run
it. This uses `lua` on path and defaults to `lua51` feature of mlua. To change
the lua binary used, set the environment variable `LUA_BIN`. To change the
feature used to build the module, set the environment variable `LUA_FEATURE`.

The `vendored` feature is applied automatically.

<img width="593" alt="neofetch" src="https://user-images.githubusercontent.com/2481802/136597150-b3385836-f719-48e2-b148-f52ef348f32c.png">
