% -- Extract HEADER DATA --
    T = readtable(filename);
    headerData = cell2table(T{1:15,:});