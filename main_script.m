%% Condições iniciais do satélite líder: ref inercial

clear 
clc

mi = 3.986004418e14;  % [m^3/s^2, Terra]
a0 = 8e6; % Semieixo maior (m)
e0 = 0.1;  % Exentricity
w0 = 0; % Argumento do pericentro
f0 = 0; % Anomalia verdadeira inicial
i = 0; % Inclinação
Omega = 0; % nodo ascendente
    

% mi = 3.986004418e14;  % [m^3/s^2, Terra]
% a0 = 6978e3; % Semieixo maior (m)
% e0 = 0;  % Excentricidade
% w0 = 0; % Argumento do pericentro
% f0 = 0; % Anomalia verdadeira inicial
% i = 0; % Inclinação
% Omega = 0; % nodo ascendente

%% Parâmetros de controle
lambdax = 1/(1e2);
lambday = 1/(1e2);
lambdaz = 1/(1e2);
kx = 400;
ky = 200;
kz = 200;
phix = 30; % Da ordem do erro inicial (um pouco maior): quando diminuí, parece que o erro de rastreamento foi diminuindo também ao longo do tempo
phiy = 30;
phiz = 30;

%% Condições iniciais do seguidor: lvlh


x0_real = -0.0113*a0; % inserir perturbação apenas no passo inicial
% x0_real = 0.01*a0; % inserir perturbação apenas no passo inicial



x0_controle = -0.01127*a0; % referência

controle = true;

y0 = 0*a0;
% y0 = 0.02*a0;

z0 = 0.1*a0;
% z0 = 0.015*a0;

x_dot0 = 0.02*sqrt(mi/a0^3)*a0;
% x_dot0 = 0.001*sqrt(mi/a0^3)*a0;

y_dot0 = 0.02*sqrt(mi/a0^3)*a0;
% y_dot0 = -0.02*sqrt(mi/a0^3)*a0;

z_dot0 = 0*sqrt(mi/a0^3)*a0;
% z_dot0 = 0.002*sqrt(mi/a0^3)*a0;

% x0_real = 0*a0; % inserir perturbação apenas no passo inicial
% 
% %x0_controle = -0.01127*a0; % referência
% 
% controle = false;
% 
% y0 = 0.02*a0;
% z0 = 0.015*a0;
% 
% x_dot0 = 0.015*sqrt(mi/a0^3)*a0;
% y_dot0 = -0.02*sqrt(mi/a0^3)*a0;
% z_dot0 = 0*sqrt(mi/a0^3)*a0;

%% Simulação
T = 2*pi*sqrt(a0^3/mi); % Período de órbita do líder
Tsim = 1*T;
modelName = "dinamica_formacao_voo";
load_system(modelName);
set_param(modelName, 'MaxStep', '0.001*T',"StopTime", string(Tsim),'Solver', 'ode15s'); 
simulacao = sim(modelName);
tempo_periodos = simulacao.seguidor_dados.Time / T;


pos_lider_inercial = simulacao.dados_lider.Data(:,5:end);
pos_seguidor_inercial = simulacao.seguidor_dados.Data(:,10:end);
pos_seguidor_lvlh = simulacao.seguidor_dados.Data(:,1:3);
pos_seguidor_lvlh_cw = simulacao.seguidor_dados_cw.Data(:,3:end);
pos_seguidor_inercial_cw = simulacao.seguidor_dados_cw.Data(:,1:3);
pos_seguidor_lvlh_guiamento = simulacao.dados_guiamento_lvlh.Data(:,1:3);
u_controle_hist = simulacao.controle.Data;
s_hist = simulacao.sliding_surface.Data;


plotar_trajetorias_inercial(pos_lider_inercial, pos_seguidor_inercial)
plotar_trajetoria_lvlh(pos_seguidor_lvlh)
plotar_historico_posicao(pos_seguidor_lvlh, tempo_periodos, "Posição do Seguidor no ref LVLH")
plotar_erro_de_guiamento(pos_seguidor_lvlh, pos_seguidor_lvlh_guiamento, tempo_periodos,"Erro de guiamento (lvlh)")
plotar_historico_posicao(pos_seguidor_lvlh_guiamento, tempo_periodos, "Posição de guiamento do Seguidor (lvlh)")
plotar_trajetoria_lvlh(pos_seguidor_lvlh_guiamento)
plotar_historico_controle(u_controle_hist, "Controle ao longo do tempo", tempo_periodos)
plotar_superficie_deslizamento(s_hist, "Superfícies de deslizamento", tempo_periodos, 'Phi',[phix,phiy,phiz])

% plotar_trajetorias_inercial(pos_lider_inercial,pos_seguidor_inercial_cw)
% plotar_trajetoria_lvlh(pos_seguidor_lvlh_cw)
% plotar_historico_posicao(pos_seguidor_lvlh_cw, tempo_periodos, "Posição do Seguidor no ref LVLH: eq. linearizadas")




