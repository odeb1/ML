%% colour sections of the test using labels

db = [161 4 211]./ 255;
brown = [220 119 26]./ 255;
Brown = [139 32 22]./ 255;
greeney = [40 112 8]./ 255;
purple= [140 62 214]./ 255;
citrine= [206 201 12]./ 255;

%{
        L=readtable('L:\PassOff_Data\ClassificationAlgorithm\ems_data\full_n1speed_M021211.csv');
        T=table2array(L(3:end,4));
        y=double(cell2mat(T'));
%}
        %load(['L:\PassOff_Data\cleanESN' num2str(k) '.mat'])
        %load('Ems_n1')
        %load('Ems_n1_M030021')
        %load('Ems_n1_M123727')
        numbers=[002107,014126,022055,022309,024319,031029,031211,031736,031907,034144,034413,042658,043815,043934,051047,051317,060838,094357,100320,102047,105434,114156,115553,130117,131100,151035,232942,233825];
        %load('XWB_Ems_n1_data')
        for k=6 %1:7
        load(['XWB_collected_',num2str(k)]);
        y=xwb;
        load(['XWB_collected_filtering_',num2str(k)]);
        %load(['XWB_ems_filtering_',num2str(k)])
        %y=xwb_ems_n1_data{k};
        for i=1:length(y)
            if y(i)<0
                y(i)=0;
            end
        end
        label=class.labels;
        start=class.start;
        endtime=class.endtime;
        t=1:length(y);    
        h=figure();
        plot(t,y, 'k');
        hold on;
        for i=1:length(label)
            if label(i)==1
                index=start(i):endtime(i);
                plot(t(index),y(index),'LineWidth', 1, 'Color', db);
                txt1 = 'A';
                text(index(1)+round(length(index)/2),max(y(index))+2,txt1)
            elseif label(i)==2
                index=start(i):endtime(i);
                plot(t(index),y(index), 'b');
                txt1 = 'B';
                text(index(1)+round(length(index)/2),max(y(index))+2,txt1)
            elseif label(i)==3
                index=start(i):endtime(i);
                plot(t(index),y(index), 'LineWidth', 1, 'Color', purple);
                txt1 = 'C';
                %text(index(1)+round(length(index)/2),max(y(index))+2,txt1)
                text(index(1)+round(length(index)/2),max(y(index)),txt1)
                
                %text(index(1)+round(length(index)/2),0,txt1)
            elseif label(i)==4
                index=start(i):endtime(i);
                plot(t(index),y(index), 'c');
                txt1 = 'R';
                %text(index(1)+round(length(index)/2),max(y(index))+2,txt1)
                
                text(index(1)+round(length(index)/2),max(y(index)),txt1)
                %text(index(1)+round(length(index)/2),0,txt1)
            elseif label(i)==5
                index=start(i):endtime(i);
                plot(t(index),y(index), 'LineWidth', 1, 'Color', brown);
                txt1 = 'P';
                text(index(1)+round(length(index)/2),max(y(index)),txt1)
                %text(index(1)+round(length(index)/2),0,txt1)
            elseif label(i)==6
                index=start(i):endtime(i);
                plot(t(index),y(index), 'LineWidth', 1, 'Color', citrine );
                txt1 = 'RP';
                %text(index(1)+round(length(index)/2),max(y(index))+2,txt1)
                text(index(1)+round(length(index)/2),max(y(index)),txt1)
                
                %text(index(1)+round(length(index)/2),0,txt1)
            elseif label(i)==7
                index=start(i):endtime(i);
                plot(t(index),y(index), 'g');
                txt1 = 'F';
                text(index(1)+round(length(index)/2),max(y(index))+2,txt1)
                %text(index(1)+round(length(index)/2),max(y(index)),txt1)
                %text(index(1)+round(length(index)/2),0,txt1)
            elseif label(i)==8
                index=start(i):endtime(i);
                plot(t(index),y(index), 'm');
                txt1 = 'V';
                text(index(1)+round(length(index)/2),max(y(index))+2,txt1)
                %text(index(1)+round(length(index)/2),max(y(index)),txt1)
                %text(index(1)+round(length(index)/2),0,txt1)            
            elseif label(i)==-1
                index=start(i):endtime(i);
                plot(t(index),y(index), 'r');
                txt1 = 'U';
                text(index(1)+round(length(index)/2),max(y(index)),txt1)
                %text(index(1)+round(length(index)/2),0,txt1)
            end
        end
        title('N1 plots')
        xlabel('time') % x-axis label
        ylabel('percentage speed') % y-axis label
        hold off;        
        %saveas(h, fullfile('L:\PassOff_Data\ClassificationAlgorithm\XWB_n1_data\Labelled_plots\', sprintf('Labelled_XWB_ems_filtered_%d',k)),'png');
        saveas(h, fullfile('L:\PassOff_Data\ClassificationAlgorithm\XWB_n1_data\Labelled_plots\', sprintf('Labelled_XWB_collected_filtered_%d',k)),'png');

        end

