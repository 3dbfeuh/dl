if not (getgenv and type(getgenv) == "function" and writefile) then return end

pcall(function()
    local sub, find = string.sub, string.find
    local blacklist = {
        ["dltest/libs/"] = true,
        ["dltest/libs/unzip.lua"] = true,
        ["dltest/loader.lua"] = true
    }
    local unzipData = game:HttpGet("https://raw.githubusercontent.com/3dbfeuh/dl/main/libs/unzip.lua")
    local scriptData = game:HttpGet("https://github.com/3dbfeuh/dl/archive/refs/heads/master.zip")
    local unzip = loadstring(unzipData)()
    local stream = unzip.newStream(scriptData)
    for name, content in unzip.getFiles(stream, true) do
        name = "dltest" .. sub(name, select(2, find(name, "%a/")))
        if not blacklist[name] then
            if sub(name, -1) == "/" then
                makefolder(name)
            elseif sub(name, -4) == ".lua" then
                writefile(name, content)
            end
        end
    end
end)

getgenv().import = function(str)
    if isfile("dltest/" .. str) then
        return loadstring(readfile("dltest/" .. str))()
    end
end
import("init.lua")
