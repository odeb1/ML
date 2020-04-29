% Function that labels using the rules extracted from the decision tree

function[label]=Decision_Tree_n1(features)

if length(features)~=10
    error('Feature vector is not of length 10');
    %return
end

if features(1)>=-4.784
    label=1;
elseif features(8)<7.19
    label=8;
elseif features(9)<11690
    label=7;
    %{
    if features(10)<80 
        label=-1;
    elseif features(7)<features(8)
        label=7;
    else 
        label=8;
    end
    %}
elseif features(2)<-19.36
    label=5;
elseif features(7)>856.7
    label=4;
elseif features(8)>=533.5
    if features(10)>60 %added to improve classification of manoeuvre B
        label=-1;
    else
        label=2;
    end
elseif features(3)>-13.4
    label=3;
else
    label=-1;
end