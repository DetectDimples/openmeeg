function om_save_sym(data,filename,format)

% OM_SAVE_SYM   Save symmetric Matrix
%
%   Save symmetric Matrix
%
%   SYNTAX
%       OM_SAVE_SYM(DATA,FILENAME,FORMAT)
%
%       FORMAT : can be 'ascii' or 'binary' (default)
%

me = 'OM_SAVE_SYM';

if nargin == 0
    eval(['help ',lower(me)])
    return
end

if nargin < 3
    format = 'binary';
end

dims = size(data);
assert(dims(1) == dims(2),'Matrix non square')
assert(isempty(find(data ~= data')),'Matrix non symmetric')

switch format
case 'binary'
    disp(['Saving file ',filename])
    file = fopen(filename,'w');
    dim = dims(1);
    fwrite(file,dim,'uint32','ieee-le');
    fwrite(file,data(triu(ones(dim,dim)) > 0),'double','ieee-le');
    fclose(file);
case 'ascii'
    for i=1:dims(1)
        if i == 1
            dlmwrite(filename, data(i,i:end), 'delimiter', '\t','precision',18);
        else
            dlmwrite(filename, data(i,i:end), 'delimiter', '\t','-append','precision',18);
        end
    end
otherwise
    error([me,' : Unknown file format'])
end

