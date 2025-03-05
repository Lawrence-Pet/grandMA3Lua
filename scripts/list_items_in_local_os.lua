return function()
    local lfs = require("lfs")

    local function list_files_in_directory(path)
        for file in lfs.dir(path) do
            if file ~= "." and file ~= ".." then
                local full_path = path .. "/" .. file
                local attr = lfs.attributes(full_path)
                if attr then
                    print(string.format("%s [%s]", file, attr.mode))
                end
            end
        end
    end

    local folder_path = "."  -- Change this to your desired directory
    list_files_in_directory(folder_path)
end