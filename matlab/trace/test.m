function [ ret ] = test( inode, jnode)

%     clear;
%     load NCSU;
    traces = getTrace( 'ans,traces,r,i,inode,jnode', 0, 0, 0 );
    r = getRange(traces, 1000);
    drawHist( traces, 'NCSU', 100, 2000, r, 1 );
    % for i = 1 : length(traces)
    for i = inode : jnode
        itrace = getTrace( 'ans,traces,r,i,inode,jnode', i, 0, 0 );
        drawHist( itrace, strcat('NCSU-', int2str(i)), 100, 2000, r, 1 );
    end
    
end

