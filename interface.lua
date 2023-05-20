f=io.popen("echo $HOME","r") --récupération du nom du sossier maison
home=f:read()
f:close()

listFonc = {data = home.."/.config/ASC/notes/data"} --initialisation et recherche du nom des fichier utiles. Dans data se trouvent les notes.

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

function readO(self)
  read(self.data, self.numArg)
end listFonc["read"]=readO

function readF(self)
    read(self.data, nil)
end listFonc["readF"]=readF

function del(self)
    if self.numArg then
        delelement(self.data,self.numArg)
    end
end listFonc["del"]=del

--verification de l'instalation
f = io.open(listFonc.data,"r")
if not(f) then
    os.execute("mkdir -p "..home.."/.config/ASC/notes")
    writeData({time = "0"}, listFonc.data)
else
    f:close()
end

function main(commande, valeur, time_to_wait)
    listFonc.numArg = tonumber(valeur)
    if listFonc[commande] then
      listFonc[commande](listFonc)
    else
      io.stderr:write("add to take a note \nreadF to read your notes \ndel <n> to delete the nth note \nread <time to wait> to read your notes and wait before beaing allowed again to read\n")
    end
end

