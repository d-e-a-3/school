if color == 1
%     parser1
    datacolor = ':b';
	fitcolor = 'b';
elseif color == 2
%     parser2
    datacolor = ':g';
	fitcolor = 'g';
elseif color == 0
%     parser0
    datacolor = ':r';
	fitcolor = 'r';
else disp('No Laser Specified.')
	datacolor = ':k';
	fitcolor = 'k';
end