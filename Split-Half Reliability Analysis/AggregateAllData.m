%% THINGS TO CHANGE
addpath(genpath('/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Behavioral-Pipeline/MMTIL Contributions'));

DemographicsFileName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Demographics/Demographics_Updated.xlsx'; % Demograpics without questions and stuff

WASIscoreFileName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Neuropsych/URECA_WASIScoreInfo_v2.xlsx'; % Wasi spreadsheet

PennCNPdataFileName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Neuropsych/PENN_052422_CLEAN.xlsx'; % Penn spreadsheet

%% ALWAYS USE THIS DIRECTORY FOR PRESENTATION TASKS. ADD NEW SUBJECTS INTO IT PRIOR TO RUNNING

presentationLogsDirectory = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/R01_behavioral_tasks/Presentation'; % Root directory for presentation tasks

%%

eprimeLogsDirectory = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Span Spreadsheets/Original'; % Original eprime spreadsheets (xlsx) from e-merge

spanScoreDirectory = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Span Spreadsheets/Scores'; % Excel spreadsheet with PUscores

AllAggregateOutputFileName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Aggregate/AllData.xlsx';

FlippedSubjectsSheetFileName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Flipped Subjects by Task.xlsx';

SelectAggregateOutputFileName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Aggregate/SelectData_Spring22.xlsx';

SortedSelectDataPath = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Aggregate/SortedSelectData_Spring22.xlsx';

SortedAllDataPath = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Aggregate/SortedAllData_Spring22.xlsx';

OriginalOspanFileName = 'ospan_052422.xlsx';
OriginalSspanFileName = 'sspan_052422.xlsx';

SspanFullName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Span Spreadsheets/Original/sspan_052422.xlsx';
OspanFullName = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Span Spreadsheets/Original/ospan_052422.xlsx';

resultsDirectory = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Data/Results/Data by Task';

%Directory to save Study.mat to (data struct for determining subject
%responses to be flipped)
studyPath = '/mnt/jxvs2_02/Avery_workspace/Behavioral_workspace/Behavioral-Pipeline/MMTIL Contributions/Behavioral Data Processing Pipeline/Scripts For Aggregating/Study_Spring22.mat';

if ~exist(resultsDirectory,'dir')
    mkdir(resultsDirectory);
end
% Initialize struct for flipping subject responses (COULD BE CHANGED)
FlipSubjects.AXCPT = [10071; 10154; 10164; 10185; 10191; 10201; 10269];
FlipSubjects.AXCPTxy = [10071; 10164; 10185; 10191; 10201];
FlipSubjects.CD = [10064; 10090; 10258; 10277; 10296; 10380];
FlipSubjects.SIRP = [10064; 10269; 10322; 10342; 10380];
FlipSubjects.SIRPObj = [10164; 10202; 10380];

% Initialize Paths and Cell Array for rearranging individual task data
DataCell = {10051,10019,'nbdms';...
            10020,10019,'sot';...
            10038,10036,'nbdms';...
            55,10055,'sspan';...
            55,10055,'ospan';...
            55,10055,'axcpt';...
            152,10152,'ospan';...
            117,10117,'ospan';...
            149,10149,'ospan';...
            149,10149,'sspan';...
            86,10086,'axcpt';...
            101203,10203,'sirp';...
            10835,10385,'ospan';...
            20029,10029,'sot';...
            102044,10204,'pr'};
                   

%%
% Calculate PU Scores for OSpan and SSpan
OspanDir = [eprimeLogsDirectory,filesep,OriginalOspanFileName];
SspanDir = [eprimeLogsDirectory,filesep,OriginalOspanFileName];
PUspan_v2(SspanFullName,spanScoreDirectory);
PUospan(OspanFullName,spanScoreDirectory);


numPresentationTaskLogs = 8;

