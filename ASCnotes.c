//exemple d'appel de fonctions lua par du C


#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main(int argc,char** argv){
    lua_State* L;
    L = luaL_newstate();
    luaL_openlibs(L);

    luaL_dofile(L,"/usr/local/share/ASCnotes/fonctions.luac");
    luaL_dofile(L,"/usr/local/share/ASCnotes/interface.luac");
    
    lua_getglobal(L,"main");
    if(argc == 2){
        lua_pushstring(L,*(argv+1));
        lua_pushboolean(L,0);
    }else{
        if(argc > 2){
            lua_pushstring(L,*(argv + 1));
            lua_pushstring(L,*(argv + 2));
        }else{
            lua_pushboolean(L,0);
            lua_pushboolean(L,0);
        }
    }
    lua_call(L,2,0);

    lua_close(L);
    return 0;
}
