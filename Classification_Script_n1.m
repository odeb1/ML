% Classification script

for k=20:40%81:93
        load(['L:\PassOff_Data\cleanESN' num2str(k) '.mat'])
        y=clean_tdata.n1;
        class=PassOff_Classification_n1(y);
        save(['Test_filtered_',num2str(k)],'class');
end

%{
for k=35:40
        load(['L:\PassOff_Data\cleanESN' num2str(k) '.mat'])
        y=clean_tdata.n1;
        class=PassOff_Classification_n1(y);
        save(['Tryagain_len_n1_',num2str(k)],'class');
end
%}

%{
for k=34
        load(['L:\PassOff_Data\cleanESN' num2str(k) '.mat'])
        y=clean_tdata.n1;
        w=findchangepts(y,'Statistic','linear','MinThreshold',4*log(length(y)));
        [FS]=ManExtract(w,y);
        start=FS.newstart;
        endtime=FS.newendtime;
        plot(y);
        vline(start, 'r');
        vline(endtime,'b');
        %vline(898795,'m');
        hold off;
        %class=PassOff_Classification(y);
        %save(['SecTestLabels_',num2str(k)],'class');
end
%}