%-------------------------------------------------------------------------%
% cycle_2_init_contrast(0.6)

beta_arr = 1e-3 : 1e-3 : 1;
length = size(beta_arr);

init_contrast_arr = zeros(length(2), 1);
for i = 1 : length(2)
    init_contrast_arr(i, 1) = cycle_2_init_contrast(beta_arr(i));
end

plot(beta_arr, init_contrast_arr, 'LineWidth', 2)
xlabel('\beta');
ylabel('init contrast');

max_contrast = max(init_contrast_arr);

save('init_contrast_data.mat');

function contrast = cycle_2_init_contrast(beta_in)
    %----------------------------------------------------------------------
    % Parameters and equations
    K0 = zeros(7,7);

    beta = 0;
    k0_r = 63;
    k0_47 = 13;
    k0_57 = 80;
    k0_71 = 3.5;
    k0_72 = 2.2;
    K0(1,4) = beta*k0_r;
    K0(2,5) = beta*k0_r;
    K0(3,6) = beta*k0_r;
    K0(4,1) = k0_r;
    K0(5,2) = k0_r;
    K0(6,3) = k0_r;
    K0(4,7) = k0_47;
    K0(5,7) = k0_57;
    K0(6,7) = k0_57;
    K0(7,1) = k0_71;
    K0(7,2) = k0_72;
    K0(7,3) = k0_72;

    K0_OFF = K0;   %K matrix when laser is off (/beta = 0)

    ode1_OFF = @(t, y) K0_OFF(1,1)*y(1) - K0_OFF(1,1)*y(1)...
                 + K0_OFF(2,1)*y(2) - K0_OFF(1,2)*y(1)...
                 + K0_OFF(3,1)*y(3) - K0_OFF(1,3)*y(1)...
                 + K0_OFF(4,1)*y(4) - K0_OFF(1,4)*y(1)...
                 + K0_OFF(5,1)*y(5) - K0_OFF(1,5)*y(1)...
                 + K0_OFF(6,1)*y(6) - K0_OFF(1,6)*y(1)...
                 + K0_OFF(7,1)*y(7) - K0_OFF(1,7)*y(1);

    ode2_OFF = @(t, y) K0_OFF(1,2)*y(1) - K0_OFF(2,1)*y(2)...
                 + K0_OFF(2,2)*y(2) - K0_OFF(2,2)*y(2)...
                 + K0_OFF(3,2)*y(3) - K0_OFF(2,3)*y(2)...
                 + K0_OFF(4,2)*y(4) - K0_OFF(2,4)*y(2)...
                 + K0_OFF(5,2)*y(5) - K0_OFF(2,5)*y(2)...
                 + K0_OFF(6,2)*y(6) - K0_OFF(2,6)*y(2)...
                 + K0_OFF(7,2)*y(7) - K0_OFF(2,7)*y(2);

    ode3_OFF = @(t, y) K0_OFF(1,3)*y(1) - K0_OFF(3,1)*y(3)...
                 + K0_OFF(2,3)*y(2) - K0_OFF(3,2)*y(3)...
                 + K0_OFF(3,3)*y(3) - K0_OFF(3,3)*y(3)...
                 + K0_OFF(4,3)*y(4) - K0_OFF(3,4)*y(3)...
                 + K0_OFF(5,3)*y(5) - K0_OFF(3,5)*y(3)...
                 + K0_OFF(6,3)*y(6) - K0_OFF(3,6)*y(3)...
                 + K0_OFF(7,3)*y(7) - K0_OFF(3,7)*y(3);

    ode4_OFF = @(t, y) K0_OFF(1,4)*y(1) - K0_OFF(4,1)*y(4)...
                 + K0_OFF(2,4)*y(2) - K0_OFF(4,2)*y(4)...
                 + K0_OFF(3,4)*y(3) - K0_OFF(4,3)*y(4)...
                 + K0_OFF(4,4)*y(4) - K0_OFF(4,4)*y(4)...
                 + K0_OFF(5,4)*y(5) - K0_OFF(4,5)*y(4)...
                 + K0_OFF(6,4)*y(6) - K0_OFF(4,6)*y(4)...
                 + K0_OFF(7,4)*y(7) - K0_OFF(4,7)*y(4);

    ode5_OFF = @(t, y) K0_OFF(1,5)*y(1) - K0_OFF(5,1)*y(5)...
                 + K0_OFF(2,5)*y(2) - K0_OFF(5,2)*y(5)...
                 + K0_OFF(3,5)*y(3) - K0_OFF(5,3)*y(5)...
                 + K0_OFF(4,5)*y(4) - K0_OFF(5,4)*y(5)...
                 + K0_OFF(5,5)*y(5) - K0_OFF(5,5)*y(5)...
                 + K0_OFF(6,5)*y(6) - K0_OFF(5,6)*y(5)...
                 + K0_OFF(7,5)*y(7) - K0_OFF(5,7)*y(5);

    ode6_OFF = @(t, y) K0_OFF(1,6)*y(1) - K0_OFF(6,1)*y(6)...
                 + K0_OFF(2,6)*y(2) - K0_OFF(6,2)*y(6)...
                 + K0_OFF(3,6)*y(3) - K0_OFF(6,3)*y(6)...
                 + K0_OFF(4,6)*y(4) - K0_OFF(6,4)*y(6)...
                 + K0_OFF(5,6)*y(5) - K0_OFF(6,5)*y(6)...
                 + K0_OFF(6,6)*y(6) - K0_OFF(6,6)*y(6)...
                 + K0_OFF(7,6)*y(7) - K0_OFF(6,7)*y(6);

    ode7_OFF = @(t, y) K0_OFF(1,7)*y(1) - K0_OFF(7,1)*y(7)...
                 + K0_OFF(2,7)*y(2) - K0_OFF(7,2)*y(7)...
                 + K0_OFF(3,7)*y(3) - K0_OFF(7,3)*y(7)...
                 + K0_OFF(4,7)*y(4) - K0_OFF(7,4)*y(7)...
                 + K0_OFF(5,7)*y(5) - K0_OFF(7,5)*y(7)...
                 + K0_OFF(6,7)*y(6) - K0_OFF(7,6)*y(7)...
                 + K0_OFF(7,7)*y(7) - K0_OFF(7,7)*y(7);

    odes_OFF = @(t, n) [ode1_OFF(t, n); ode2_OFF(t, n); ode3_OFF(t, n); 
        ode4_OFF(t, n); ode5_OFF(t, n); ode6_OFF(t, n); ode7_OFF(t, n)];
    %----------------------------------------------------------------------

    K0 = zeros(7,7);

    beta = beta_in;
    k0_r = 63;
    k0_47 = 13;
    k0_57 = 80;
    k0_71 = 3.5;
    k0_72 = 2.2;
    K0(1,4) = beta*k0_r;
    K0(2,5) = beta*k0_r;
    K0(3,6) = beta*k0_r;
    K0(4,1) = k0_r;
    K0(5,2) = k0_r;
    K0(6,3) = k0_r;
    K0(4,7) = k0_47;
    K0(5,7) = k0_57;
    K0(6,7) = k0_57;
    K0(7,1) = k0_71;
    K0(7,2) = k0_72;
    K0(7,3) = k0_72;

    K0_ON = K0;       %K matrix when laser is on (/beta = 0.3)

    ode1_ON = @(t, y) K0_ON(1,1)*y(1) - K0_ON(1,1)*y(1)...
                 + K0_ON(2,1)*y(2) - K0_ON(1,2)*y(1)...
                 + K0_ON(3,1)*y(3) - K0_ON(1,3)*y(1)...
                 + K0_ON(4,1)*y(4) - K0_ON(1,4)*y(1)...
                 + K0_ON(5,1)*y(5) - K0_ON(1,5)*y(1)...
                 + K0_ON(6,1)*y(6) - K0_ON(1,6)*y(1)...
                 + K0_ON(7,1)*y(7) - K0_ON(1,7)*y(1);

    ode2_ON = @(t, y) K0_ON(1,2)*y(1) - K0_ON(2,1)*y(2)...
                 + K0_ON(2,2)*y(2) - K0_ON(2,2)*y(2)...
                 + K0_ON(3,2)*y(3) - K0_ON(2,3)*y(2)...
                 + K0_ON(4,2)*y(4) - K0_ON(2,4)*y(2)...
                 + K0_ON(5,2)*y(5) - K0_ON(2,5)*y(2)...
                 + K0_ON(6,2)*y(6) - K0_ON(2,6)*y(2)...
                 + K0_ON(7,2)*y(7) - K0_ON(2,7)*y(2);

    ode3_ON = @(t, y) K0_ON(1,3)*y(1) - K0_ON(3,1)*y(3)...
                 + K0_ON(2,3)*y(2) - K0_ON(3,2)*y(3)...
                 + K0_ON(3,3)*y(3) - K0_ON(3,3)*y(3)...
                 + K0_ON(4,3)*y(4) - K0_ON(3,4)*y(3)...
                 + K0_ON(5,3)*y(5) - K0_ON(3,5)*y(3)...
                 + K0_ON(6,3)*y(6) - K0_ON(3,6)*y(3)...
                 + K0_ON(7,3)*y(7) - K0_ON(3,7)*y(3);

    ode4_ON = @(t, y) K0_ON(1,4)*y(1) - K0_ON(4,1)*y(4)...
                 + K0_ON(2,4)*y(2) - K0_ON(4,2)*y(4)...
                 + K0_ON(3,4)*y(3) - K0_ON(4,3)*y(4)...
                 + K0_ON(4,4)*y(4) - K0_ON(4,4)*y(4)...
                 + K0_ON(5,4)*y(5) - K0_ON(4,5)*y(4)...
                 + K0_ON(6,4)*y(6) - K0_ON(4,6)*y(4)...
                 + K0_ON(7,4)*y(7) - K0_ON(4,7)*y(4);

    ode5_ON = @(t, y) K0_ON(1,5)*y(1) - K0_ON(5,1)*y(5)...
                 + K0_ON(2,5)*y(2) - K0_ON(5,2)*y(5)...
                 + K0_ON(3,5)*y(3) - K0_ON(5,3)*y(5)...
                 + K0_ON(4,5)*y(4) - K0_ON(5,4)*y(5)...
                 + K0_ON(5,5)*y(5) - K0_ON(5,5)*y(5)...
                 + K0_ON(6,5)*y(6) - K0_ON(5,6)*y(5)...
                 + K0_ON(7,5)*y(7) - K0_ON(5,7)*y(5);

    ode6_ON = @(t, y) K0_ON(1,6)*y(1) - K0_ON(6,1)*y(6)...
                 + K0_ON(2,6)*y(2) - K0_ON(6,2)*y(6)...
                 + K0_ON(3,6)*y(3) - K0_ON(6,3)*y(6)...
                 + K0_ON(4,6)*y(4) - K0_ON(6,4)*y(6)...
                 + K0_ON(5,6)*y(5) - K0_ON(6,5)*y(6)...
                 + K0_ON(6,6)*y(6) - K0_ON(6,6)*y(6)...
                 + K0_ON(7,6)*y(7) - K0_ON(6,7)*y(6);

    ode7_ON = @(t, y) K0_ON(1,7)*y(1) - K0_ON(7,1)*y(7)...
                 + K0_ON(2,7)*y(2) - K0_ON(7,2)*y(7)...
                 + K0_ON(3,7)*y(3) - K0_ON(7,3)*y(7)...
                 + K0_ON(4,7)*y(4) - K0_ON(7,4)*y(7)...
                 + K0_ON(5,7)*y(5) - K0_ON(7,5)*y(7)...
                 + K0_ON(6,7)*y(6) - K0_ON(7,6)*y(7)...
                 + K0_ON(7,7)*y(7) - K0_ON(7,7)*y(7);

    odes_ON = @(t, n) [ode1_ON(t, n); ode2_ON(t, n); ode3_ON(t, n); 
        ode4_ON(t, n); ode5_ON(t, n); ode6_ON(t, n); ode7_ON(t, n)];
    %----------------------------------------------------------------------
    % Simulation
    % Laser 1
    init_laser_1 = [1/3; 1/3; 1/3; 0; 0; 0; 0];
    [t, n_res_laser_1] = ode45(odes_ON, [0 : 1e-3 : 5180e-3], init_laser_1);
    
    % Delay 1
    init_delay_1 = get_init(n_res_laser_1);
    [t, n_res_delay_1] = ode45(odes_OFF, [5.18 : 1e-3 : 11.192], init_delay_1);
    n_res_delay_1(1,:) = [];
    
    % Calculation of the PL signal
    n_res = [n_res_laser_1; n_res_delay_1];
    t = 0 : 1e-3 : 11.192;
    n_res_1 = n_res(:, 1);
    n_res_2 = n_res(:, 2);
   
    init_contrast = (n_res_1 - n_res_2) ./ (n_res_1 + n_res_2);
    
    plot(t, init_contrast, "LineWidth", 1.5);
    xlabel('Time (\mus)');
    ylabel("PL");
    legend("init contrast = (n_1 - n_2) / (n_1 + n_2)")
    title(beta);
    
    contrast = init_contrast(8e3);
end



function init = get_init(arr)
    init = zeros(7,1);
    for i = 1:7
        init_temp = arr(:, i);
        init(i, 1) = init_temp(end);
    end
end
