function[label, Adash]=Basis_Scoring_n1(w, mean, startman, endman, prevlabel)


addpath('fdaM')
load('FPCA_for_VibrationSurvey_n1','vibration');
vibration_mu=vibration.mu;
vibration_eig1=vibration.eig1;
vibration_eig2=vibration.eig2;
vibration_eig3=vibration.eig3;
vibration_eig4=vibration.eig4;

load('FPCA_for_FastAcc_n1','fast');
fast_mu=fast.mu;
fast_eig1=fast.eig1;
fast_eig2=fast.eig2;
fast_eig3=fast.eig3;
fast_eig4=fast.eig4;

%Models associated to the labels
model0=[0]; %engine stopped
model1=[27]; %idle speed
model2=[51]; 
model3=[86;80;66;52];
model4=[86;28;86]; %performance curve
model5=[96;90;86;79;72;60;51;38;27]; 
model6=[86;28;86;96;90;86;79;72;60;51;38;27];

%model9 is the fast acc/dec
%model10 is the vibration survey

%We need to determine if a maneouvre is a vibration survey or fast acc/dec
%Regularise time series
        y=w(startman:endman);       
        
        nlen=length(y);
        dailytime = linspace(0.5, nlen-0.5, nlen)';  %  mid points of months
        knots = dailytime;
        norder   = 4;
        nbasis   = 201;
        dist=4096;
        %fprintf('length of data %d\n',n);
        %fprintf('start %d\n',startman);
        %fprintf('end %d\n',endman);

        fbasis = create_bspline_basis([0.5, nlen-0.5],nbasis,norder);

        %smoothing the data
        agefine=linspace(1,nlen-1,dist);
        argvals = (1:nlen)-0.5;
        fdParobj = fdPar(fbasis,int2Lfd(2),0); %Applies smoothness
        tempSmooth =  smooth_basis(argvals,y,fdParobj);
        timeseries=eval_fd(agefine,tempSmooth); 
        
        [recy, sq_error, vib_msq_error]=Reconstruct_n1(timeseries,vibration_mu,vibration_eig1,vibration_eig2,vibration_eig3,vibration_eig4);
        [fast_recy, fast_sq_error, fast_msq_error]=Reconstruct_n1(timeseries,fast_mu,fast_eig1,fast_eig2,fast_eig3,fast_eig4);
                    %{
                    h=figure();            
                    plot(timeseries);
                    hold on
                    plot(recy, 'r')
                    hold on;
                    plot(fast_recy, 'm');
                    hold off;
                    %}
                        %Take the maneouvre and use NW to assign the label    
                        [~, n, ~, ~]=template_Needleman(model1,mean);
                        n1=n;
                        [~, n, ~, ~]=template_Needleman(model2,mean);
                        n2=n;
                        [~, n, ~, ~]=template_Needleman(model3,mean);
                        n3=n;
                        [~, n, ~, ~]=template_Needleman(model4,mean);
                        n4=n;
                        [~, n, ~, ~]=template_Needleman(model5,mean);
                        n5=n;
                        [~, n, ~, ~]=template_Needleman(model6,mean);
                        n6=n;
                        A=[n1 n2 n3 n4 n5 n6];
                       
                        maxvalue=max(y);
                        % A is the vector of features we put into the
                        % decision tree
                        Adash=[n1 n2 n3 n4 n5 n6 fast_msq_error, vib_msq_error nlen maxvalue prevlabel];
                        
                        %The decision tree gives the labels
                        label=Decision_Tree_n1(Adash);
                        %fprintf('%i\n', A);  
                        %fprintf('label found\n');
end