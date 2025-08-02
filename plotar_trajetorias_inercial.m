function plotar_trajetorias_inercial(trajetoria_lider, trajetoria_seguidor)
% plotar_trajetorias_inercial: Plota as trajetórias 3D de duas espaçonaves
% (líder e seguidor) em um sistema de referência inercial.
%
% ENTRADAS:
%   trajetoria_lider   - Matriz Nx3 com os dados de posição [x, y, z] do líder.
%                        Cada linha representa um ponto no tempo.
%   trajetoria_seguidor - Matriz Nx3 com os dados de posição [x, y, z] do seguidor.
%

% --- 1. Configuração do Gráfico ---
figure;      % Cria uma nova figura
hold on;     % Permite plotar múltiplos elementos no mesmo gráfico
view(45, 30); % Define um ângulo de visualização 3D agradável

% --- 2. Extração dos Dados da Trajetória ---
x_lider = trajetoria_lider(:, 1);
y_lider = trajetoria_lider(:, 2);
z_lider = trajetoria_lider(:, 3);

x_seguidor = trajetoria_seguidor(:, 1);
y_seguidor = trajetoria_seguidor(:, 2);
z_seguidor = trajetoria_seguidor(:, 3);

% --- 3. Plot das Trajetórias ---
% Plota a trajetória completa do líder e do seguidor
h_lider = plot3(x_lider, y_lider, z_lider, 'b-', 'LineWidth', 1);
h_seguidor = plot3(x_seguidor, y_seguidor, z_seguidor, 'm--', 'LineWidth', 1);

% --- ALTERAÇÃO AQUI: Marcadores distintos para cada espaçonave ---
% Ponto de início do Líder (Círculo Azul)
h_inicio_lider = plot3(x_lider(1), y_lider(1), z_lider(1), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
% Ponto de início do Seguidor (Círculo Magenta)
h_inicio_seguidor = plot3(x_seguidor(1), y_seguidor(1), z_seguidor(1), 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 8);

% Ponto de fim do Líder (Quadrado Azul)
h_fim_lider = plot3(x_lider(end), y_lider(end), z_lider(end), 'bs', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
% Ponto de fim do Seguidor (Quadrado Magenta)
h_fim_seguidor = plot3(x_seguidor(end), y_seguidor(end), z_seguidor(end), 'ms', 'MarkerFaceColor', 'm', 'MarkerSize', 8);
% --- FIM DA ALTERAÇÃO ---

% --- 4. Destaque do Referencial Inercial ---
% Determina a escala dos eixos para o desenho
max_abs_val = max(abs([trajetoria_lider(:); trajetoria_seguidor(:)]));
axis_len = max_abs_val * 0.5; % Comprimento dos eixos será 50% do valor máximo

% Eixo X (Vermelho)
plot3([0, axis_len], [0, 0], [0, 0], 'r', 'LineWidth', 2);
text(axis_len, 0, 0, 'X_{Inercial}', 'FontSize', 12, 'Color', 'r');
% Eixo Y (Verde)
plot3([0, 0], [0, axis_len], [0, 0], 'g', 'LineWidth', 2);
text(0, axis_len, 0, 'Y_{Inercial}', 'FontSize', 12, 'Color', 'g');
% Eixo Z (Azul)
plot3([0, 0], [0, 0], [0, axis_len], 'b', 'LineWidth', 2);
text(0, 0, axis_len, 'Z_{Inercial}', 'FontSize', 12, 'Color', 'b');


% --- 5. Finalização do Gráfico ---
title('Trajetória 3D no Referencial Inercial', 'FontSize', 16);
xlabel('Eixo X [unidades]', 'FontSize', 12);
ylabel('Eixo Y [unidades]', 'FontSize', 12);
zlabel('Eixo Z [unidades]', 'FontSize', 12);

% --- ALTERAÇÃO AQUI: Legenda atualizada ---
legend([h_lider, h_seguidor, h_inicio_lider, h_fim_lider, h_inicio_seguidor, h_fim_seguidor], ...
       'Trajetória do Líder', 'Trajetória do Seguidor', ...
       'Início do Líder', 'Fim do Líder', ...
       'Início do Seguidor', 'Fim do Seguidor', 'Location', 'best');
% --- FIM DA ALTERAÇÃO ---

grid on;      % Adiciona uma grade
axis equal;   % Garante que as escalas dos eixos sejam as mesmas para evitar distorção
box on;       % Desenha uma caixa ao redor do gráfico
hold off;     % Libera o gráfico para novos plots
end