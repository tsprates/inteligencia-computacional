% Inteligência Computacional
% Trabalho Prático 1 - Exercício 1 e 2
% Author: Thiago Silva Prates
function [wInicial, wFinal]=exec1()
    clear all;
    clc;

    file = importdata('dados.txt', ' ');
    data = file.data;
    
    % learning rate
    ni = 0.01;
    
    numRows = size(data, 1);
    numCols = size(data, 2);
    
    bias = -1;

    maxEpocas = 10;    
    err = numRows;

    w = rand(1, numCols);
    wInicial = w;
    
    iter = 0;
    
    while err == 0 || iter < maxEpocas
        err = numRows;
        
        for row=1:numRows
            % activation function
            y = w(1:numCols-1) .* data(row, 1:numCols-1);
            y = sum(y) + bias * w(1:numCols);
            
            if y < 1
                y = 0;
            else
                y = 1;
            end
            
            % fixing weights
            expected = data(row, numCols);
            if expected ~= y
                err = err - 1;
                d = expected-y;
                
                w(1, 1:numCols-1) = w(1, 1:numCols-1) + (ni*d).*data(row, 1:numCols-1);
                w(1, numCols) = w(1, numCols) + ni*d*bias;
            end
        end
        
        iter=iter + 1;
        
        % boundary line
        [X,Y] = meshgrid(-3:3);
        Z = -(w(4)*bias + w(1)*X + w(2)*Y)/w(3); 
        surf(X, Y, Z, 'FaceColor','red', 'EdgeColor', 'none');
        alpha(.4);
                
        hold on;
        
        % class 0
        lastColEquals0 = data(:,4) == 0;
        plot3(data(lastColEquals0, 1), data(lastColEquals0, 2), data(lastColEquals0,3), 'r*');
        
        hold on;
        
        % class 1
        lastColEquals1 = data(:,4) == 1;
        plot3(data(lastColEquals1, 1), data(lastColEquals1, 2), data(lastColEquals1, 3), 'bo');
        
        grid on;
        title('Tabalho de Inteligencia Computacional');
        xlabel('Eixo X'); 
        ylabel('Eixo Y'); 
        zlabel('Eixo Z');
        
        pause;
        close;   
    end
    
    wFinal = w;
end
