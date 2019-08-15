f=io.popen("echo $HOME","r") --récupération du nom du sossier maison
home=f:read()
f:close()

listFonc = {reboot = home.."/.config/ASC/notes/reset" , data = home.."/.config/ASC/notes/data"} --initialisation et recherche du nom des fichier utiles. Dans data se trouvent les notes et reset sert à savoir si on peut utiliser l'argument read.

function ajout(self)    --fonctions pour comuniquer avec fonctions.lua 
  local str=""
  repeat
    local ajout=io.read()
    if ajout ~= "" then
      str=str.."\n"..ajout --le "\n" sert à passer à la ligne
    end
  until ajout==""
  addelement(str,self.data)
end listFonc["add"]=ajout
listFonc["ajout"]=ajout

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
  delelement(self.data,self.numDelArg)
end listFonc["del"]=del

--verification de l'instalation
f = io.open(listFonc.reboot,"r")
g = io.open(listFonc.data,"r")
if not(g and f) then
    os.execute("mkdir -p "..home.."/.config/ASC/notes")
else
    f:close()
    g:close()
end

function main(commande,valeur)
    listFonc.numDelArg = tonumber(valeur)
    if listFonc[commande] then
      listFonc[commande](listFonc)
    else
      io.stderr:write("add to take a note \nreadF to read your notes \ndel n to delete the nth note \nreset to reuse read \nread to read your notes if you used reset beforeand\n")
    end
end

