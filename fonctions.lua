function convertFichTable(fichier)
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

function convertTableFich(tabl,path)  --permet d'enregistrer les une table en un fichier
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

function serializeToString(o,tabulation)  --transorme o en string, mettre "" pour la tabulation
  if not tabulation then
    tabulation=""
  end
  local str=""
  local t = type(o)
  if t == "number" or t == "string" or t == "boolean" or
    t == "nil" then
    str=string.format("%q", o)
  elseif t == "table" then
    str="{\n"
    for k,v in pairs(o) do
      if type(k)=="string" then
        index=k
      else
        index="["..serializeToString(k).."]"
      end
      str=str..tabulation.." "..index.." = "
      str=str..serializeToString(v,tabulation.."  ")
      str=str..tabulation..",\n"
    end
    str=str..tabulation.."}\n"
  else
    error("cannot serialize a " .. type(o))
  end
  return str
end

--le datafile est la liste des notes. Il se comporte comme des lignes de textes. Pour chaque nouvelle note la ligne commence par $ sinon elle commenc par un espace

function getData(datafile)
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
	for i=1,#tab do
		f:write("$",tab[i],"\n")
	end
    f:close()
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