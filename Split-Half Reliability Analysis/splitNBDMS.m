function [dataStructsCell1, dataStructsCell2] = splitNBDMS(dataStructsCell, dataStructsCell1, dataStructsCell2)

    subject_size = length(dataStructsCell1{4, 1}.subject);
        for i = 1:subject_size
            run_size = length(dataStructsCell1{4, 1}.subject(i).run);
            for j = 1:run_size
                if ~isempty(dataStructsCell{4, 1}.subject(i).run(j)) 
                    cond1 = find(ismember([dataStructsCell{4, 1}.subject(i).run(j).block.condition], 1));
                    cond2 = find(ismember([dataStructsCell{4, 1}.subject(i).run(j).block.condition], 2));
                    conditionList = {cond1, cond2};
                    endIndex1 = 0;
                    endIndex2 = 0;
                    for k = 1:length(conditionList)
                        condTrials = dataStructsCell{4, 1}.subject(i).run(j).block(conditionList{1, k});
                        shuffledTrials = condTrials(randperm(length(condTrials)));
                        if((-1)^(length(shuffledTrials)) == -1) %Check if odd
                            mid = floor(length(shuffledTrials)/2); %Round down to get mid of even trials (11 -> mid 5)
                            dataStructsCell1{4, 1}.subject(i).run(j).block((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                            dataStructsCell2{4, 1}.subject(i).run(j).block((endIndex2 + 1):(mid + endIndex2 + 1)) = shuffledTrials((mid+1):end);
                            endIndex1 = endIndex1 + mid;
                            endIndex2 = endIndex2 + mid + 1;
                        else
                            mid = length(shuffledTrials)/2;
                            dataStructsCell1{4, 1}.subject(i).run(j).block((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                            dataStructsCell2{4, 1}.subject(i).run(j).block((endIndex2 + 1):(mid + endIndex2)) = shuffledTrials((mid+1):end);
                            endIndex1 = endIndex1 + mid;
                            endIndex2 = endIndex2 + mid;
                        end
                    end
                    dataStructsCell1{4, 1}.subject(i).run(j).block((endIndex1+1):end) = [];
                    dataStructsCell2{4, 1}.subject(i).run(j).block((endIndex2+1):end) = [];
                else
                    error('Subject ' + j + 'has an empty run')
                end
            end
        end