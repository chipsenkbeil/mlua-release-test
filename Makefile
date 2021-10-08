NAME=mlua_release_test
LIB_NAME=lib$(NAME).dylib
LIB_SO_NAME=$(NAME).so
X86_ARCH=x86_64-apple-darwin
ARM_ARCH=aarch64-apple-darwin

# Can be one of [lua51, lua52, lua53, lua54, luajit]
LUA_VERSION?=lua51

# Can override to be a specific version
LUA_BIN?=lua

# Defaults to building universal
all: universal

clean:
	@rm $(LIB_SO_NAME)

# Verify that the universal library can be loaded
verify: universal
	@cp target/release/$(LIB_NAME) $(LIB_SO_NAME)
	@$(LUA_BIN) -e 'print(require("$(NAME)").msg)'

# Make a universal dylib
universal: x86 aarch64
	@mkdir -p target/release
	@lipo -create -output target/release/$(LIB_NAME) \
		target/$(X86_ARCH)/release/$(LIB_NAME) \
		target/$(ARM_ARCH)/release/$(LIB_NAME) \

# Verify that the x86 library can be loaded
verify-x86:
	@cp target/$(X86_ARCH)/release/$(LIB_NAME) $(LIB_SO_NAME)
	@$(LUA_BIN) -e 'print(require("$(NAME)").msg)'

# Make an x86_64 dylib
x86:
	@cargo build --release --features "$(LUA_VERSION),vendored" --target $(X86_ARCH)

# Verify that the aarch64 library can be loaded
verify-aarch64:
	@cp target/$(ARM_ARCH)/release/$(LIB_NAME) $(LIB_SO_NAME)
	@$(LUA_BIN) -e 'print(require("$(NAME)").msg)'

# Make an aarch64 dylib
aarch64:
	@cargo build --release --features "$(LUA_VERSION),vendored" --target $(ARM_ARCH)
