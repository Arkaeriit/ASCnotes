#!/usr/local/bin/lua

listFonc={reboot="~/.ASC/notes/reboot",data="~/.ASC/notes/data"}
dofile("~/.ASC/notes/fonctions.lua")

function ajout(self)
  local str=""
  repeat
    local ajout=io.read()
    if ajout ~= "" then
      str=str.."\n "..ajout
    end
  until ajout==""
  addelement(str,self.data)
end listFonc["add"]=ajout
listFonc["add"]=ajout

function resetO(self)
  reset(self.reboot)
end listFonc["reset"]=resetO

function readO(self)
  read(self.reboot,self.data)
end listFonc["read"]=readO

function readF(self)
    resetO(self)
    readO(self)
end listFonc["readF"]=readF

function del(self)
  delelement(self.data,tonumber(arg[2]))
end listFonc["del"]=del

if listFonc[arg[1]] then
  listFonc[arg[1]](listFonc)
else
  io.stdout:write("add to take a note \nreadF to read your notes \ndel n to delete the nth note \nreset to reuse read \nread to read your notes if you used reset beforeand\n")
end
