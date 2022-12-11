function Lab3_2()
  left = 1;
  right = 3;
  k = 1;
  for h = 0.1:-0.0001:0.0001
    h
    X = left : h : right;
    Y = sin(X);
    Y_dev = cos(X);
    N = length(X);
    dev_max_I = -1;
    dev_max_I_ = -1;
    dev_max_II = -1;
    dev_max_II_ = -1;
    dev_max_IV(k) = -1;
    
    for i = 1:(N - 1)
      I(i) = (Y(i + 1) - Y(i)) / h;
      dev = abs(I(i) - Y_dev(i));
      if (dev_max_I < dev)
        dev_max_I = dev;
      endif
    endfor
    a_I(k) = log(dev_max_I) / log(h);
    C_I(k) = dev_max_I / h;
    for i = 2:(N)
      I_(i - 1) = (Y(i) - Y(i - 1)) / h;
      dev = abs(I_(i - 1) - Y_dev(i));
      if (dev_max_I_ < dev)
        dev_max_I_ = dev;
      endif
    endfor
    
    a_I_(k) = log(dev_max_I_) / log(h);
    C_I_(k) = dev_max_I_ / h;
  
    for i = 1:(N - 2)
      II(i) = (4 * Y(i + 1) - 3 * Y(i) - Y(i + 2)) / (2 * h);
      dev = abs(II(i) - Y_dev(i));
      if (dev_max_II < dev)
        dev_max_II = dev;
      endif
    endfor
    
    a_II(k) = log(dev_max_II) / log(h);
    C_II(k) = dev_max_II / (h * h);
    
    for i = 2:(N - 1)
      II_(i - 1) = (Y(i + 1) - Y(i - 1)) / (2 * h);
      dev = abs(II_(i - 1) - Y_dev(i));
      if (dev_max_II_ < dev)
        dev_max_II_ = dev;
      endif
    endfor
    
    a_II_(k) = log(dev_max_II_) / log(h);
    C_II_(k) = dev_max_II_ / (h * h);
    
    for i = 3:(N - 2)
      IV(i - 2) = (Y(i - 2) - 8 * Y(i - 1) + 8 * Y(i + 1) - Y(i + 2)) / (12 * h);
      dev = abs(IV(i - 2) - Y_dev(i));
      if (dev_max_IV(k) < dev)
        dev_max_IV(k) = dev;
      endif
    endfor
    
    a_IV(k) = log(dev_max_IV(k)) / log(h);
    
    num(k) = h;
    k = k + 1;
  endfor
  
  plot(num, a_I, "-");
  hold on;
  grid on;
  plot(num, a_II, "-");
  hold off;
  legend("I", "II");
  
  plot(num, a_I_, "-");
  hold on;
  grid on;
  plot(num, a_II_, "-");
  hold off;
  
  legend("I_", "II_");
  
  plot(num, C_I, "-");
  hold on;
  grid on;
  plot(num, C_I_, "-");
  hold off;
  legend("C_I", "C_I_");
  
  plot(num, C_II, "-");
  hold on;
  grid on;
  plot(num, C_II_, "-");
  hold off;
  legend("C_II", "C_II_");
  

  plot(num, a_IV, "-");
  grid on;
  legend("IV");
  dev_max_IV
  
endfunction