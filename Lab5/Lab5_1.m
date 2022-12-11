function Lab5_1()
  left = 1;
  right = 5;
  h = 1;
  N = 15;
  int = -cos(right) + cos(left);
  int_left_rect = zeros(N, 1);
  int_right_rect = zeros(N, 1);
  int_medium_rect = zeros(N, 1);
  int_trapezoid = zeros(N, 1);
  int_simpson = zeros(N, 1);
  
  for i = 1:N
    h = h / 2;
    h
    for x = left:h:right - h
      int_left_rect(i) = int_left_rect(i) + h * sin(x);
    endfor
    alpha_1(i) = log(abs(int - int_left_rect(i))) / log(h);
    
    for x = left:h:right - h
      int_right_rect(i) = int_right_rect(i) + h * sin(x + h);
    endfor
    alpha_2(i) = log(abs(int - int_right_rect(i))) / log(h);
 
    for x = left: h:right - h
      int_medium_rect(i) = int_medium_rect(i) + h * sin((2 * x + h) / 2);
    endfor
    alpha_3(i) = log(abs(int - int_medium_rect(i))) / log(h);
    
    for x = left:h:right - h
      int_trapezoid(i) = int_trapezoid(i) + h / 2 * (sin(x) + sin(x + h));
    endfor
    alpha_4(i) = log(abs(int - int_trapezoid(i))) / log(h);
    
    for x = left:2 * h:right - 2 * h
      int_simpson(i) = int_simpson(i) + 2 * h * (sin(x) + 4 * sin((2 * x + 2 * h) / 2) + sin(x + 2 * h)) / 6;
    endfor
    
    alpha_5(i) = log(abs(int - int_simpson(i))) / log(h);
    
    h_print(i) = h;
  endfor
  
  plot(h_print, abs(int - int_left_rect), ";Left rectangles;");
  hold on;
  grid on;
  plot(h_print, abs(int - int_right_rect), ";Right rectangles;");
  plot(h_print, abs(int - int_medium_rect), ";Average rectangles;");
  plot(h_print, abs(int - int_trapezoid), ";Trapezoid;");
  plot(h_print, abs(int - int_simpson), ";Parabolas;");
  hold off;
  
  figure(2);
  plot(h_print, alpha_1, ";Left rectangles;;");
  hold on;
  grid on;
  plot(h_print, alpha_2, ";Right rectangles;");
  plot(h_print, alpha_3, ";Average rectangles;");
  plot(h_print, alpha_4, ";Trapezoid;");
  plot(h_print, alpha_5, ";Parabolas;");
  hold off;
endfunction