logDirectory.AXCPT =[presentationLogsDirectory,filesep,'AX_CPT' filesep 'logs'];
logDirectory.CD = [presentationLogsDirectory,filesep,'Change Detection' filesep 'logs'];
logDirectory.NBCDR = [presentationLogsDirectory,filesep,'Nback-CDR' filesep 'logs'];
logDirectory.NBDMS = [presentationLogsDirectory,filesep,'Nback-DMS' filesep 'logs'];
logDirectory.SIRP = [presentationLogsDirectory,filesep,'SIRP' filesep 'logs'];
logDirectory.SIRPOBJ = [presentationLogsDirectory,filesep,'SIRP_objects' filesep 'logs'];
logDirectory.SOT = [presentationLogsDirectory,filesep,'SOWMT' filesep 'logs'];
logDirectory.PR = [presentationLogsDirectory,filesep,'Progressive Ratio' filesep 'logs'];
logDirectory.OSpan = [eprimeLogsDirectory,filesep,OriginalOspanFileName];
logDirectory.SSpan = [eprimeLogsDirectory,filesep,OriginalSspanFileName];
spanLogDirectories = {logDirectory.OSpan, logDirectory.SSpan};
logDirectories = {logDirectory.AXCPT, logDirectory.CD, logDirectory.NBCDR, logDirectory.NBDMS, logDirectory.SIRP, logDirectory.SIRPOBJ, logDirectory.SOT, logDirectory.PR};

% logpath = struct2cell(logDirectory);
% for i=1:numPresentationTaskLogs
%     duplicateRemoval(logpath{i});
% end
    
    
blockLength.AXCPT = 4;
blockLength.CD = 4;
blockLength.NBCDR = 12;
blockLength.NBDMS = 10;
blockLength.SIRP = 8;
blockLength.SIRPOBJ = 4;
blockLength.SOT = 4;
blockLength.PR = 1; % Not used
blockLengths = [blockLength.AXCPT, blockLength.CD, blockLength.NBCDR, blockLength.NBDMS, blockLength.SIRP, blockLength.SIRPOBJ, blockLength.SOT, blockLength.PR];

runLength.AXCPT = 20;
runLength.CD = 48;
runLength.NBCDR = 4; % (could also be 12 or even 108)
runLength.NBDMS = 4; % (could also be 10 or 60)
runLength.SIRP = 16;
runLength.SIRPOBJ = 21;
runLength.SOT = 5; % (could also be 40)
runLength.PR = 1; % Not used
runLengths = [runLength.AXCPT, runLength.CD, runLength.NBCDR, runLength.NBDMS, runLength.SIRP, runLength.SIRPOBJ, runLength.SOT, runLength.PR];
sotDataBool = false(numPresentationTaskLogs,1);
sotDataBool(7) = true;

[dataStructsCell,FlippedArray,PartialFlips] = deal(cell(numPresentationTaskLogs,1));

taskNames = fieldnames(runLength);

% CHANGE BACK TO PARFOR LATER
for i=1:length(runLengths)
    [dataStructsCell{i},FlippedArray{i},PartialFlips{i}] = BehavioralDataAggregator(FlipSubjects, logDirectories{i}, runLengths(i), blockLengths(i), sotDataBool(i));
end
for i = 1:length(FlippedArray)
    if ~isempty(FlippedArray(i))
        FlipSubjIndex = find(FlippedArray{i});
        % Be careful of extending this in the future :)
        % This won't trigger if PartialFlips has subjIDs but FlippedArray
        % doesn't
        PartialFlipSubjIndex = find(PartialFlips{i});
         
        for q = 1:length(FlipSubjIndex)
            if i==1
                FlipDataSummary.AXCPT{q} = dataStructsCell{1,1}.subject(FlipSubjIndex(q)).SubjectID;
                if q<=length(PartialFlipSubjIndex)
                    FlipDataSummary.AXCPT_XY{q} = dataStructsCell{1,1}.subject(PartialFlipSubjIndex(q)).SubjectID;
                end
            elseif i==2
                FlipDataSummary.CD{q} = dataStructsCell{2,1}.subject(FlipSubjIndex(q)).SubjectID;
            elseif i==5
                FlipDataSummary.SIRP{q} = dataStructsCell{5,1}.subject(FlipSubjIndex(q)).SubjectID;
            elseif i==6
                FlipDataSummary.SIRPObj{q} = dataStructsCell{6,1}.subject(FlipSubjIndex(q)).SubjectID; 
            end
        end
   end   

