function u = rpiid(nsamp, in_type,p_spike)
%RPIID	Generates samples of an i.i.d. random process. 
%	u = rpiid (nsamp, in_type, p_spike)
%	
%	Generates nsamp i.i.d. samples of a random variable drawn from
%	the distribution specified by the string in_type:
%	  'exp' -- exponential     'lap' -- Laplacian  'nor' Gaussian
%	  'bga'  -- Bernoulli-Gaussian   'uni'-- uniform
%	  only the first character of the string is checked 
%	the default distribution is Gaussian ('nor').
%	p_spike is the probability of spike for Bernoulli-Gaussian ('bga') 
%	   its default value is 0.1 
%	   
%	The theoretical mean is subtracted from the generated sequence
%	unless, in_type is 'bga'. 
%	u is the nsamp x 1 vector of random variables 
% -------- parameter checks -----------------
   if (nsamp <= 0)     return;        end
   if (nargin == 1), in_type = 'nor'; end
   pdf = in_type(1); 

% -------- generate samples from the pdf ----

   if     (pdf == 'u' | pdf == 'U') 
              u = rand(nsamp,1) - 0.5; 
   elseif (pdf == 'e' | pdf == 'E') 
   	      u = rand(nsamp,1); u = - log(1-u) - 1; 
   elseif (pdf == 'l' | pdf == 'L') 
              u = rand(nsamp,1) -0.5; 
              u = -sign(u) .* log(1-2*abs(u)); 
   elseif (pdf == 'b' | pdf == 'B') 
             if (exist('p_spike') ~= 1) p_spike = 0.1; end 
             if (p_spike < 0. | p_spike > 1.) 
                error(' 0 <= p_spike <= 1  required') 
             end 
	     u = rand(nsamp,1) < p_spike; 
             u = u .* randn(nsamp,1); 
   elseif (pdf == 'n' | pdf == 'N') 
             u = randn(nsamp,1);
   else 
   	   disp(['pdf (in_type) --',in_type,'-- not recognized'])	
	   disp(['generating Gaussian random variables'])
           u = randn(nsamp,1);
   end

return
