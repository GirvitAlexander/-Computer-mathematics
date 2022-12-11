function Lab3_1()
  left = 1;
  right = 5;
  h = 0.1;
  X = left : h : right;
  Y = sin(X);
  Y_dev = cos(X);
  N = length(X);
  dev_max_I = -1;
  dev_max_I_ = -1;
  dev_max_II = -1;
  dev_max_II_ = -1;
  dev_max_IV = -1;
  
  for i = 1:(N - 1)
    I(i) = (Y(i + 1) - Y(i)) / h;
    x_I(i) = X(i);
    dev = abs(I(i) - Y_dev(i));
    if (dev_max_I < dev)
      dev_max_I = dev;
      y_max_I = [I(i), Y_dev(i)];
      x_max_I = [X(i), X(i)];
    endif
  endfor
  
  for i = 2:(N)
    I_(i - 1) = (Y(i) - Y(i - 1)) / h;
    x_I_(i - 1) = X(i);
    dev = abs(I_(i - 1) - Y_dev(i));
    if (dev_max_I_ < dev)
      dev_max_I_ = dev;
      y_max_I_ = [I_(i - 1), Y_dev(i)];
      x_max_I_ = [X(i), X(i)];
    endif
  endfor
  
  for i = 1:(N - 2)
    II(i) = (4 * Y(i + 1) - 3 * Y(i) - Y(i + 2)) / (2 * h);
    x_II(i) = X(i);
    dev = abs(II(i) - Y_dev(i));
    if (dev_max_II < dev)
      dev_max_II = dev;
      y_max_II = [II(i), Y_dev(i)];
      x_max_II = [X(i), X(i)];
    endif
  endfor
  
  for i = 2:(N - 1)
    II_(i - 1) = (Y(i + 1) - Y(i - 1)) / (2 * h);
    x_II_(i - 1) = X(i);
    dev = abs(II_(i - 1) - Y_dev(i));
    if (dev_max_II_ < dev)
      dev_max_II_ = dev;
      y_max_II_ = [II_(i - 1), Y_dev(i)];
      x_max_II_ = [X(i), X(i)];
    endif
  endfor
  
  for i = 3:(N - 2)
    IV(i - 2) = (Y(i - 2) - 8 * Y(i - 1) + 8 * Y(i + 1) - Y(i + 2)) / (12 * h);
    x_IV(i - 2) = X(i);
    dev = abs(IV(i - 2) - Y_dev(i));
    if (dev_max_IV < dev)
      dev_max_IV = dev;
      y_max_IV = [IV(i - 2), Y_dev(i)];
      x_max_IV = [X(i), X(i)];
    endif
  endfor
  
  subplot(2, 1, 1);
  plot(X, Y_dev, "-");
  hold on;
  grid on;
  plot(x_I, I, "-");
  plot(x_I_, I_, "-");
  plot(x_max_I, y_max_I, "-r");
  plot(x_max_I_, y_max_I_, "-r");
  legend("cos", "I", "I~");
  hold off;
  
  subplot(2, 1, 2);
  plot(X, Y_dev, "-");
  hold on;
  grid on;
  plot(x_II, II, "-");
  plot(x_II_, II_, "-");
  plot(x_IV, IV, "-");
  plot(x_max_II, y_max_II, "-r");
  plot(x_max_II_, y_max_II_, "-r");
  plot(x_max_IV, y_max_IV, "-r");
  legend("cos", "II", "II~", "IV");
  hold off;
  
  x_max_I
  dev_max_I
  x_max_I_
  dev_max_I_
  x_max_II
  dev_max_II
  x_max_II_
  dev_max_II_
  x_max_IV
  dev_max_IV
endfunction