end

%%
FlipTable = struct2table(FlipDataSummary);
writetable(FlipTable, FlippedSubjectsSheetFileName);

% dataStructs(8) = DataAggregator(logDirectories{8}, runLength(8), blockLength(8), false);
% dataStructs(7) = DataAggregator(logDirectory{7}, runLength(7), blockLength(7), true);
% dataStructs(1) = DataAggregator(logDirectory{1}, runLength(1), blockLength(1), false);
% dataStructs(2) = DataAggregator(logDirectory{2}, runLength(2), blockLength(2), false);
% dataStructs(3) = DataAggregator(logDirectory{3}, runLength(3), blockLength(3), false);
% dataStructs(4) = DataAggregator(logDirectory{4}, runLength(4), blockLength(4), false);
% dataStructs(5) = DataAggregator(logDirectory{5}, runLength(5), blockLength(5), false);
% dataStructs(6) = DataAggregator(logDirectory{6}, runLength(6), blockLength(6), false);


[AXCPTdata,CDdata,NBCDRdata,NBDMSdata,SIRPdata,SIRPOBJdata,SOTdata,PRdata] = dataStructsCell{:};



fileName.AXCPT = strcat(resultsDirectory,filesep,'AXCPT.xlsx');
fileName.CD = strcat(resultsDirectory,filesep,'CD.xlsx');
fileName.NBCDR = strcat(resultsDirectory,filesep,'NBCDR.xlsx');
fileName.NBDMS = strcat(resultsDirectory,filesep,'NBDMS.xlsx');
fileName.SIRP = strcat(resultsDirectory,filesep,'SIRP.xlsx');
fileName.SIRPOBJ = strcat(resultsDirectory,filesep,'SIRPOBJ.xlsx');
fileName.SOT = strcat(resultsDirectory,filesep,'SOT.xlsx');
fileName.PR = strcat(resultsDirectory,filesep,'PR.xlsx');
fileNames = {fileName.AXCPT, fileName.CD, fileName.NBCDR, fileName.NBDMS, fileName.SIRP, fileName.SIRPOBJ, fileName.SOT, fileName.PR};

toExcelFunctionPointers = {@BH_AX_CPT_AnalysisToExcel, @BH_ChangeDetectionToExcel, @BH_NBack_CDRToExcel, @BH_NBack_DMSToExcel, @BH_SIRP_ObjectAnalysisToExcel, @BH_SIRP_ObjectAnalysisToExcel, @BH_SOTToExcel, @BH_ProgressiveRatioToExcel};

toExcelDataStructsCell = cell(numPresentationTaskLogs,1);
for i=1:length(fileNames)
    toExcelFunction = toExcelFunctionPointers{i};
    toExcelDataStructsCell{i} = toExcelFunction(dataStructsCell{i},fileNames{i});
end

[excelAXCPTdata, excelCDdata, excelNBCDRdata, excelNBDMSdata, excelSIRPdata, excelSIRPOBJdata, excelSOTdata, excelPRdata] = toExcelDataStructsCell{:};

