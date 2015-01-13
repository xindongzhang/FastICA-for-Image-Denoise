function cal_ica_W()
% demo - example use of the code in this directory
%

%-----------------------------------------------------------
% Gather the patches from the images...
%-----------------------------------------------------------
global X;

% These are large experiments (16-by-16 windows, 160 dimensions)
[X, whiteningMatrix, dewhiteningMatrix] = data( 50000, 8, 40 );


%-----------------------------------------------------------
% LARGE - Standard ICA (simple cell model)
%-----------------------------------------------------------

p.seed = 1;
p.write = 5;
p.model = 'ica';
p.algorithm = 'fixed-point';
p.components = 40;
IterMax = 2000;
estimate( whiteningMatrix, dewhiteningMatrix, 'ica.mat', p , IterMax);

%-----------------------------------------------------------
% SMALL - Displaying the estimated bases
%-----------------------------------------------------------

load ica.mat;
visual( A, 3,8 );
end
