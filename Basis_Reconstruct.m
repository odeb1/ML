%% Reconstruction function
%data y, mean mu, eigenvectors eig1,...,eig4
%output reconstructed time series y, square error and mean square error
function[recy, sq_error]=Basis_Reconstruct(y, mu,eig1,eig2,eig3,eig4)

addpath('fdaM')

    % Fit basis
    n=length(y);
    if n==0
        fprintf('issue')
    end
    dailytime = linspace(0, 1, n)'; 
    nbasis   = 201;
    fbasis = create_fourier_basis([0,1], nbasis);
    fdParobj = fdPar(fbasis,int2Lfd(2),0); %Applies smoothness
    tempSmooth =  smooth_basis(dailytime,y,fdParobj);
    % Get coefficients
    coefy=getcoef(tempSmooth);
    % Calculate reconstruction
    tty=fd(coefy,fbasis);
    mcorrect=tty-mu;
    score1=inprod(mcorrect,eig1);
    score2=inprod(mcorrect,eig2);
    score3=inprod(mcorrect,eig3);
    score4=inprod(mcorrect,eig4);
    recy=mu+times(score1,eig1)+times(score2,eig2)+times(score3,eig3)+times(score4,eig4);
    sq_error=inprod(tty,recy);
end