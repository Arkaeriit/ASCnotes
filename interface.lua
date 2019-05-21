#!/usr/local/bin/lua

f=io.popen("echo $HOME","r") --récupération du nom du sossier maison
home=f:read()
f:close()

listFonc = {reboot = home.."/.ASC/notes/reboot" , data = home.."/.ASC/notes/data"} --initialisation et recherche du nom des fichier utiles
dofile(home.."/.ASC/notes/fonctions.lua")

function ajout(self)    --fonctions pour comuniquer avec fonctions.lua 
  local str=""
  repeat
    local ajout=io.read()
    if ajout ~= "" then
      str=str.."\n "..ajout --le "\n " ser à passer à la ligne et à écrire le caractère de padding crutial à la lecture du fichier data
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
