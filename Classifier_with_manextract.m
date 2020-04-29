%% Building an autonomous classification algorithm

%% Write labelling code, using PELT
% Put the NW labelling and FPCA labelling into a function to make code easier to read
% comment what is happening?
% Can the code be speeded up?
% Use Labelling algorithm: funcNWlabel 
% This section takes the Cdata and uses the function NWlabel to extract labels

counter=ones(1,40,1);
timings=[];
minTime = Inf;
tic;  % TIC, pair 1  
threshold=0.9;
for k=1:40 %93  
        tic;
        %load(['L:\PassOff_Data\ClassificationAlgorithm\ManExtract' num2str(k) '.mat'])
        load(['PELT_ManExtract' num2str(k) '.mat'])
        load(['L:\PassOff_Data\cleanESN' num2str(k) '.mat'])
        tStart = tic;    
        y=clean_tdata.n1;
        %[allmeans,allstart,allend,statmean,statstart,statend]=Stationary_levels(y, L);
        meanvalues=FS.means;
        manstart=FS.newstart;
        manendtime=FS.newendtime;
        manstartloc=FS.manstartloc;
        manlength=length(manstartloc);
        manstartloc=manstartloc(1:manlength-1);
        manendtimeloc=FS.manendtimeloc;
        allstarts=FS.starts;
        allends=FS.ends;
        [alllabel,nt_label,features,probfeatures,adjprobfeatures,start,endtime,filteredspeeds,filteredstarts,filteredends]=Basis_funcNWlabel_decision_man(meanvalues,manstart,manendtime,manstartloc,manendtimeloc,allstarts, allends, y,threshold);   %NWlabel(meanvalues,meanstart,meanend);          
        %fprintf('%d\n',sum(nt_label));
        class.alllabel=alllabel;
        class.label=nt_label;
        class.features=features;
        class.probfeatures=probfeatures;
        class.adjprobfeatures=adjprobfeatures;
        class.start=start; %start time of maneouvres
        class.end=endtime; %end time of maneouvres
        class.manstart=manstart; %start time of all things
        class.manend=manendtime; %end time of all things
        class.filteredspeeds=filteredspeeds;
        class.filteredstarts=filteredstarts;
        class.filteredends=filteredends;
        save(['PELT_Basis_FuncCEData_Man_',num2str(k)],'class');  
        counter(k)=length(nt_label);
        %{
        if counter(k) ~= allcount(k)
            fprintf('error %d\n',k)
        end
        %}
   toc;
   tElapsed = toc(tStart);  % TOC, pair 2  
   minTime = min(tElapsed, minTime);
   timings=[timings,tElapsed];  
end


%{
allprobfeatures=[];
allfeatures=[];
for k=1:40
    load(['Basis_FuncCEData_Man_' num2str(k) '.mat'])    
    features=class.features;
    probfeatures=class.probfeatures;
    labels=class.label;
    if k==19
    %We can also extract the probabilistic NW features
    %adjfeatures=[adjfeatures; alladjprobfeatures(1:7,:)];
    allfeatures=[allfeatures; features(1:7,:)];
    allprobfeatures=[allprobfeatures;probfeatures(1:7,:)];
    else
        %We can also extract the probabilistic NW features
    %adjfeatures=[adjfeatures; alladjprobfeatures];
    allfeatures=[allfeatures; features];
    allprobfeatures=[allprobfeatures;probfeatures];
    end
end
filename = sprintf('NEWTrainingSet_basis_features_justonemore%d.csv',1);
csvwrite(filename, allfeatures);
adjfilename = sprintf('NEWTrainingSet_basis_probfeatures_justonemore%d.csv',1);
csvwrite(adjfilename, allprobfeatures);
%}
