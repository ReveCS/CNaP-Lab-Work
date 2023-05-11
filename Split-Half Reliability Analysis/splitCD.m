function [dataStructsCell1, dataStructsCell2] = splitCD(dataStructsCell, dataStructsCell1, dataStructsCell2)

    subject_size = length(dataStructsCell1{2, 1}.subject);
        for i = 1:subject_size
            run_size = length(dataStructsCell1{2, 1}.subject(i).run);
            for j = 1:run_size
                if ~isempty(dataStructsCell{2, 1}.subject(i).run(j).trial) 
                    targetSizes = arrayfun(@(x) length(dataStructsCell{2, 1}.subject(i).run(j).trial(x).target), 1:numel(dataStructsCell{2, 1}.subject(1).run(1).trial));
                    target2 = find(ismember(targetSizes, 2));
                    target4 = find(ismember(targetSizes, 4));
                    target6 = find(ismember(targetSizes, 6));
                    target8 = find(ismember(targetSizes, 8));
                    targetList = {target2, target4, target6, target8};
                    endIndex1 = 0;
                    endIndex2 = 0;
                    for k = 1:length(targetList)
                        targetTrials = dataStructsCell{2, 1}.subject(i).run(j).trial(targetList{1, k});
                        shuffledTrials = targetTrials(randperm(length(targetTrials)));
                        if((-1)^(length(shuffledTrials)) == -1) %Check if odd
                            mid = floor(length(shuffledTrials)/2); %Round down to get mid of even trials (11 -> mid 5)
                            dataStructsCell1{2, 1}.subject(i).run(j).trial((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                            dataStructsCell2{2, 1}.subject(i).run(j).trial((endIndex2 + 1):(mid + endIndex2 + 1)) = shuffledTrials((mid+1):end);
                            endIndex1 = endIndex1 + mid;
                            endIndex2 = endIndex2 + mid + 1;
                        else
                            mid = length(shuffledTrials)/2;
                            dataStructsCell1{2, 1}.subject(i).run(j).trial((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                            dataStructsCell2{2, 1}.subject(i).run(j).trial((endIndex2 + 1):(mid + endIndex2)) = shuffledTrials((mid+1):end);
                            endIndex1 = endIndex1 + mid;
                            endIndex2 = endIndex2 + mid;
                        end
                    end
                    dataStructsCell1{2, 1}.subject(i).run(j).trial((endIndex1+1):end) = [];
                    dataStructsCell2{2, 1}.subject(i).run(j).trial((endIndex2+1):end) = [];
                else
                    error('Subject ' + i + 'has an empty trial')
                end
            end
        end