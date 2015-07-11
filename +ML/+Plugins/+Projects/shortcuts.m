function out = shortcuts()
%ML.Plugins.Projects.shortcuts Projects plugin shortcuts
%
%   See also ML.projects, ML.config

out = struct('value', bool2str('get:shortcut:projects|Projects'), ...
        'desc', 'Projects selector', ...
        'cmd', 'r', ...
        'action', 'toggle:shortcut:projects|Projects,menu:shortcuts');
end
 
% -------------------------------------------------------------------------
function out = bool2str(b)

res = ML.Config.action(b);
if isstruct(res)
    res = res.value;
end

if res
    out = 'Yes';
else
    out = 'No';
end
end

