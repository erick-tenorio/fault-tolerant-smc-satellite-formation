function plotar_trajetoria_lvlh(trajetoria_seguidor_lvlh)
% plotar_trajetoria_lvlh: Plota a trajetória 3D de uma espaçonave seguidora
% em relação a um líder, no sistema de referência LVLH do líder.
%
% ENTRADAS:
%   trajetoria_seguidor_lvlh - Matriz Nx3 com os dados de posição relativa 
%                              [x, y, z] do seguidor no referencial LVLH.
%                              Cada linha representa um ponto no tempo.
%

% --- 1. Configuração do Gráfico ---
figure;      % Cria uma nova figura
hold on;     % Permite plotar múltiplos elementos no mesmo gráfico
view(45, 30); % Define um ângulo de visualização 3D

% --- 2. Extração dos Dados da Trajetória do Seguidor ---
x_s = trajetoria_seguidor_lvlh(:, 1);
y_s = trajetoria_seguidor_lvlh(:, 2);
z_s = trajetoria_seguidor_lvlh(:, 3);

% --- 3. Plot dos Elementos ---
% Plota a posição do líder (sempre na origem do referencial LVLH)
h_lider = plot3(0, 0, 0, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);

% Plota a trajetória do seguidor
h_seguidor = plot3(x_s, y_s, z_s, 'm-', 'LineWidth', 1);

% Destaca os pontos de início e fim do seguidor
h_inicio = plot3(x_s(1), y_s(1), z_s(1), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
h_fim = plot3(x_s(end), y_s(end), z_s(end), 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

% --- 4. Destaque do Referencial LVLH ---
% Determina a escala dos eixos para o desenho
max_abs_val = max(abs(trajetoria_seguidor_lvlh(:)));
if max_abs_val == 0, max_abs_val = 1; end % Evita erro se a trajetória for nula
axis_len = max_abs_val * 0.7; % Comprimento dos eixos

% Eixo X (Vermelho) - Direção Radial
plot3([0, axis_len], [0, 0], [0, 0], 'r', 'LineWidth', 1);
text(axis_len, 0, 0, ' X (Radial)', 'FontSize', 12, 'Color', 'r');

% Eixo Y (Verde) - Direção Ao Longo da Trajetória (Along-track)
plot3([0, 0], [0, axis_len], [0, 0], 'g', 'LineWidth', 1);
text(0, axis_len, 0, ' Y (Along-track)', 'FontSize', 12, 'Color', 'g');

% Eixo Z (Azul) - Direção Normal à Órbita (Cross-track)
plot3([0, 0], [0, 0], [0, axis_len], 'b', 'LineWidth', 1);
text(0, 0, axis_len, ' Z (Cross-track)', 'FontSize', 12, 'Color', 'b');

% --- 5. Finalização do Gráfico ---
title('Trajetória 3D Relativa no Referencial LVLH', 'FontSize', 16);
xlabel('Eixo X (Radial) [km]', 'FontSize', 12);
ylabel('Eixo Y (Along-track) [m]', 'FontSize', 12);
zlabel('Eixo Z (Cross-track) [m]', 'FontSize', 12);
legend([h_lider, h_seguidor, h_inicio, h_fim], ...
       'Líder (Origem)', 'Trajetória do Seguidor', 'Início do Seguidor', 'Fim do Seguidor');
grid on;
axis equal; % Essencial para visualizar a forma real da órbita relativa
box on;
hold off;

end