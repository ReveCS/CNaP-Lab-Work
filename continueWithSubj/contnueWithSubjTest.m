mainFldr = dir
subFldrs = mainFldr([mainFldr(:).isdir]);
subFldrs = subFldrs(~ismember({subFldrs(:).name},{'.','..'}))

%for i=1:length(subFlrds) 
%    sourceFldr = dir(subFldrs(i).name)
%end 
sourceFldr = dir(subFldrs(1).name)

excelFile = 'DummyPenn.xlsx'

continueWithSubj(sourceFldr, '10003', excelFile)

