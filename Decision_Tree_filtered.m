% Function that labels using the rules extracted from the decision tree

function[label]=Decision_Tree_filtered(features)

if length(features)~=11
    error('Feature vector is not of length 11');
    %return
end

if features(8)>=955.7
    %Added condition
    if features(10)>40
        label=-1;
    else
        label=1;
    end
elseif features(8)<8.137
    label=8;
elseif features(2)>=0.5
    label=2;
    %Condition added to deal with rare RP manoeuvres
%elseif features(6)>=-4 && features(9)>160000
%    label=6;
elseif features(5)>=-1.5
    label=5;
elseif features(7)<14.65 && features(9)<10000
    label=7;
elseif features(7)>=781.1
    label=4;
elseif features(3)>=1
    label=3;
else
    label=-1;
end