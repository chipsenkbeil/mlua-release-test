use mlua::prelude::*;

#[mlua::lua_module]
fn mlua_release_test(lua: &Lua) -> LuaResult<LuaTable> {
    let exports = lua.create_table()?;

    exports.set("msg", "hello world")?;

    Ok(exports)
}
