function convertFichTable(fichier) --Créé une table dont le nème élément est la nème ligne de fichier
	local tab={}
	local f=io.open(fichier,"r")
	local num=1
	local flag=true
	while f and flag do
		local lign=f:read()
		if lign==nil then
			flag=false
		else
			tab[num]=lign
		end
		num=num+1
	end
	if f then f:close() end
	return tab
end

function convertTableFich(tabl,path)  --permet d'enregistrer une table en un fichier
  local f=io.open(path,"w")
  for i=1,#tabl do
  	f:write(tostring(tabl[i])..'\n')
  end
  if #tabl==0 then
  	f:write(" ")
  end
  f:close()
end

function decoupeStr(str,char) --comme le str.split de python
  local ret={""}
  for i=1,#str do
    if str:sub(i,i)==char then
      ret[#ret+1]=""
    else
      ret[#ret]=ret[#ret]..str:sub(i,i)
    end
  end
  return ret
end string.decoupeStr=decoupeStr

--le datafile est la liste des notes. Il se comporte comme des lignes de textes. Pour chaque nouvelle note la ligne commence par $ sinon elle commenc par un espace

function getData(datafile) --décriptage du fichier où les notes sont stockées
	local tab=convertFichTable(datafile)
	local i=1
	while i<=#tab do
		if tab[i]:sub(1,1)=="$" then
			tab[i]=tab[i]:sub(2,#tab[i])
			i=i+1
		else
			tab[i-1]=tab[i-1].."\n"..tab[i]:sub(2,#tab[i])
			table.remove(tab,i)
		end
	end
	return tab
end

function writeData(tab,datafile)
	local f=io.open(datafile,"w")
	addPading(tab)
    for i=1,#tab do
		f:write("$",tab[i],"\n")
	end
    f:close()
end

function addPading(tab) --ajoute des espaces au début de chaque ligne de chaque élément de tab
    for i=1,#tab do
        local new = " "
        for j=1,#tab[i] do
            if tab[i]:sub(j,j) == "\n" then
                new = new.."\n "
            else
                new = new..tab[i]:sub(j,j)
            end
        end
        tab[i] = new
    end
end

function read(rebbotfile,datafile)
  local Active=convertFichTable(rebbotfile)[1]
  if Active=="true" then
		io.write("_____ASCnotes_______________\n")
    local tab=getData(datafile)
    for i=1,#tab do
      io.write("\n",tostring(i),":",tab[i],"\n")
    end
    convertTableFich({"nope"},rebbotfile)
		io.write("----------------------------\n")
  end
end

function reset(rebbotfile)
  convertTableFich({"true"},rebbotfile)
end

function addelement(str,datafile)
  local data=getData(datafile)
	data[#data+1]=str
	writeData(data,datafile)
end

function delelement(datafile,n)
	local tab=getData(datafile)
	if n<=#datafile and n>0 then
		table.remove(tab,n)
		writeData(tab,datafile)
	end
end
