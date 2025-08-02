function plotar_projecoes_lvlh(trajetoria_seguidor_lvlh)
% plotar_projecoes_lvlh: Plota a trajetória 3D de uma espaçonave seguidora
% e suas projeções 2D em um sistema de referência LVLH.
% O formato do gráfico é um grid 2x2, semelhante à Figura 5.3 do livro
% "Spacecraft Formation Flying" por Alfriend et al.
%
% ENTRADAS:
%   trajetoria_seguidor_lvlh - Matriz Nx3 com os dados de posição relativa
%                              [x, y, z] do seguidor no referencial LVLH.
%

% --- 1. Configuração da Figura e Extração de Dados ---
figure('Position', [100, 100, 900, 700]); % Cria uma nova figura com um bom tamanho
x_s = trajetoria_seguidor_lvlh(:, 1);
y_s = trajetoria_seguidor_lvlh(:, 2);
z_s = trajetoria_seguidor_lvlh(:, 3);

% --- 2. Plot das Projeções 2D ---

% Subplot 1: Projeção no Plano XY (Plano Orbital)
subplot(2, 2, 1);
plot(x_s, y_s, 'k-', 'LineWidth', 1.5);
title('Projeção no Plano XY (Orbital)');
xlabel('X');
ylabel('Y');
grid on;
axis equal;

% Subplot 2: Projeção no Plano XZ
subplot(2, 2, 2);
plot(x_s, z_s, 'k-', 'LineWidth', 1.5);
title('Projeção no Plano XZ');
xlabel('X');
ylabel('Z');
grid on;
axis equal;

% Subplot 3: Projeção no Plano YZ
subplot(2, 2, 3);
plot(y_s, z_s, 'k-', 'LineWidth', 1.5);
title('Projeção no Plano YZ');
xlabel('Y');
ylabel('Z');
grid on;
axis equal;

% --- 3. Plot da Visão 3D com Legendas ---

% Subplot 4: Visão 3D Completa
subplot(2, 2, 4);
hold on; % Habilita o hold apenas para este subplot

% Plota a trajetória 3D do seguidor
h_seguidor = plot3(x_s, y_s, z_s, 'k-', 'LineWidth', 1.5);

% Plota a posição do líder na origem
h_lider = plot3(0, 0, 0, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);

% Destaca os pontos de início e fim do seguidor
h_inicio = plot3(x_s(1), y_s(1), z_s(1), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
h_fim = plot3(x_s(end), y_s(end), z_s(end), 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 8);

% Finaliza o gráfico 3D
title('Visão 3D da Trajetória Relativa');
xlabel('X (Radial)');
ylabel('Y (Along-track)');
zlabel('Z (Cross-track)');
legend([h_lider, h_seguidor, h_inicio, h_fim], ...
       'Líder (Origem)', 'Trajetória do Seguidor', 'Início', 'Fim', 'Location', 'northeast');
grid on;
axis equal;
box on;
view(45, 25); % Ajusta o ângulo de visão 3D
hold off;

end