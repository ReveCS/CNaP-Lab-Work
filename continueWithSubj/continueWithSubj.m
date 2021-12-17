function continueWithSubj(sourceFolder, subjID, spreadSheet)
    
    sourceFolder = sourceFolder(~ismember({sourceFolder(:).name},{'.','..'}));
    filePath = sourceFolder(1).folder;
    [parentFolder,currentFolder] = fileparts(filePath);
    newFolder = fullfile(parentFolder,[currentFolder '_Continue']);
    if ~exist(newFolder, 'dir')
        mkdir(newFolder);
    end
    
    fileNames = extractfield(sourceFolder,'name');  
    folders = extractfield(sourceFolder,'folder'); 
    fullFiles = {};
    for i = 1:length(fileNames)
        fullFiles{i} = fullfile(folders{i},fileNames{i})
        if (contains(fullFiles(i), subjID)) 
            startIndex = i
            disp(startIndex)
        end
    end
   
    excelData = xlsread(spreadSheet)
    for x = 1:length(excelData)
        if(strcmp(string(excelData(x)), subjID)) 
            excelIndex = x
            disp(excelIndex)
        end
    end
    
    % to get the source folder
    % sourceFoldwithTaskName = fullfile(filePath,fileNameToCopy)
    %output: ../../../DummyTasks/AXCPT/10003_AXCPT.log
    for y = startIndex:length(fullFiles)
        copyfile(fullFiles{y},newFolder)
    end
end

