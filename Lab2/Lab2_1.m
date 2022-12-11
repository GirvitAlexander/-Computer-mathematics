function Lab2_1()
  left = 0;
  N = 10;
  right = 10;
  h = (right - left) / (N - 1);
  X = left : h : right;
  Y = sin(X);
  
  [a, b, c, d] = splain(X, Y, N - 1);
  
  if (h / 10 < 0.1)
    sh = h / 10;
  else
    sh = 0.001;
  endif

  x_t = left: sh: right;
  y_t = sin(x_t);
  
  plot(x_t, y_t, "-g");
  hold on;
  grid on;
  plot(X, Y, "ob", "markersize", 1);
  
  x_t = 0: sh : h;
  
  x_max = [left - 100, left - 100];
  y_max = [0, 1000];
  dev_max = -1;
  num = 0;
  for i = 1:(N - 1)
    if num == 0
      num = input("Enter: \n 0 - если шаг 1 \n любое другое число - если нарисовать до конца\n");
    endif
    S_i = [a(i), b(i), c(i), d(i)];
    y_t = polyval(S_i, x_t);
    plot(x_t, y_t, "-m");
    plot(X(i) + x_t, y_t, "-r");
    for j= x_t
      dev = abs(polyval(S_i, j) - sin(X(i) + j));
      if (dev_max < dev)
        dev_max = dev;
        y_max = [polyval(S_i, j), sin(X(i) + j)];
        x_max = [X(i) + j, X(i) + j];
      endif
    endfor
  endfor
  
  plot(x_max, y_max, "-m");
  legend("sin(x)", "Равностоящие точки", "Кусочек сплайна", "Сплайн");
  x_max
  dev_max
  pr = X(2) - X(1)
  hold off;
endfunction

function [a, b, c, d]=splain(X, Y, N)
  
  for i = 1:(N + 1)
    Delta(i) = Y(i);
  endfor
  
  for i = 1:N
    Delta_1(i) = Delta(i + 1) - Delta(i);
  endfor
  
  for i = 1:N - 1
    Delta_2(i, 1) = Delta_1(i + 1) - Delta_1(i);
  endfor
  
  for i = 1:N
    d(i) = Y(i);
  endfor
  matr = zeros(N - 2, N - 2);
  matr(1, 1) = 4;
  matr(1, 2) = 1;
  for i = 2:(N - 2)
    matr(i, 1 + (i - 2)) = 1;
    matr(i, 2 + (i - 2)) = 4;
    matr(i, 3 + (i - 2)) = 1;
  endfor
  matr(N - 1, N - 2) = 1;
  matr(N - 1, N - 1) = 4;
  
  h = X(2) - X(1);
  h_2 = h * h;
  Delta_2 = 3 / h_2 * Delta_2;
  b_temp = (matr) \ (Delta_2);
  
  for i = 1:(N - 1)
    b(i) = b_temp(i, 1);
  endfor
  
  b = conv(b, [0, 1]);
  b(1) = 0;
  b = conv(b, [1, 0]);
  b(N + 1) = 0;
  
  for k = 1:N
    a(k) = (b(k + 1) - b(k)) / (3 * h);
    c(k) = Delta_1(k) / h - h * (2 * b(k) + b(k + 1)) / 3;
  endfor
  
endfunction
