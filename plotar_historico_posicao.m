function plotar_historico_posicao(trajetoria_xyz, tempo_periodos, titulo)
% plotar_historico_posicao: Plota o histórico de tempo das componentes de
% posição (x, y, z) de uma espaçonave.
%
% A função cria uma figura com 3 subplots empilhados.
%
% ENTRADAS:
%   trajetoria_xyz   - Matriz Nx3 com os dados de posição [x, y, z].
%                      Cada linha representa um ponto no tempo.
%   tempo_periodos   - Vetor Nx1 com os instantes de tempo correspondentes,
%                      expressos em períodos orbitais.
%   tipo_nave        - String ('Líder' ou 'Seguidor') para customizar
%                      os títulos dos gráficos.
%

% --- 1. Configuração da Figura ---
figure; % Cria uma nova figura
sgtitle(titulo, 'FontSize', 16, 'FontWeight', 'bold');

% --- 2. Extração dos Dados ---
x_data = trajetoria_xyz(:, 1);
y_data = trajetoria_xyz(:, 2);
z_data = trajetoria_xyz(:, 3);

% --- 3. Plot do Subgráfico para a Componente X ---
subplot(3, 1, 1);
plot(tempo_periodos, x_data, 'b-', 'LineWidth', 1.5);
title('Componente X');
ylabel('Posição X [unidades]');
grid on;
box on;

% --- 4. Plot do Subgráfico para a Componente Y ---
subplot(3, 1, 2);
plot(tempo_periodos, y_data, 'g-', 'LineWidth', 1.5);
title('Componente Y');
ylabel('Posição Y [unidades]');
grid on;
box on;

% --- 5. Plot do Subgráfico para a Componente Z ---
subplot(3, 1, 3);
plot(tempo_periodos, z_data, 'r-', 'LineWidth', 1.5);
title('Componente Z');
xlabel('Tempo [Períodos Orbitais]');
ylabel('Posição Z [unidades]');
grid on;
box on;

end