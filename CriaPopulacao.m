function [ vetorAirfoil ] = CriaPopulacao( vetorPerfis, NumNos)
%Função que chama o XFOIL para criar os .dat dos perfis os quais quero
%otimizar
clc;
% NumNos = 50; %serão os genes
% %Inicializacao da populacao
% vetorPerfis =[
%     '0012'
%     '2212'
%     '1415'
%     '0008'
%     '2214'
%     '2415'
%     '1518'
%     '2314'
%     '2541'
%     '1212'
%     ];
% iniciar com 10 airfoils em seus arquivos
xf=XFOIL;
xf.KeepFiles = true; % Set it to true to keep all intermediate files created (Airfoil, Polars, ...)
xf.Visible = false;
for i = 1:length(vetorPerfis)
    if(str2double(vetorPerfis(i,:))<1e5)%comparaçao para verificar se é um NACA4 ou NACA5
        xf.Airfoil = Airfoil.createNACA4(vetorPerfis(i,:),NumNos);
        vetorAirfoil(i).Airfoil = xf.Airfoil;
    elseif(str2double(vetorPerfis(i,:))>=1e5)
        xf.Airfoil = Airfoil.createNACA5(vetorPerfis(i,:),NumNos);
        vetorAirfoil(i).Airfoil = xf.Airfoil;
    else
        disp('falha ao criar o aerofolio:'); 
        disp(vetorPerfis(i,:));
    end
end

disp('Os aerofolios pedidos foram criados');
end

