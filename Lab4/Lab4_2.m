function Lab4_2()
  left = 1;
  right = 5;
  
  L = Gram_Shmidt(9, left, right);
  
  x_t = left: 0.01: right;
  y_t = polyval(L, x_t);
  
  plot(x_t, y_t, "-g");
  hold on;
  grid on;
  
  x_root = roots(L);
  y_root = polyval(L, x_root);
  plot(x_root, y_root, "xr");
  hold off;
  
  x_root
endfunction

function [ans] = Gram_Shmidt(N, left, right)
  for i = 1:(N + 1)
    e{i} = zeros(1, i);
    e{i}(1) = 1;
    for j = 1:(i - 1)
      bal = zeros(1, i - j + 1);
      bal(i - j + 1) = 1;
      e{i} = e{i} - scalar_product(e{j}, e{i}, left, right) / scalar_product(e{j}, e{j}, left, right) * conv(e{j}, bal);
    endfor
  endfor
  ans = e{N + 1};
endfunction

function [ans] = scalar_product(f_1, f_2, left, right)
  ans = integral(conv(f_1, f_2), left, right);
endfunction

function [ans] = integral(f, left, right)
  N = length(f);
  f = conv(f, [0, 1]);
  for i = 1:N
    f(i) = f(i + 1) / (N - (i - 1));
  endfor
  f(N + 1) = 0;
  ans = polyval(f, right) - polyval(f, left);
endfunction