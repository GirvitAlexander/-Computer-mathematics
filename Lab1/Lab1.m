function Lab1()
  left = 1;
  h = 1;
  right = 5;
  X = left : h : right;
  Y = sin(X);
  
  L_1 = lagrang(X,Y);
  L_2 = newton(X,Y);
  x_t = left : 0.01 : right;
  y_t = polyval(L_1, x_t);
  plot(x_t, y_t, "-;f(x);g");
  hold on;
  grid on;
  plot(X, Y, "o;X;r");
  legend("Лагранж", "Точки");
  pause(1);
  
  y_t = polyval(L_2, x_t);
  plot(x_t, y_t, "-;f(x);b");
  
  legend("Лагранж", "Точки", "Ньютон");
  hold off;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  pause(1);
  
  L_3 = chebyshev(length(X));
  x_t = -1.1 : 0.01 : 1.1;
  y_t = polyval(L_3, x_t);
  plot(x_t, y_t, "-;Чебышев;g");
  grid on;  
  
  pause(20);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  x_t = left : 0.01 : right;
  
  root = (left + right) / 2 + (right - left) / 2 * roots(L_3);
  y_root = sin(root);
  
  L_4 = lagrang(root, y_root);
  y_t = polyval(L_4, x_t);
  plot(x_t, y_t, "-c");
  hold on;
  grid on;
  plot(root, y_root, "xr");
  
  y_t = sin(x_t);
  plot(x_t, y_t, "-b");
  
  x_max = [left - 100, left - 100];
  y_max = [0, 1000];
  dev_max = -1;
  for i= left : 0.1 : right
    dev = abs(polyval(L_4, i) - sin(i));
    if (dev_max < dev)
      dev_max = dev;
      y_max = [polyval(L_4, i), sin(i)];
      x_max = [i, i];
    endif
  endfor
  
  plot(x_max, y_max, 'r');
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  pause(1);
  
  x_t = left : 0.01 : right;
  
  y_t = polyval(L_2, x_t);
  plot(x_t, y_t, "-g");
  plot(X, Y, "or");
  
  x_max = [left - 100, left - 100];
  y_max = [0, 1000];
  dev_max = -1;
  for i= left : 0.1 : right
    dev = abs(polyval(L_2, i) - sin(i));
    if (dev_max < dev)
      dev_max = dev;
      y_max = [polyval(L_2, i), sin(i)];
      x_max = [i, i];
    endif
  endfor
  
  plot(x_max, y_max, 'm');
  legend("Лагранж по Чебышеву", "Узлы Чебышева", "sin", "Max отклонение Лагранжа", "Ньютон", "Равностоящие", "Max отклонение Чебышев");
  
  hold off;
  pause(3);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %k = 1;
  %for i = 6 : 17
  %  L_5 = chebyshev(i);
  %  root = (left + right) / 2 + (right - left) / 2 * roots(L_5);
  %  y_root = sin(root);
  % 
  %  L_5 = lagrang(root, y_root);
  %  dev_max = -1;
  %  for j= left : 0.1 : right
  %    dev(k) = abs(polyval(L_5, j) - sin(j));
  %    if (dev_max < dev(k))
  %      dev_max = dev(k);
  %    endif
  %  endfor
  %  dev(k) = dev_max;
  %  k = k + 1;
  %endfor
  %
  %dev_x = 6:17;
  %plot(dev_x, dev, "-;Максимальное отклонение;g");
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
endfunction

function ans=lagrang(X,Y)
  N = length(X);
  ans = [0];
  for i = 1:(N - 1)
    ans = conv(ans, [0, 1]);
  endfor

  for i = 1:N
    f_t = [1];
    for j = 1:N
      if i != j
        f_t = conv(f_t, [1, -X(j)] / (X(i) - X(j)));
      endif
    endfor
    ans = ans + Y(i) * f_t;
  endfor
endfunction

function ans=newton(X,Y)
  N = length(X) - 1;
  h = X(2) - X(1);
  Delta = [Y(1)];
  for i = 1:N
    Delta = conv(Delta, [1 0]);
    Delta(i + 1) = Y(i + 1);
  endfor
  for i = 1:N
    temp(1) = Delta(i + 1);
    Delta(i + 1) = Delta(i + 1) - Delta(i);
    for j = i + 1:N
      temp(2) = Delta(j + 1);
      Delta(j + 1) = Delta(j + 1) - temp(1);
      temp(1) = temp(2);
    endfor
  endfor
  ans = Delta(1);
  factorial = 1;
  h_pow_i = 1;
  poly = 1;
  for i = 1:N
    factorial = factorial * (i);
    h_pow_i = h_pow_i * h;
    poly = conv(poly, [1 -X(i)]);
    ans = conv(ans, [0, 1]);
    ans = ans + (Delta(i + 1) * poly) / (factorial * h_pow_i);
  endfor 
endfunction

function ans=chebyshev(N)
  function ans=recurrent_formula(cur_n)
    if cur_n == 0
      ans = [1];
      return;
    endif
    if cur_n == 1
      ans = [1, 0];
      return;
    endif
    ans = conv([2, 0], recurrent_formula(cur_n - 1)) - conv([0,0,1], recurrent_formula(cur_n - 2));
  endfunction
  ans = recurrent_formula(N) / 2^(N-1);
endfunction