% excelAXCPTdata = AX_CPT_AnalysisToExcel(AXCPTdata,fileName.AXCPT);
% excelCDdata = ChangeDetectionToExcel(CDdata,fileName.CD);
% excelNBCDRdata = NBack_CDRToExcel(NBCDRdata,fileName.NBCDR);
% excelNBDMSdata = NBack_DMSToExcel(NBDMSdata, fileName.NBDMS);
% excelSIRPdata = SIRP_ObjectAnalysisToExcel(SIRPdata,fileName.SIRP);
% excelSIRPOBJdata =  SIRP_ObjectAnalysisToExcel(SIRPOBJdata,fileName.SIRPOBJ);
% excelSOTdata = SOTToExcel(SOTdata, fileName.SOT,varargin);
% excelPRdata = ProgressiveRatioToExcel(PRdata,fileName.PR);

spanDataCell = cell(2,1);
spanFunctionPointers = {@OSpan_Reader,@SSpan_Reader};
parfor i=1:2
    spanFunction = spanFunctionPointers{i};
    spanLogDirectory = spanLogDirectories{i};
    spanDataCell{i} = spanFunction(spanLogDirectory);
end

[OSpanData, SSpanData] = spanDataCell{:};

% Generate Study.mat for data cleansing
studyRawData = dataStructsCell;
studyRawData{end+1} = OSpanData;
studyRawData{end+1} = SSpanData;
studyTaskNames = taskNames;
studyTaskNames{end+1} = 'OSpan';
studyTaskNames{end+1} = 'SSpan';

Study = arrangeDataBySubject(studyRawData, studyTaskNames);
save(studyPath,'Study','-v7.3','-nocompression');
%%
spanScoreFields = {'SubjectID','distractorProportionCorrect','K','B','A'};

dirList = dir(spanScoreDirectory);
SpanFileNames = {dirList(~[dirList.isdir]).name};
numSpanFileNames = 2;
RAWspan = cell(numSpanFileNames,1);
columnLabels = cell(numSpanFileNames,1);
% Read files
parfor i = 1:numSpanFileNames
    [~,~,RAWspan{i}] = xlsread([spanScoreDirectory filesep SpanFileNames{i}]);
end

OSpanIndex = find(contains(lower(SpanFileNames),lower('OSpan')));
SSpanIndex = find(contains(lower(SpanFileNames),lower('SSpan')));

