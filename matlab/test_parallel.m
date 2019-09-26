% Test Matlab running in parallel on multiple cores.

% Discover number of available cores assigned by PBSPro.
nCores = str2num(getenv('NCPUS'));
fprintf('Number of cores available from PBS is: %d \n', nCores);

% Start parpool
p = parpool (4);

A = zeros(1,1024);
parfor i = 1:1024
    A(i) = sin(2*pi*i/1024);
end

delete(p);
disp(A);
exit;

