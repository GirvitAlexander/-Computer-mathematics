function Lab5_2()
  left = 1;
  right = 5;
  h = 1;
  N = 15;
  int = -cos(right) + cos(left);
  int_left_rect = zeros(N, 1);
   
  for i = 1:N
    h = h / 2;
    h
    for x = left:h:right - h
      int_left_rect(i) = int_left_rect(i) + left_rectangle(x, x + h);
    endfor 
    m(i) = log(abs(int - int_left_rect(i))) / log(h);
    if i != 1
      
      c(i - 1) = abs(int_left_rect(i) - int_left_rect(i - 1)) / h_print(i - 1) * 2;
      int_rich(i - 1) = (2 * int_left_rect(i) - int_left_rect(i - 1));
      beta(i - 1) = log(abs(int - int_rich(i - 1))) / log(h_print(i - 1));
      
      h_draw(i - 1) = h_print(i - 1);
    endif
    
    h_print(i) = h;
  endfor
  
  plot(h_print, int_left_rect, ";Левые прямоугольники;");
  hold on;
  grid on;
  plot(h_draw, int_rich, ";Левые прямоугольники уточнение по Ричардсону;");
  
  hold off;
  figure(2);
  plot(h_print, m, ";Левые прямоугольники;");
  hold on;
  grid on;
  plot(h_draw, beta, ";Левые прямоугольники уточнение по Ричардсону;");
  hold off;
  c
endfunction

function [ans] = left_rectangle(a, b)
  ans = (b - a) * sin(a);
endfunction

