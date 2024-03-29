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

--le datafile est la liste des notes. Il se comporte comme des lignes de textes. Pour chaque nouvelle note la ligne commence par $ sinon elle commenc par un espace. La première ligne contient le timestamp à partir duquel on peut afficher avec read donc ce n'est pas à lire.

function getData(datafile) --décriptage du fichier où les notes sont stockées
    local tab=convertFichTable(datafile)
    local ret = {}
    ret.time = tab[1]
    for i=2,#tab do
        if tab[i]:sub(1,1)=="$" then
            ret[#ret+1]=tab[i]:sub(2,#tab[i])
        else
            ret[#ret] = ret[#ret].."\n"..tab[i]:sub(2,#tab[i])
        end
    end
    return ret
end

function writeData(tab,datafile)
    local f=io.open(datafile,"w")
    addPading(tab)
    f:write(tab.time, "\n")
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

-- Time to wait can be a number of second to wait until we can read again
-- ar falsy to force reading
function read(datafile, time_to_wait)
    local tab=getData(datafile)
    if allowed_to_print(tab) or not time_to_wait then
        io.write("_____ASCnotes_______________\n")
        for i=1,#tab do
            io.write("\n",tostring(i),":",tab[i],"\n")
        end
        io.write("----------------------------\n")
        if time_to_wait then
            tab.time = tostring(os.time() + time_to_wait)
            writeData(tab, datafile)
        end
    end
end

-- Check the datafile if the printing can be made
function allowed_to_print(data)
    local limit = tonumber(data.time)
    local limit_passed = limit < os.time()
    local content = #data > 0
    return limit_passed and content
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

