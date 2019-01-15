
gifIT = 1;


if gifIT == 1
    if i == 1
        filename = 'newGif.gif';
        gif(filename,'frame',gcf);
    elseif i > 1
        gif
    end                
end