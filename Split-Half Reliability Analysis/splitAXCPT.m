function [dataStructsCell1, dataStructsCell2] = splitAXCPT(dataStructsCell, dataStructsCell1, dataStructsCell2)

    subject_size = length(dataStructsCell1{1, 1}.subject);
        for j = 1:subject_size
            run_size = length(dataStructsCell1{1, 1}.subject(j).run);
            if (run_size > 0)
                for k = 1:run_size
                    if ~isempty(dataStructsCell{1, 1}.subject(j).run(k).trial) 
                        stimAX = find(contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim1},'A') & contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim2},'X'));
                        stimAY = find(contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim1},'A') & ~contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim2},'X'));
                        stimBX = find(~contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim1},'A') & contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim2},'X'));
                        stimBY = find(~contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim1},'A') & ~contains({dataStructsCell{1, 1}.subject(j).run(k).trial.stim2},'X'));
                        typeList = {stimAX, stimAY, stimBX, stimBY};
                        endIndex1 = 0;
                        endIndex2 = 0;
                        for i = 1:length(typeList)
                            stimtrials = dataStructsCell{1, 1}.subject(j).run(k).trial(typeList{1, i});
                            shuffledTrials = stimtrials(randperm(length(stimtrials)))
                            if((-1)^(length(shuffledTrials)) == -1) %Check if odd
                                mid = floor(length(shuffledTrials)/2); %Round down to get mid of even trials (11 -> mid 5)
                                dataStructsCell1{1, 1}.subject(j).run(k).trial((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                                dataStructsCell2{1, 1}.subject(j).run(k).trial((endIndex2 + 1):(mid + endIndex2 + 1)) = shuffledTrials((mid+1):end);
                                endIndex1 = endIndex1 + mid;
                                endIndex2 = endIndex2 + mid + 1;
                            else
                                mid = length(shuffledTrials)/2;
                                dataStructsCell1{1, 1}.subject(j).run(k).trial((endIndex1 + 1):(mid + endIndex1)) = shuffledTrials(1:mid);
                                dataStructsCell2{1, 1}.subject(j).run(k).trial((endIndex2 + 1):(mid + endIndex2)) = shuffledTrials((mid+1):end);
                                endIndex1 = endIndex1 + mid;
                                endIndex2 = endIndex2 + mid;
                            end
                        end
                        dataStructsCell1{1, 1}.subject(j).run(k).trial((endIndex1+1):end) = [];
                        dataStructsCell2{1, 1}.subject(j).run(k).trial((endIndex2+1):end) = [];
                    else
                        error('Subject ' + j + 'has an empty trial run')
                    end
                end
            end
        end
end
