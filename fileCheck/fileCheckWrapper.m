function fileCheckWrapper(parentPath) 
    scanFldrsStruct = dir(parentPath);
    scanFldrsStruct = scanFldrsStruct(~ismember({scanFldrsStruct(:).name},{'.','..', 'Pilot', '1.3.12.2.1107.5.2.43.67057.2021041314232556488134244.0.0.0'}));

    for scanID = scanFldrsStruct'
        thisscanID = scanID.name;
        fileCheck(fullfile(parentPath, thisscanID))
    end
end

