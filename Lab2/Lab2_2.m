function Lab2_2()
  left = 1;
  right = 5;

  k = 1;
  for i = 10:10:300
    h = (right - left) / (i - 1);
    X = left : h : right;
    Y = sin(X);
    [a, b, c, d] = splain(X, Y, i - 1);
    if (h / 10 < 0.1)
      sh = h / 5;
    else
      sh = 0.001;
    endif
    x_t = 0: sh : h;
    x_max = [left - 100, left - 100];
    y_max = [0, 1000];
    dev_max = -1;
    num = 0;
    for m = 1:(i - 1)
      S_m = [a(m), b(m), c(m), d(m)];
      for j= x_t
        dev(k) = abs(polyval(S_m, j) - sin(X(m) + j));
        if (dev_max < dev(k))
          dev_max = dev(k);
        endif
      endfor
      
    endfor
    dev(k) = dev_max;
    num_dev(k) = i;
    alpha(k) = - log(dev(k)) / log(i);
    k = k + 1;
    i
  endfor
  
  subplot(2, 1, 1);
  plot(num_dev, dev, "-xg");
  grid on;
  subplot(2, 1, 2);
  plot(num_dev, alpha, "-og");
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
