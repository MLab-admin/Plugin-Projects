function out = config()
%ML.Plugins.Projects.run Projects' plugin run program
%
%   See also ML.plugins, ML.projects

out = struct('clear', true, ...
    'title', '~b{Projects plugin}', ...
    'text', 'These settings control the Projects'' plugin behavior.', ...
    'opt', struct('value', {}, 'desc', {}, 'cmd', {}, 'action', {}));

P = ML.Plugins.path('Projects');
if P.shortcuts.exist
    tmp = P.shortcuts.run();
    for j = 1:numel(tmp)
        out.opt(end+1) = tmp(j);
    end
end