function estimate( whiteningMatrix, dewhiteningMatrix, fname, p , IterMax)
% SYNTAX:
% estimate( whiteningMatrix, dewhiteningMatrix, fname, dims );
%
% NOTE: X passed as global!
%
% X                  preprocessed (whitened) sample vectors in columns
% whiteningMatrix    transformation from observation space to X-space
% dewhiteningMatrix  inverse transformation
% fname              name of file to write
%
% PARAMETERS COMMON TO ALL ALGORITHMS
%
% p.seed             random number generator seed
% p.write            iteration interval for writing results to disk
%
% ICA (with FastICA algorithm, tanh nonlinearity)
%
% p.model            'ica'
% p.algorithm        'fixed-point'
% p.components       number of ICA components to estimate
% 


%-------------------------------------------------------------------
% PRELIMINARIES
%-------------------------------------------------------------------

% Print options
fprintf('You have selected the following options...\n');
p


% Take the data from the global variable
global X;
N = size(X,2);

%-------------------------------------------------------------------
% SETTING UP THE STARTING POINT...
%-------------------------------------------------------------------

% Initialize the random number generator.
rand('seed',p.seed);

% Take random initial vectors...
if strcmp(p.model,'ica')
  B = randn(size(X,1),p.components);      
end

% ...and decorrelate (=orthogonalize in whitened space)
B = B*real((B'*B)^(-0.5));
n = size(B,2);

%-------------------------------------------------------------------
% START THE ITERATION...
%-------------------------------------------------------------------

% Print the time when started (and save along with parameters).
c=clock;
if c(5)<10, timestarted = ['Started at: ' int2str(c(4)) ':0' int2str(c(5))];
else timestarted = ['Started at: ' int2str(c(4)) ':' int2str(c(5))];
end
fprintf([timestarted '\n']);
p.timestarted = timestarted;

% Initialize iteration counter

% Use starting stepsize for gradient methods
if strcmp(p.algorithm,'gradient')
  stepsize = p.stepsize; 
  obj = [];
  objiter = [];
end

% Loop forever, writing result periodically
iter = 1;
while 1  
  iter = iter + 1;
  % Increment iteration counter
  iter = iter+1;  
  fprintf('(%d)',iter);
  
  %-------------------------------------------------------------
  % FastICA step
  %-------------------------------------------------------------  
  
  if strcmp(p.model,'ica') & strcmp(p.algorithm,'fixed-point')

    % This is tanh but faster than matlabs own version
    hypTan = 1 - 2./(exp(2*(X'*B))+1);
    
    % This is the fixed-point step
    B = X*hypTan/N - ones(size(B,1),1)*mean(1-hypTan.^2).*B;
    
  end
  
  
  %-------------------------------------------------------------
  % Ortogonalize (equal to decorrelation since we are 
  % in whitened space)
  %-------------------------------------------------------------
  
  B = B*real((B'*B)^(-0.5));
  
  %-------------------------------------------------------------
  % Write the results to disk
  %-------------------------------------------------------------
  
  if rem(iter,p.write)==0 | iter==1
    
    A = dewhiteningMatrix * B;
    W = B' * whiteningMatrix;
      
    fprintf(['Writing file: ' fname '...']);
    if strcmp(p.algorithm,'gradient')
      eval(['save ' fname ' W A p iter obj objiter']);
    else
      eval(['save ' fname ' W A p iter']);
    end
    fprintf(' Done!\n');      
    
  end
  
  %% terminate the loop
  if iter > IterMax
      break;
  end
  
end

% We never get here...
return;





