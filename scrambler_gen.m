clear;
clc;
%************* Setup Parameters **************
cd '/media/yaroslav/WDRed/matlab/source/scrambler_gen/'; % project path
foldername_0 = 'matlab_gen';
foldername_1 = 'verilog_gen';
foldername_2 = 'test_result';
verilog_modulename = 'scrambler';
gen_input_data = 'true';
disp_clc_poly = 'false';
scrambler_test = 'true';
draw_graphics = 'true';
test_iterations = 31;
%*********************************************

%*********** Scrambler Parameters ************
% Bus width no less than 16 bit and multiple 16. Bus width = p^m
p = 2;
m = 6;
Gx = 'x^16+x^15+x^13+x^4+1'; % x^16+x^15+x^13+x^4+1
init_key = 'F0F6'; % F0F6
poly_0 = 'x^16'; % degree of generator polynomial
%*********************************************

if exist(foldername_0, 'dir')
    rmdir(foldername_0, 's');
end
mkdir(foldername_0);
if exist(foldername_1, 'dir')
    rmdir(foldername_1, 's');
end
mkdir(foldername_1);

% *************** Remainders finder *****************
for i = 0:1:p^m-1
    poly_1 = gfrepcov(i);
    qx = gfconv(poly_0, poly_1, p);
    [q_s, Fx] = gfdeconv(qx, Gx, p);
    fileID_0 = fopen(sprintf('%s/bit_%d.txt', foldername_0, i), 'w');
    fprintf(fileID_0, '%s\n', string(Fx));
    fclose(fileID_0);
    if (string(disp_clc_poly) == "true")
        fprintf('[%d]\n', i);
        gfpretty(Fx);
    end
end
% ***************************************************

% ************* Verilog builder ********************* 
fileID_1 = fopen(sprintf('%s/%s.v', foldername_1, verilog_modulename), 'w');
fprintf(fileID_1, '`timescale 1ns / 1ps\n\n');
fprintf(fileID_1, 'module %s(\n\tinput\t[%d:0]\tdin,\n\toutput\t[%d:0]\tdout,\n\tinput\t\ten,\n\n\tinput\t\tresetn,\n\tinput\t\tclk\n\t);\n\n', verilog_modulename, p^m-1, p^m-1);
fprintf(fileID_1, '\treg\t[15:0]\tctx;\n\twire\t[%d:0]\tctx_next;\n\n\tassign dout = ctx_next^din;\n\n', p^m-1);
fprintf(fileID_1, '\talways@(posedge clk) begin\n\t\tif (resetn == 0) ctx <= 16''h%s;\n\t\telse begin\n\t\t\tif (en) ctx <= ctx_next[%d:%d];\n\t\tend\n\tend\n\n', init_key, p^m-1, (p^m-1)-15);

for i = p^m-1:-1:0
    fprintf(fileID_1, '\tassign ctx_next[%d] = ', i);
    fileID_0 = fopen(sprintf('%s/bit_%d.txt', foldername_0, i), 'r');
    rd_str = fscanf(fileID_0, '%s');
    first_arg = true;
    for j = length(rd_str):-1:1
        if rd_str(j) == '1'
            if first_arg
                fprintf(fileID_1, 'ctx[%s]', string(j-1));
                first_arg = false;
            else
                fprintf(fileID_1, ' ^ ctx[%s]', string(j-1));
            end
        end
    end
    fprintf(fileID_1, ';\n');
    fclose(fileID_0);
end

fprintf(fileID_1, '\nendmodule\n');
fclose(fileID_1);
% ***************************************************

