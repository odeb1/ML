%% labelling section of each test 

%% labelling section of each test

function[alignmentA, alignmentB, fixedspeeds, info]=Alignment_Extraction(FS,y,threshold,label)
        
        %Setup
        meanvalues=FS.means;
        allstarts=FS.starts;
        allends=FS.ends;
        
        model5=[96;90;86;79;72;60;51;27];
        
        %initialise
        filteredspeeds=[];
        filteredstarts=[];
        filteredends=[];
         
            fixedspeeds=[];
            fixedstarts=[]; %the start of each fixed speed segment
            fixedends=[]; %end of each fixed speed segment
            mansec=meanvalues;
                for k=1:length(mansec)
                    segmentstart=allstarts(k);
                    segmentend=allends(k);
                    [r,~,~] = regression(segmentstart:segmentend,y(segmentstart:segmentend)','one');
                    if abs(r)<threshold
                        fixedspeeds=[fixedspeeds;mansec(k)];
                        fixedstarts=[fixedstarts;allstarts(k)];
                        fixedends=[fixedends;allends(k)];
                    end
                end
                filteredspeeds=[filteredspeeds;fixedspeeds];
                filteredstarts=[filteredstarts;fixedstarts];
                filteredends=[filteredends;fixedends];
                [~, n, alignmentA, alignmentB, info]=template_Needleman_info(model5,fixedspeeds);
end

