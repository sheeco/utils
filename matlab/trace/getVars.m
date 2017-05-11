%  [ vars ] = getVars( exceptions )
%  eg. [ vars ] = getVars( '' )
%

function [ vars ] = getVars( exceptions )

    who = evalin('base', 'who');
    
    if strcmp(exceptions, '') == 0
        vars = removeException( who, exceptions );
    else
        vars = who;
    end
    
end