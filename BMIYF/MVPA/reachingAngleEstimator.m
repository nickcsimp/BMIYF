function [eRA, normDiff] = reachingAngleEstimator(iRA,iTest,maxLength,spikes)
    load monkeydata_training.mat trial;
    f_spikes = spikes;
    diff = [];
    for a = 1:8
        testSpike = trial(iTest,iRA).spikes;
        len = length(testSpike);
        if len > maxLength(a)
            for i = maxLength(a):len
                for j = 1:98
                    f_spikes{a}(j,i)=0;
                end
            end
        else
            for i = len:maxLength(a)
                for j = 1:98
                    testSpike(j,i)=0;
                end
            end
        end
        
        diff(a) = norm(f_spikes{a} - testSpike);
    end
    
    [M,estimatedReachingAngle] = min(diff);
    eRA = estimatedReachingAngle;
    normDiff = diff;
end