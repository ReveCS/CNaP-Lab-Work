function [dataStructsCell1, dataStructsCell2] = splitSOT(dataStructsCell, dataStructsCell1, dataStructsCell2)

    subject_size = length(dataStructsCell1{7, 1});
        for i = 1:subject_size
            if ~isempty(dataStructsCell{7, 1}(i).trial) 
                trials = dataStructsCell{7, 1}(i).trial;
                shuffledTrials = randperm(size(trials, 1));
                if((-1)^(length(shuffledTrials)) == -1) %Check if odd
                    mid = floor(length(shuffledTrials)/2); %Round down to get mid of even trials (11 -> mid 5)
                else
                    mid = length(shuffledTrials)/2;
                end
                %Split run trial
                dataStructsCell1{7, 1}(i).run.trial = dataStructsCell{7 ,1}(i).run.trial(shuffledTrials(1:mid), :);
                dataStructsCell2{7, 1}(i).run.trial = dataStructsCell{7 ,1}(i).run.trial(shuffledTrials(mid+1:end), :);
                %Clear run trial
                dataStructsCell1{7, 1}(i).run.trial((mid+1:end), :) = [];
                dataStructsCell2{7, 1}(i).run.trial((mid+1):end, :) = [];

                %Split run type
                dataStructsCell1{7, 1}(i).run.type = dataStructsCell{7 ,1}(i).run.type(shuffledTrials(1:mid));
                dataStructsCell2{7, 1}(i).run.type = dataStructsCell{7 ,1}(i).run.type(shuffledTrials(mid+1:end));
                %Clear run type
                dataStructsCell1{7, 1}(i).run.type((mid+1):end) = [];
                dataStructsCell2{7, 1}(i).run.type((mid+1):end) = [];

                %Split run instruct
                dataStructsCell1{7, 1}(i).run.instruct = dataStructsCell{7 ,1}(i).run.instruct(shuffledTrials(1:mid));
                dataStructsCell2{7, 1}(i).run.instruct = dataStructsCell{7 ,1}(i).run.instruct(shuffledTrials(mid+1:end));
                %Clear run instruct
                dataStructsCell1{7, 1}(i).run.instruct((mid+1):end) = [];
                dataStructsCell2{7, 1}(i).run.instruct((mid+1):end) = [];

                %Split trials
                dataStructsCell1{7, 1}(i).trial = dataStructsCell{7 ,1}(i).trial(shuffledTrials(1:mid), :);
                dataStructsCell2{7, 1}(i).trial = dataStructsCell{7 ,1}(i).trial(shuffledTrials(mid+1:end), :);
                %Clear trials
                dataStructsCell1{7, 1}(i).trial((mid+1):end, :) = [];
                dataStructsCell2{7, 1}(i).trial((mid+1):end, :) = [];

                %Split results
                dataStructsCell1{7, 1}(i).results = dataStructsCell{7 ,1}(i).results(shuffledTrials(1:mid), :);
                dataStructsCell2{7, 1}(i).results = dataStructsCell{7 ,1}(i).results(shuffledTrials(mid+1:end), :);
                %Clear results
                dataStructsCell1{7, 1}(i).results((mid+1):end, :) = [];
                dataStructsCell2{7, 1}(i).results((mid+1):end, :) = [];

                %Split rt
                dataStructsCell1{7, 1}(i).rt = dataStructsCell{7 ,1}(i).rt(shuffledTrials(1:mid), :);
                dataStructsCell2{7, 1}(i).rt = dataStructsCell{7 ,1}(i).rt(shuffledTrials(mid+1:end), :);
                %Clear rt
                dataStructsCell1{7, 1}(i).rt((mid+1):end, :) = [];
                dataStructsCell2{7, 1}(i).rt((mid+1):end, :) = [];

                %Split streak
                dataStructsCell1{7, 1}(i).streak = dataStructsCell{7 ,1}(i).streak(shuffledTrials(1:mid), :);
                dataStructsCell2{7, 1}(i).streak = dataStructsCell{7 ,1}(i).streak(shuffledTrials(mid+1:end), :);
                %Clear streak
                dataStructsCell1{7, 1}(i).streak((mid+1):end, :) = [];
                dataStructsCell2{7, 1}(i).streak((mid+1):end, :) = [];
            end
        end
