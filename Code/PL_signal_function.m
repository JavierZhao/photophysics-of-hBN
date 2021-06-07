%-------------------------------------------------------------------------%
% cycle_2_PL_signal(0.06)
% T_swp_arr = linspace(0.001, 0.099, 1000);
T_swp_arr = 0.001 : 0.001 : 0.5;

% Cycle 1
PL_signal_arr_1 = cycle_1_PL_signal() .* ones(500, 1);

% Cycle 2
PL_signal_arr_2 = zeros(500, 1);
for j = 1:500
    PL_signal_arr_2(j, 1) = cycle_2_PL_signal(T_swp_arr(j));
end

% Cycle 3
PL_signal_arr_3 = PL_signal_arr_2;

% Cycle 4
T_pi = 0.1;     % T_pi = 0.1 us
PL_signal_arr_4 = cycle_2_PL_signal(T_pi) .* ones(500, 1);

PL_signal_arr = zeros(500, 4);
PL_signal_arr(:, 1) = PL_signal_arr_1;
PL_signal_arr(:, 2) = PL_signal_arr_2;
PL_signal_arr(:, 3) = PL_signal_arr_3;
PL_signal_arr(:, 4) = PL_signal_arr_4;

plot(T_swp_arr, PL_signal_arr, "LineWidth", 1.5)
xlabel('T_{swp} (\mus)');
ylabel('PL signal');
legend('Cycle 1', 'Cycle 2', 'Cycle 3', 'Cycle 4');

% cycle_2_PL_signal(0.5)
function signal = cycle_2_PL_signal(T_swp)
    %----------------------------------------------------------------------
    % Parameters and equations
    T_pi = 0.1;      %100 ns
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

    beta = 0.3;
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
    
    % MW
    init_mw = get_init(n_res_delay_1);
    
    t3 = 0 : 1e-3 : T_swp;
    length = size(t3);
    n_1_0 = init_mw(1,1);
    n_2_0 = init_mw(2,1);
    n_1_tp = (n_1_0 - n_2_0)/2 * cos(pi * t3 / T_pi) + (n_1_0 + n_2_0)/2;
    n_2_tp = (n_1_0 + n_2_0) - n_1_tp;

    n_res_mw = zeros(length(2), 7);
    n_res_mw(:, 1) = n_1_tp;
    n_res_mw(:, 2) = n_2_tp;
    for i = 3:7
        n_res_mw(:, i) = init_mw(i, 1) .* ones(length(2), 1);
    end
    n_res_mw(1, :) = [];
    
    % Delay 2
    init_delay_2 = get_init(n_res_mw);
    [t, n_res_delay_2] = ode45(odes_OFF, [T_swp + 11.192 : 1e-3 : T_swp + 12.204], init_delay_2);
    n_res_delay_2(1, :) = [];
    
    % Laser 2
    init_laser_2 = get_init(n_res_delay_2);
    [t, n_res_laser_2] = ode45(odes_ON, [T_swp + 12.204 : 1e-3 : T_swp + 12.504], init_laser_2);
    n_res_laser_2(1, :) = [];
    
    % Delay 3
    init_delay_3 = get_init(n_res_laser_2);
    [t, n_res_delay_3] = ode45(odes_OFF, [T_swp + 12.504 : 1e-3 : T_swp + 13.104], init_delay_3);
    n_res_delay_2(1, :) = [];
    
    % Calculation of the PL signal
    n_res = [n_res_laser_1; n_res_delay_1; n_res_mw; n_res_delay_2; n_res_laser_2; n_res_delay_3];
    t = 0 : 1e-3 : T_swp + 13.104;
    n_res_4 = n_res(:, 4);
    n_res_5 = n_res(:, 5);
    n_res_6 = n_res(:, 6);
    I_PL = n_res_4 + n_res_5 + n_res_6;
    
%     plot(t, I_PL, "LineWidth", 1.5);
%     xlabel('Time (\mus)');
%     ylabel("PL");
%     legend("I_{PL} = n_4 + n_5 + n_6")
%     title("T_{swp} = 0.06 \mus")
    
    t = 12 : 1e-3 : 13 + T_swp;
    signal = trapz(t, I_PL(12000 : (13 + T_swp) * 1000));
%     plot(t, I_PL(12000 : (13 + T_swp) * 1000), "LineWidth", 1);
%     xlabel('Time (\mus)');
%     ylabel("PL");
end

function signal = cycle_1_PL_signal()
    %----------------------------------------------------------------------
    % Parameters and equations
    T_pi = 0.1;      %100 ns
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

    beta = 0.3;
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
    
    % Delay 2
    init_delay_2 = get_init(n_res_delay_1);
    [t, n_res_delay_2] = ode45(odes_OFF, [11.192 : 1e-3 :12.204], init_delay_2);
    n_res_delay_2(1, :) = [];
    
    % Laser 2
    init_laser_2 = get_init(n_res_delay_2);
    [t, n_res_laser_2] = ode45(odes_ON, [12.204 : 1e-3 : 12.504], init_laser_2);
    n_res_laser_2(1, :) = [];
    
    % Delay 3
    init_delay_3 = get_init(n_res_laser_2);
    [t, n_res_delay_3] = ode45(odes_OFF, [12.504 : 1e-3 : 13.104], init_delay_3);
    n_res_delay_2(1, :) = [];
    
    % Calculation of the PL signal
    n_res = [n_res_laser_1; n_res_delay_1; n_res_delay_2; n_res_laser_2; n_res_delay_3];
    t = 0 : 1e-3 : 13.104;
    n_res_4 = n_res(:, 4);
    n_res_5 = n_res(:, 5);
    n_res_6 = n_res(:, 6);
    I_PL = n_res_4 + n_res_5 + n_res_6;
    
%     plot(t, I_PL, "LineWidth", 1.5);
%     xlabel('Time (\mus)');
%     ylabel("PL");
%     legend("I_{PL} = n_4 + n_5 + n_6")
%     title("T_{swp} = 0.06 \mus")

    t = 12 : 1e-3 : 13;
    signal = trapz(t, I_PL(12000 : 13000));
%     plot(t, I_PL(12000 : 13000), "LineWidth", 1);
%     xlabel('Time (\mus)');
%     ylabel("PL");
end

function init = get_init(arr)
    init = zeros(7,1);
    for i = 1:7
        init_temp = arr(:, i);
        init(i, 1) = init_temp(end);
    end
end
