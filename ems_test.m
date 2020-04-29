% Classification script
%{
        %L=readtable('L:\PassOff_Data\ClassificationAlgorithm\ems_data\full_n1speed_M021211.csv');
        %L=readtable('L:\PassOff_Data\ClassificationAlgorithm\ems_data\ems_M021211.csv');
        %L=readtable('L:\PassOff_Data\ClassificationAlgorithm\ems_data\ems_M030201.csv');
        L=readtable('L:\PassOff_Data\ClassificationAlgorithm\ems_data\ems_123727.csv');
        T=table2array(L);
        %a=double(cell2mat(T));
        %y=a(:)';
        y=T';
        y(find(isnan(y)))=[];
        class=PassOff_Classification_n1(y');
        save('Ems_n1_M123727','class');
        
        %%
        
        w=findchangepts(y,'Statistic','linear','MinThreshold',4*log(length(y)));
        [FS]=ManExtract(w',y);
        start=FS.newstart;
        endtime=FS.newendtime;
        plot(y);
        vline(start, 'r');
        vline(endtime,'b');
        hold off;
%}

%%

numbers=[020740,021035,030915,034735,063612,065544,073622,075140,083013,094902,095121,110408,110941,150353,151657,154719,164052,165133,183441,183755,184857,190031,190147,190802,205321,212518,233649];
%ems_n1_data=cell(29,1);
load('Ems_n1_data');
for k=28:29%1:29
    try
        %L=readtable(['L:\PassOff_Data\ClassificationAlgorithm\n1_data\M' num2str(numbers(k),'%06.f') '.csv']);
        %T=table2array(L(3:end,4));
        %a=cellfun(@str2num,T');
        %y=a';
        %y(find(isnan(y)))=[];
        y=ems_n1_data{k};
        % Manoeuvre extraction
        w=findchangepts(y,'Statistic','linear','MinThreshold',4*log(length(y)));
        [FS]=ManExtract(w,y);
        start=FS.newstart;
        endtime=FS.newendtime;
        h=figure();
        plot(y);
        vline(start, 'r');
        vline(endtime,'b');
        %title(sprintf('N1 plot of M%d', num2str(numbers(k),'%06.f')))
        title('N1 plot')
        xlabel('time') % x-axis label
        ylabel('percentage speed') % y-axis label
        hold off;
        %saveas(h, fullfile('L:\PassOff_Data\ClassificationAlgorithm\ems_data\', sprintf('withlen_ems_n1data_manextract_M%d',numbers(k))),'png');
        
        % Classification of the manoeuvres
        class=PassOff_Classification_n1(y);
        save(['Ems_data_filtering_',num2str(k)],'class');
            
    catch
        warning('Problem using function.');
        fprintf('issue with dataset %d\n', k);
    end
        
end
%save('Ems_n1_data', 'ems_n1_data');
