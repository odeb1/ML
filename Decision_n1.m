%% labelling section of each test 

function[alllabel,nt_label,features]=Decision_n1(FS,y,threshold)
        
        %Setup
        meanvalues=FS.means;
        manstart=FS.newstart;
        manendtime=FS.newendtime;
        manstartloc=FS.manstartloc;
        manlength=length(manstartloc);
        manstartloc=manstartloc(1:manlength-1);
        manendloc=FS.manendtimeloc;
        allstarts=FS.starts;
        allends=FS.ends;
        
        %initialise
        filteredspeeds=[];
        filteredstarts=[];
        filteredends=[];
        
        %Initialise the outputs
        alllabel=[];
        nt_label=[];
        features=[];
        probfeatures=[];
        adjprobfeatures=[];
        prevlabel=0;
        for i=1:length(manendloc) 
            fixedspeeds=[];
            fixedstarts=[]; %the start of each fixed speed segment
            fixedends=[]; %end of each fixed speed segment
            mansec=meanvalues(manstartloc(i)+1:manendloc(i)-1);
            if  sum(mansec<10)>0
                prevlabel=0;
                alllabel=[alllabel;0];
                filteredspeeds=[filteredspeeds;0];
                filteredends=[filteredends;allends(manendloc(i)-1)];
                filteredstarts=[filteredstarts;allstarts(manstartloc(i)+1)];
                
                i=i+1;
            %elseif manstart(i)>manendtime(i) % condition to avoid null segments
            %    i=i+1;
            else
                for k=1:length(mansec)
                    segmentstart=allstarts(manstartloc(i)+k+1);
                    segmentend=allends(manstartloc(i)+k+1);
                    [r,~,~] = regression(segmentstart:segmentend,y(segmentstart:segmentend)','one');
                    if abs(r)<threshold
                        fixedspeeds=[fixedspeeds;mansec(k)];
                        fixedstarts=[fixedstarts;allstarts(manstartloc(i)+k+1)];
                        fixedends=[fixedends;allends(manstartloc(i)+k+1)];
                    end
                end
                filteredspeeds=[filteredspeeds;fixedspeeds];
                filteredstarts=[filteredstarts;fixedstarts];
                filteredends=[filteredends;fixedends];
            [label, Adash]=Basis_Scoring_n1(y,fixedspeeds,manstart(i),manendtime(i), prevlabel);
            prevlabel=label;
            features=[features; Adash];
            alllabel=[alllabel;label];
            nt_label=[nt_label;label];
            %fixedspeeds=[]; % just added 
            %start=[start;manstart(i)];
            %endtime=[endtime;manendtime(i)];
            end
        end
end
