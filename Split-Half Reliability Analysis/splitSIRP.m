function [dataStructsCell1, dataStructsCell2] = splitSIRP(dataStructsCell, dataStructsCell1, dataStructsCell2)

    subject_size = length(dataStructsCell1{5, 1}.subject);
        for i = 1:subject_size
            if ~isempty(dataStructsCell{5, 1}.subject(i).trial) 
                cond2 = find(ismember([dataStructsCell{5, 1}.subject(i).trial.condition], 2));
                cond4 = find(ismember([dataStructsCell{5, 1}.subject(i).trial.condition], 4));
                cond6 = find(ismember([dataStructsCell{5, 1}.subject(i).trial.condition], 6));
                cond8 = find(ismember([dataStructsCell{5, 1}.subject(i).trial.condition], 8));
                conditionList = {cond2, cond4, cond6, cond8};
                endIndex1 = 0;
                endIndex2 = 0;
                for j = 1:length(conditionList)
                    condtrials = dataStructsCell{5, 1}.subject(i).trial(conditionList{1, j});
                    shuffledTrials = condtrials(randperm(length(condtrials)));
                    if((-1)^(length(shuffledTrials)) == -1) %Check if odd
                        mid = floor(length(shuffledTrials)/2); %Round down to get mid of even trials (11 -> mid 5)
                        dataStructsCell1{5, 1}.subject(i).trial((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                        dataStructsCell2{5, 1}.subject(i).trial((endIndex2 + 1):(mid + endIndex2 + 1)) = shuffledTrials((mid+1):end);
                        endIndex1 = endIndex1 + mid;
                        endIndex2 = endIndex2 + mid + 1;
                    else
                        mid = length(shuffledTrials)/2;
                        dataStructsCell1{5, 1}.subject(i).trial((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                        dataStructsCell2{5, 1}.subject(i).trial((endIndex2 + 1):(mid + endIndex2)) = shuffledTrials((mid+1):end);
                        endIndex1 = endIndex1 + mid;
                        endIndex2 = endIndex2 + mid;
                    end
                end
                dataStructsCell1{5, 1}.subject(i).trial((endIndex1+1):end) = [];
                dataStructsCell2{5, 1}.subject(i).trial((endIndex2+1):end) = [];
            else
                error('Subject ' + i + 'has an empty trial')
            end
        end