%Make "spreadsheet"
%Make "spreadsheet"
OSpanSheet = [spanScoreFields;{OSpanData.subject.subjectID}', {OSpanData.subject.distractorProportionCorrect}',{OSpanData.subject.K}',{OSpanData.subject.B}',{OSpanData.subject.A}'];
SSpanSheet = [spanScoreFields;{SSpanData.subject.subjectID}', {SSpanData.subject.distractorProportionCorrect}',{SSpanData.subject.K}',{SSpanData.subject.B}',{SSpanData.subject.A}'];
OSpanSheet = cellfun(@num2str,OSpanSheet,'uni',false);
SSpanSheet = cellfun(@num2str,SSpanSheet,'uni',false);

fullSheet.OSpan = MergeArrays(RAWspan{OSpanIndex},OSpanSheet);
fullSheet.SSpan = MergeArrays(RAWspan{SSpanIndex},SSpanSheet);


RAWpresentation = cell(numPresentationTaskLogs,1);

parfor i = 1:numPresentationTaskLogs
    [~,~,RAWpres{i}] = xlsread(fileNames{i});
end

[AXCPTsheet,CDsheet,NBCDRsheet,NBDMSsheet,SIRPsheet,SIRPOBJsheet,SOTsheet,PRsheet] = RAWpres{:};

%Need to add: AY RT / AX RT and BX RT / BY RT
AXRT = getColDataByLabel(AXCPTsheet,'Median RT (AX)');
AYRT = getColDataByLabel(AXCPTsheet,'Median RT (AY)');
BXRT = getColDataByLabel(AXCPTsheet,'Median RT (BX)');
BYRT = getColDataByLabel(AXCPTsheet,'Median RT (BY)');

AYRToverAXRTcol = makeCol(AYRT./AXRT,'Median AY RT / Median AX RT');
BYRToverBXRTcol = makeCol(BYRT./BXRT,'Median BY RT / Median BX RT');
fullSheet.AXCPT = [AXCPTsheet,AYRToverAXRTcol,BYRToverBXRTcol];

fullSheet.CD = CDsheet;
fullSheet.NBCDR = NBCDRsheet;
fullSheet.NBDMS = NBDMSsheet;
fullSheet.SIRP = SIRPsheet;
fullSheet.SIRPOBJ = SIRPOBJsheet;
fullSheet.SOT = SOTsheet;
fullSheet.PR = PRsheet;

[~,~,demographicsSheet] = xlsread(DemographicsFileName);
[~,~,WASIsheet] = xlsread(WASIscoreFileName);
[~,~,pennCNPsheet] = xlsread(PennCNPdataFileName);

%% Important swap: data from 10221 goes to 10213
w = cell2mat(WASIsheet(2:end,1));
problemSubjIdx = find(w==10221);
problemSubjData = WASIsheet(problemSubjIdx+1,2:8);
targetSubjIdx = find(w==10213);
WASIsheet(targetSubjIdx+1,2:8) = problemSubjData;
WASIsheet(problemSubjIdx+1,2:8) = {NaN};


fullSheet.Demographics = demographicsSheet;
fullSheet.WASI = WASIsheet;


%Need to calculate dPrime for the following:
% CPF_A
% PCPTNL
% CPFD_A
% SVOLT_A
% SVOLTD_A
CNPcolNames = [{'CPF_A.CPF_TP'},{'CPF_A.CPF_TN'}, {'CPF_A.CPF_FP'}, {'CPF_A.CPF_FN'}, ...
    {'PCPTNL.CPT_TP'},{'PCPTNL.CPT_TN'},{'PCPTNL.CPT_FP'},{'PCPTNL.CPT_FN'},{'CPFD_A.CPFD_TP'}, ...
    {'CPFD_A.CPFD_TN'},{'CPFD_A.CPFD_FP'},{'CPFD_A.CPFD_FN'}, {'SVOLT_A.SVOLT_TP'}, {'SVOLT_A.SVOLT_TN'}, ...
    {'SVOLT_A.SVOLT_FP'}, {'SVOLT_A.SVOLT_FN'}, {'SVOLTD_A.SVOLTD_TP'}, {'SVOLTD_A.SVOLTD_TN'}, {'SVOLTD_A.SVOLTD_FP'}, {'SVOLTD_A.SVOLTD_FN'}];
parfor i = 1:length(CNPcolNames)
    CNPcolData{i} = getColDataByLabel(pennCNPsheet,CNPcolNames{i});
end

dPrime = cell(5,1);
for i = 0:4
    dPrime{i+1} = calc_dPrime(CNPcolData{4*i + 1},CNPcolData{4*i + 2},CNPcolData{4*i + 3},CNPcolData{4*i + 4});
end

dPrimeCols = [makeCol(dPrime{1},'CPF_A.Dprime'), makeCol(dPrime{2},'PCPTNL.Dprime'), makeCol(dPrime{3},'CPFD_A.Dprime'), makeCol(dPrime{4},'SVOLT_A.dPrime'), makeCol(dPrime{5},'SVOLTD_A.dPrime')];

fullSheet.PennCNP = [pennCNPsheet,dPrimeCols];

sheetFields = fieldnames(fullSheet);
hugeSpreadsheet = [];
taskStartColNumbers = zeros(length(sheetFields),1);
for i = 1:length(sheetFields)
    [hugeSpreadsheet,taskStartColNumbers(i)] = MergeArrays(hugeSpreadsheet,fullSheet.(sheetFields{i}));
end
hugeSpreadsheetColumnLabels = cell(1,size(hugeSpreadsheet,2));
for i=1:length(sheetFields)
    hugeSpreadsheetColumnLabels{taskStartColNumbers(i)} = sheetFields{i};
end
hugeSpreadsheetWithLabels = [hugeSpreadsheetColumnLabels;hugeSpreadsheet];

xlsWriteBufferedOverwrite(AllAggregateOutputFileName,makenansheet(hugeSpreadsheetWithLabels,3,2));

%Now to filter for our select data sheet
selectList.SIRPOBJ = [{'Median RT (Overall)'},{'D Prime'}, {'Percent Correct (Overall, Recent Negative)'}, {'K'}, {'A'}];
selectList.SIRP = {'Median RT (Overall)','D Prime','Percent Correct (Overall, Recent Negative)','K','A'};
selectList.PR = {'Button Presses (Valid)'};
selectList.AXCPT = [{'D-Prime Context'},{'Median AY RT / Median AX RT'},{'Median BY RT / Median BX RT'}];
selectList.CD = [{'Median RT (Overall)'},{'Memory Capacity Estimation'},{'Attention Parameter'}];
selectList.SOT = [{'Median RT (Overall)'}, {'Memory Estimation (K)'},{'Memory Estimation (A)'}];
selectList.NBCDR = {'Median RT (Overall)','Proportion Correct (Condition 1)','Proportion Correct (Condition 2)'};
selectList.OSpan = {'OSPAN PU','K'};
selectList.SSpan = {'SSPAN PU','K'};
selectList.NBDMS = {'Proportion Correct (Overall)','Median RT (Overall)','Proportion Correct (Match)(Condition 1)','Proportion Correct (Recent Negative)(Condition 1)','Proportion Correct (NonRecent Negative)(Condition 1)','Proportion Correct (Match)(Condition 2)','Proportion Correct (Recent Negative)(Condition 2)','Proportion Correct (NonRecent Negative)(Condition 2)'};
selectList.WASI = {'WASI Vocab T-Scores', 'WASI Matrix T-Scores'};
selectList.PennCNP = {'MPRACT.MP2RTCR','CPF_A.Dprime','CPF_A.CPF_RT','PCPTNL.Dprime','PCPTNL.CPT_RT','AIM.CRRT_NM','AIM.CRRT_M','AIM.AIM_NM','AIM.AIM_M','CPFD_A.Dprime','CPFD_A.CPFD_RT',...
    'SVOLT_A.dPrime','SVOLT_A.SVOLT_RT','DIGSYM.DSCOR','DIGSYM.DSCORRT','DIGSYM.DSMEMCR','DIGSYM.DSMCRRT','SCTAP.SCTAP_TOT','SVOLTD_A.dPrime','SVOLTD_A.SVOLTD_RT'};
selectList.Demographics = {};

selectHugeSpreadsheet = [];
selectTaskStartColNumbers = zeros(length(sheetFields),1);
%Make select field sheets
for i = 1:length(sheetFields)
    disp(sheetFields{i}); pause(eps); drawnow;
    [selectHugeSpreadsheet,selectTaskStartColNumbers(i)] = MergeArraysSelectFields(selectHugeSpreadsheet,fullSheet.(sheetFields{i}),selectList.(sheetFields{i}) );
end
selectHugeSpreadsheetColumnLabels = cell(1,size(selectHugeSpreadsheet,2));
for i=1:length(sheetFields)
    selectHugeSpreadsheetColumnLabels{selectTaskStartColNumbers(i)} = sheetFields{i};
end
selectHugeSpreadsheetWithLabels = [selectHugeSpreadsheetColumnLabels;selectHugeSpreadsheet];
xlsWriteBufferedOverwrite(SelectAggregateOutputFileName,makenansheet(selectHugeSpreadsheetWithLabels,3,2));


% Reorganize Excel file according to user input 
if ~isempty(DataCell)
    Excel_Reorganizer_v3(AllAggregateOutputFileName, SortedAllDataPath, DataCell);
    
    Excel_Reorganizer_v3(SelectAggregateOutputFileName, SortedSelectDataPath, DataCell);
end

