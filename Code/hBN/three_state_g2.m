function y = three_state_g2(x, k_21, k_23, k_31)
    % x is the \tau array
    % transition rates
%     y = zeros(size(x));
    K0 = zeros(3,3);
    beta = 0.3;
    k_12 = beta * k_21;
    K0(1,2) = k_12;
    K0(2,1) = k_21;
    K0(2,3) = k_23;
    K0(3,1) = k_31;

    K0_ON = K0;     %K matrix when laser is on

    % Solve the rate equations numerically
    ode1_ON = @(t, y) K0_ON(1,1)*y(1) - K0_ON(1,1)*y(1)...
                     + K0_ON(2,1)*y(2) - K0_ON(1,2)*y(1)...
                     + K0_ON(3,1)*y(3) - K0_ON(1,3)*y(1);
    ode2_ON = @(t, y) K0_ON(1,2)*y(1) - K0_ON(2,1)*y(2)...
                     + K0_ON(2,2)*y(2) - K0_ON(2,2)*y(2)...
                     + K0_ON(3,2)*y(3) - K0_ON(2,3)*y(2);
    ode3_ON = @(t, y) K0_ON(1,3)*y(1) - K0_ON(3,1)*y(3)...
                     + K0_ON(2,3)*y(2) - K0_ON(3,2)*y(3)...
                     + K0_ON(3,3)*y(3) - K0_ON(3,3)*y(3);

    odes_ON = @(t, n) [ode1_ON(t, n); ode2_ON(t, n); ode3_ON(t, n)];
    
    init_ON = [1; 0; 0];
    [~, n_res_ON] = ode45(odes_ON, [0 : 1e-4 : 1e-1], init_ON);
    
%     plot(t, n_res_ON)
    
    % Calculate g^2(\tau) based on n2
    n_res_2 = n_res_ON(:, 2);
    tau_arr = x';
    length = size(tau_arr);
    g2_arr = zeros(length);
    for i = 1 : length(2)
        g2_arr(i) = n_res_2(i) / n_res_2(end);
    end
    
    y = g2_arr';
    
end