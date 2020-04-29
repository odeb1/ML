%% labelling section of each test 

function[alllabel,nt_label,features]=Decision_filtered(FS,y)
        %Setup
        manstart=FS.newstart;
        manendtime=FS.newendtime;
        manstartloc=FS.manstartloc;        
        
        %
        filteredspeeds=[];
        filteredends=[];
        filteredstarts=[];
        %Initialise the outputs
        alllabel=[];
        nt_label=[];
        features=[];
        probfeatures=[];
        adjprobfeatures=[];
        prevlabel=0;
        threshold=0.9;
        for l=1:length(manstart)
            fixedspeeds=[];
            fixedstarts=[];
            fixedends=[];
            secy=y(manstart(l):manendtime(l));
            w=findchangepts(secy,'Statistic','linear','MinThreshold',4*log(length(secy)));
            [WD]=SegmentExtract(w,secy); 
            means=WD.means;
            starts=WD.starts;
            ends=WD.ends;
            if  sum(means<10)>0
                prevlabel=0;
                alllabel=[alllabel;0];
                filteredspeeds=[filteredspeeds;0];
                filteredends=[filteredends;ends];
                filteredstarts=[filteredstarts;starts];
            else
                for k=1:length(means)
                    segmentstart=starts(k);
                    segmentend=ends(k);
                    [r,~,~] = regression(segmentstart:segmentend,secy(segmentstart:segmentend)','one');
                    if abs(r)<threshold
                        fixedspeeds=[fixedspeeds;means(k)];
                        fixedstarts=[fixedstarts;starts(k)];
                        fixedends=[fixedends;ends(k)];
                    end
                end
                filteredspeeds=[filteredspeeds;fixedspeeds];
                filteredstarts=[filteredstarts;fixedstarts];
                filteredends=[filteredends;fixedends];
                [label, Adash]=Basis_Scoring_filtered(secy, fixedspeeds, prevlabel);
                prevlabel=label;
                features=[features; Adash];
                alllabel=[alllabel;label];
                nt_label=[nt_label;label];
            end
        end
end
