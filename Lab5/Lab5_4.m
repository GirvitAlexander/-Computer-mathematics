function Lab5_4()
  left = 1;
  right = 5;
  l = 1;
  sh = 100;
  max = 10000;
  
  for n = sh:sh:max
    n
    u = rand(1, n);
    v = left + (right - left) * u;
    int_temp(l) = 0;
    for i = 1:n
      int_temp(l) = int_temp(l) + sin(v(i));
    endfor
    int_temp(l) = (right - left) / n * int_temp(l);
    int(l) = -cos(right) - (- cos(left));
    alpha(l) = -log(abs(int(l) - int_temp(l))) / log(n);
    l = l + 1;
  endfor
  %plot(sh:sh:max, int_temp);
  hold on;
  grid on;
  %plot(sh:sh:max, int);
  plot(sh:sh:max, alpha);
  hold off;  
endfunction