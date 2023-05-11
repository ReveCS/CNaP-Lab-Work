load('W1.mat','dataStructsCell');
dataStructsCell1 = dataStructsCell;
dataStructsCell2 = dataStructsCell;
[dataStructsCell1, dataStructsCell2] = splitAXCPT(dataStructsCell, dataStructsCell1, dataStructsCell2);
[dataStructsCell1, dataStructsCell2] = splitCD(dataStructsCell, dataStructsCell1, dataStructsCell2);
[dataStructsCell1, dataStructsCell2] = splitNBCDR(dataStructsCell, dataStructsCell1, dataStructsCell2);
[dataStructsCell1, dataStructsCell2] = splitNBDMS(dataStructsCell, dataStructsCell1, dataStructsCell2);
[dataStructsCell1, dataStructsCell2] = splitSIRP(dataStructsCell, dataStructsCell1, dataStructsCell2);
[dataStructsCell1, dataStructsCell2] = splitVIRP(dataStructsCell, dataStructsCell1, dataStructsCell2);
[dataStructsCell1, dataStructsCell2] = splitSOT(dataStructsCell, dataStructsCell1, dataStructsCell2);
save('dataStructsCell1.mat','dataStructsCell1');
save('dataStructsCell2.mat','dataStructsCell2');


%%
load('W1.mat')
load('dataStructsCell1.mat');
dataStructsCell = dataStructsCell1;
save('W1_withDS1.mat')
clear
load('W2.mat')
load('dataStructsCell2.mat');
dataStructsCell = dataStructsCell2;
save('W2_withDS2.mat')