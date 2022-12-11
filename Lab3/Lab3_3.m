function Lab3_3()
  k = 1;
  left = 10;
  right = 1;
  step = -1;
  r = 2;
  for d = 1:15
    d
    left = left / 10;
    right = right / 10;
    step = step / 10;
    for h = left:step:right
      X = 1 : h : 1 + (10 * h);
      
      Y = sin(X);
      Y_dev = cos(X);
      N = length(X);
      dev_max_IV(k) = -1;
      for i = 3:(N - 2)
        IV(i - 2) = (Y(i - 2) - 8 * Y(i - 1) + 8 * Y(i + 1) - Y(i + 2)) / (12 * h);
        dev = abs(IV(i - 2) - Y_dev(i));
        if (dev_max_IV(k) < dev)
          dev_max_IV(k) = dev;
        endif
      endfor
      
      num(k) = h;
      k = k + 1;
    endfor
  endfor
  num(k - 1)
  dev_max_IV
  plot(num, dev_max_IV, "-");
endfunction