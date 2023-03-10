function   y_cum = cum2est (y, maxlag, nsamp, overlap, flag)
%CUM2EST Covariance function.
%	Should be involed via "CUMEST" for proper parameter checks.
%	y_cum = cum2est (y, maxlag, samp_seg, overlap,  flag)

%	       y: input data vector (column)
%	  maxlag: maximum lag to be computed
%	samp_seg: samples per segment (<=0 means no segmentation)
%	 overlap: percentage overlap of segments
%	    flag: 'biased', biased estimates are computed
%	          'unbiased', unbiased estimates are computed.
%	   y_cum: estimated covariance,
%	          C2(m)  -maxlag <= m <= maxlag
%	all parameters must be specified!


% C2(m) := E conj(x(n)) x(n+k)

% ----------  parameter checks are done by CUMEST  ----------------

   [n1,n2] = size(y);    N = n1*n2;

   overlap  = fix(overlap/100 * nsamp);
   nrecord  = fix( (N - overlap)/(nsamp - overlap) );
   nadvance = nsamp - overlap;

   y_cum    = zeros(maxlag+1,1);
   ind = 1:nsamp;

   for i=1:nrecord
       x = y(ind); x = x(:) - mean(x);     % make sure we have a colvec
       for k = 0:maxlag
           y_cum(k+1) = y_cum(k+1) + x([1:nsamp-k])' * x([k+1:nsamp]);
       end
       ind = ind + nadvance;
   end
   if (flag(1:1) == 'b' | flag(1:1) == 'B')
       y_cum = y_cum / (nsamp*nrecord);
   else
       y_cum = y_cum ./ (nrecord * (nsamp-[0:maxlag]' ));
   end
   if maxlag > 0,
      y_cum = [conj(y_cum(maxlag+1:-1:2)); y_cum];
   end

return
