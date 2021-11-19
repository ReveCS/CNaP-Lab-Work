function fileCheck(scanFldr)
    scanFldrStruct = dir(scanFldr);
    subFldrs = scanFldrStruct([scanFldrStruct(:).isdir]);
    subFldrs = subFldrs(~ismember({subFldrs(:).name},{'.','..'}));
    
    checkList = [];
    listIDX = 1;
    for fldrs = subFldrs' 
        dcmList = dir(fullfile(scanFldr, fldrs.name, '*.dcm'));
        if (length(dcmList) > 0) 
            thisDCM = dicominfo(fullfile(scanFldr, fldrs.name, dcmList(1).name));
            myFolders = split(scanFldr, filesep);
            scanID = myFolders{end};
            
            if ~strcmp(scanID, thisDCM.PatientID)
                checkList(listIDX) = 0;
            else 
                checkList(listIDX) = 1;
            end
            listIDX = listIDX + 1;
        end
    end
    if all(checkList)
        disp([scanID ' looks good'])
    else 
        disp([scanID ' looks bad!!!!!!!!!!!!'])
    end 
end 


