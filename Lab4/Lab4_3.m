function Lab4_3()
  left = 1;
  right = 20;
  int = -cos(right) - (- cos(left));
  N = 19;
  
  for i = 2:N
    L = Lezhandr(i);
    x_root = (right - left) / 2 * roots(L) + (right + left) / 2;
    x_root
    int_temp = 0;
    for k = 1:i
      f_t = [1];
      for j = 1:i
        if k != j
          f_t = conv(f_t, [1, -x_root(j)] / (x_root(k) - x_root(j)));
        endif
      endfor
      A_k = integral(f_t, left, right);
      int_temp = int_temp + A_k * sin(x_root(k));
    endfor
    int_temp
    int
    dev(i - 1) = abs(int - int_temp);
    alpha(i - 1) = -log(dev(i - 1)) / log(i);
  endfor
  
  x = 2:N;
  subplot(2, 1, 1);
  plot(x, dev, ";динамика отклонений;");
  alpha
  grid on;
  subplot(2, 1, 2);
  plot(x, alpha, ";alpha;");
  grid on;
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

function [ans] = integral(f, left, right)
  N = length(f);
  f = conv(f, [0, 1]);
  for i = 1:N
    f(i) = f(i + 1) / (N - (i - 1));
  endfor
  f(N + 1) = 0;
  ans = polyval(f, right) - polyval(f, left);
endfunction