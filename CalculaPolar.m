function [ glide ] = CalculaPolar( alfa, perfil, nos, Re, M)
%CalculaPolar função que calculará a eficiencia do perfil para um dado alfa
%  Essa funcao recebe parametros do aerofolio

%malha:
NumNos = nos;
if perfil ~=' '
    NACA = perfil;
else
    NACA = '4412';
end
%Armazenamento
savePolar = 'Polar.txt';

alpha0=alfa-2;
dalpha=0.5;
alphaf=alfa +2;
alfas = alpha0:dalpha:alphaf;
n_alpha=4;
ALFA_INTERESSE = alfa;

%parte de definição do xfoil:
xf=XFOIL;
pplot = true;
xf.KeepFiles = false; % Set it to true to keep all intermediate files created (Airfoil, Polars, ...)
xf.Visible = false;    % Set it to false to hide XFOIL plotting window
xf.Airfoil =  Airfoil.createNACA4(NACA,NumNos);
xf.addFiltering(20);
xf.addOperation(Re, M);
xf.addIter(250);
xf.addAlpha(alpha0,true);
xf.addPolarFile(savePolar);
xf.addAlpha(alfas);
xf.addClosePolarFile;
xf.addQuit;
xf.run
disp('Running XFOIL, please wait...');

%Wait up to 100 seconds for it to finish... 
%It is possible to run more than one XFOIL instance at the same time
finished = xf.wait(100);

if finished
    disp('XFOIL analysis finished.');
    xf.readPolars;
else
    xf.kill;
end

if size(xf.Polars,1)~=0
    nacaMatrix=[xf.Polars{1,1}.Alpha,xf.Polars{1,1}.CL,xf.Polars{1,1}.CD,xf.Polars{1,1}.CM];
    polar.cl(:,1)= nacaMatrix(:,1);
    polar.cd(:,1)= nacaMatrix(:,1);
    polar.cm(:,1)= nacaMatrix(:,1);
    polar.glide(:,1) = nacaMatrix(:,1);
    polar.cl(:,2) = nacaMatrix(:,2);
    polar.cd(:,2) = nacaMatrix(:,3);
    polar.cm(:,2) = nacaMatrix(:,4);
    polar.glide(:,2) = polar.cl(:,2)./polar.cd(:,2);
end

% plot
% figure(1);
% plot(polar.cl(:,1), polar.cl(:,2),'b');
% title('Lift coef');
% figure(2);
% plot(polar.cd(:,1), polar.cd(:,2),'r');
% title('Drag coef');
% figure(3);
% plot(polar.glide(:,1), polar.glide(:,2),'g');
% title('Glide Ratio');

for(i =1:length(polar.glide(:,1)))
    if(ALFA_INTERESSE == polar.glide(i,1))
        glide = polar.glide(i,2);
        break;
    end
end

end