% ***************** Test Script *********************
if (string(scrambler_test) == "true")
    if (string(gen_input_data) == "true")
        if exist(foldername_2, 'dir')
            rmdir(foldername_2, 's');
        end
        mkdir(foldername_2);
        fileID_0 = fopen(sprintf('%s/input_data.txt', foldername_2), 'w');
        for i = 0:1:test_iterations
            for j = 1:1:p^m/16
                fprintf(fileID_0, 'FFFF');
            end
            fprintf(fileID_0, '\n');
        end
        fclose(fileID_0);
    end

    for i = 0:1:(p^m/16)-1
        my_field = strcat('M', num2str(i));
        M.(my_field) = zeros(16, 16);
    end
    for i = 0:1:p^m-1
        [q_s, rem] = gfdeconv(gfconv(gfrepcov(i), poly_0, p), Gx, p); % calculate remainders
        my_field = strcat('M', num2str(fix((p^m-1-i)/16)));
        for j = 1:1:length(rem)
            M.(my_field)(1+i-(fix(i/16)*16),j) = rem(j); % create matrix(s)
        end
    end
    
    fileID_0 = fopen(sprintf('%s/input_data.txt', foldername_2), 'r');  % this is INPUT(!) file
    fileID_1 = fopen(sprintf('%s/output_data.txt', foldername_2), 'w'); % this is OUTPUT(!) file
    din = fscanf(fileID_0, '%s'); % read input data
    Sx = zeros(1,16);
    scr = zeros((p^m)/16, 16);
    dout = zeros(1, p^m);
    scr_tmp = hex2poly(init_key, 'ascending'); % add first stage value to scrambler's 'REGISTER'
    for i = 1:1:length(scr_tmp)
        scr(1, i) = scr_tmp(i);
    end
    for i = 0:1:test_iterations   %i'ts data iterations
        Rx = scr(1,:);
        Tx = M.M0*(Rx.'); % 'REGISTER VALUE * MATRIX[0]'
        for k = 1:1:16
            Tx(k) = mod(Tx(k), 2); % we are still in the Galois field ;)
        end
        Tx = Tx.';
        scr(1,:) = Tx;
        for k = 1:1:16
            dout(17-k) = Tx(k);
        end
        if m > 4
            for j = 1:1:(p^m/16)-1
                my_field = strcat('M', num2str(j));
                Tx = M.(my_field)*(Rx.'); % 'REGISTER VALUE * MATRIX[n]'
                for k = 1:1:16
                    Tx(k) = mod(Tx(k), 2);
                end
                Tx = Tx.';
                scr(j+1,:) = Tx;
                for k = 1:1:16
                    dout(((16*(j+1))+1)-k) = Tx(k);
                end
            end
        end
        
        data_in = din(i*(p^m/4)+1:i*(p^m/4)+(p^m/4));
        poly_tmp = hex2poly(data_in, 'descending');
        poly_in = zeros(1, p^m);
        for k = 1:1:length(poly_tmp)
            poly_in(k+(p^m-length(poly_tmp))) = poly_tmp(k);
        end
        dout = bitxor(poly_in, dout); % xor 'INPUT DATA' with 'REGISTER VALUE * MATRIX'
        % ---- partial write for correct write value 64bit and more -------
        dout_f = zeros(ceil(p^m/32), (p^m/ceil(p^m/32)));
        for j = 1:1:ceil(p^m/32)
            for k = 1:1:(p^m/ceil(p^m/32))
                dout_f(j, k) = dout(k+((j-1)*(p^m/ceil(p^m/32))));
            end
            fprintf(fileID_1, '%s', dec2hex(bin2dec(erase(num2str(dout_f(j,:)), ' ')), (p^m/ceil(p^m/32))/4));
        end
        fprintf(fileID_1, '\n');
        % ----------------------- end partial write -----------------------
    end
    fclose(fileID_0);
    fclose(fileID_1);

end
% ****************************************************

% ***************** Draw graphics ********************
if (string(draw_graphics) == "true")
    fileID_0 = fopen(sprintf('%s/output_data.txt', foldername_2), 'r');
    data_str = fscanf(fileID_0, '%s');
    fclose(fileID_0);
    data_rd = hex2poly(data_str, 'descending');
    f = figure('Name','Distribution','NumberTitle','off');
    f.Position(1:4) = [1000, 500, 600, 500];
    histfit(data_rd, 2, 'normal')
    grid on
end
% ****************************************************











