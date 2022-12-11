function Lab4_1()
  left = 1;
  right = 5;
  
  L = Lezhandr(9);
  L = L / L(1);
  x_t = -1: 0.01: 1;
  y_t = polyval(L, x_t);
  
  plot(x_t, y_t, "-g");
  hold on;
  grid on;
  
  x_root = roots(L);
  y_root = polyval(L, x_root);
  plot(x_root, y_root, "xr");
  hold off;
  
  x_a_b_roots = (right - left) / 2 * x_root + (right + left) / 2 
endfunction

function [ans] = Lezhandr(N)
  f = [1, 0, -1];
  L = [1];
  num = 1;
  for i = 1:N
    L = conv(L, f);
    num = num * i;
  endfor
  
  for i = 1:(N + 1)
    ans((N + 2) - i) = num * L(N + 1 - (i - 1));   
    num = num * (N + i);
    num = num / i;
  endfor
endfunction