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


%% Condições iniciais do seguidor: lvlh

% x0_real = -0.04*a0;
% x0_real = -0.0112*a0; % inserir perturbação apenas no passo inicial
x0_real = -0.01127*a0; % inserir perturbação apenas no passo inicial

% x0_real = -0.03*a0;

x0_controle = -0.01127*a0; % referência

controle = false;

y0 = 0*a0;
z0 = 0.1*a0;

x_dot0 = 0.02*sqrt(mi/a0^3)*a0;
y_dot0 = 0.02*sqrt(mi/a0^3)*a0;
z_dot0 = 0*sqrt(mi/a0^3)*a0;

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
set_param(modelName, 'MaxStep', '0.01*T',"StopTime", string(Tsim)); 
simulacao = sim(modelName);

pos_lider_inercial = simulacao.dados_lider.Data(:,5:end);
pos_seguidor_inercial = simulacao.seguidor_dados.Data(:,10:end);
pos_seguidor_lvlh = simulacao.seguidor_dados.Data(:,1:3);
plotar_trajetorias_inercial(pos_lider_inercial, pos_seguidor_inercial)
plotar_trajetoria_lvlh(pos_seguidor_lvlh)
plotar_projecoes_lvlh(pos_seguidor_lvlh)

tempo_periodos = simulacao.seguidor_dados.Time / T;
plotar_historico_posicao(pos_seguidor_lvlh, tempo_periodos, "Posição do Seguidor no ref LVLH")

