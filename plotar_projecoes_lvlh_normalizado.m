function plotar_projecoes_lvlh_normalizado(trajetoria_seguidor_lvlh, a0)
% plotar_projecoes_lvlh_normalizado: Plota a trajetória 3D de uma espaçonave 
% seguidora e suas projeções 2D, com coordenadas normalizadas pelo 
% semieixo maior a₀.
%
% ENTRADAS:
%   trajetoria_seguidor_lvlh - Matriz Nx3 com os dados de posição relativa 
%                              [x, y, z] do seguidor no referencial LVLH,
%                              em unidades absolutas (ex: km).
%   a0                       - Escalar. O semieixo maior da órbita do líder,
%                              na mesma unidade da trajetória (ex: km).
%

% --- 1. Normalização dos Dados ---
% Divide todos os dados de posição pelo semieixo maior a0.
trajetoria_normalizada = trajetoria_seguidor_lvlh / a0;

% --- 2. Configuração da Figura e Extração de Dados ---
figure('Position', [100, 100, 900, 700]);
x_s = trajetoria_normalizada(:, 1);
y_s = trajetoria_normalizada(:, 2);
z_s = trajetoria_normalizada(:, 3);

% --- 3. Plot das Projeções 2D Normalizadas ---

% Subplot 1: Projeção no Plano XY (Orbital)
subplot(2, 2, 1);
plot(x_s, y_s, 'k-', 'LineWidth', 1.5);
title('Projeção no Plano XY (Orbital)');
xlabel('x/a_0 (Radial)'); % Rótulo atualizado
ylabel('y/a_0 (Along-track)'); % Rótulo atualizado
grid on;
axis equal;

% Subplot 2: Projeção no Plano XZ
subplot(2, 2, 2);
plot(x_s, z_s, 'k-', 'LineWidth', 1.5);
title('Projeção no Plano XZ');
xlabel('x/a_0 (Radial)'); % Rótulo atualizado
ylabel('z/a_0 (Cross-track)'); % Rótulo atualizado
grid on;
axis equal;

% Subplot 3: Projeção no Plano YZ
subplot(2, 2, 3);
plot(y_s, z_s, 'k-', 'LineWidth', 1.5);
title('Projeção no Plano YZ');
xlabel('y/a_0 (Along-track)'); % Rótulo atualizado
ylabel('z/a_0 (Cross-track)'); % Rótulo atualizado
grid on;
axis equal;

% --- 4. Plot da Visão 3D Normalizada com Legendas ---

% Subplot 4: Visão 3D Completa
subplot(2, 2, 4);
hold on; 

% Plota a trajetória 3D do seguidor
h_seguidor = plot3(x_s, y_s, z_s, 'k-', 'LineWidth', 1.5);
% Plota a posição do líder na origem
h_lider = plot3(0, 0, 0, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
% Destaca os pontos de início e fim do seguidor
h_inicio = plot3(x_s(1), y_s(1), z_s(1), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
h_fim = plot3(x_s(end), y_s(end), z_s(end), 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

% Finaliza o gráfico 3D
title('Visão 3D da Trajetória Relativa');
xlabel('x/a_0 (Radial)'); % Rótulo atualizado
ylabel('y/a_0 (Along-track)'); % Rótulo atualizado
zlabel('z/a_0 (Cross-track)'); % Rótulo atualizado
legend([h_lider, h_seguidor, h_inicio, h_fim], ...
       'Líder (Origem)', 'Trajetória do Seguidor', 'Início', 'Fim', 'Location', 'northeast');
grid on;
axis equal;
box on;
view(45, 25);
hold off;

end