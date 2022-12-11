function Lab5_3()
  left = 1;
  right = 5;
  h = 2;
  x_t = left:0.00001:right;
  y_t = sin(x_t);
  
  plot(x_t, y_t);
  hold on;
  grid on;
  for l = 1: 15
    legend("sin");
    n = input("Enter: \n 0 - если показать селедующий шаг 1 \n остальные клавиши - выйти\n");
    if n != 0
      break;
    endif
    h = h / 2;
    h
    plot(x_t, y_t);
    hold on;
    grid on;
    for x = left:h:right - h
      plot([x, x], [0, sin(x)], "-g");
      plot([x + h, x + h], [0, sin(x + h)], "-g");
      plot([x, x + h], [sin(x), sin(x + h)], "-g");
      plot([x, x + h], [0, 0], "-g");
    endfor
  
    hold off;
  endfor
  hold off;
endfunction