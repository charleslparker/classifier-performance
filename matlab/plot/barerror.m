function bs = barerror(X, Y, L, U, width, rotate, varargin)
% BARERROR combines the functions 'bar' and 'errorbar' in a single function. 
%   It can plot several bars (with their respective errors) per X value
%   Lables for the x axis can be specified as a cell array of strings as last
%   argument. They will be used recursively.
%   Author: F. de Castro

%   Sintax: barerror (X,Y,E,width,ycolor,ecolor,varargin)
%   X: vector of x values
%   Y: vector/array or matrix of y values
%   E: vector/array or matrix of error values (plotted symmetrically)
%   width: bar width
%   YCOLOR: one-letter color code for the bar
%   ECOLOR: one-letter color code for the error bar
% 
%   Warnings:
%   Vectors/arrays X, Y and E must be the same length
%   Y and E must have the same number of columns if they are arrays
%   The length of YCOLOR and ECOLOR must be the same as the number of columns
%   of Y and E
% 
%   Example:
%   x = (1:5)';
%   y = 20*rand(length(x),3);
%   e = rand(length(x),3);
%   ycolor = ['b','r','g'];
%   ecolor = ['k','k','k'];
%   labels = {'G1','G2','G3','G4','G5'};
%   barerror(x,y,e,1,ycolor,ecolor,labels);

%-- Check vectors lengths & widths
if mean([size(X,1),size(Y,1),size(L,1),size(U,1)]) ~= length(X)	
	error ('Input vectors are of different lengths'); 
end
if size(Y,2) ~= size(L,2)
	error ('Y and Error vectors have different number of columns'); 
end

ycolor = [0.5 0.5 1; 1 0.5 0.5; 0.5 1 0.5; 0.5 0.5 0.5; 0.5 1 1; 1 1 0.5; 1 0.5 1];

%-- Function
hold on
ncol = size(Y,2);
off = fix(-ncol/2):fix(ncol/2);
realwidth = min(diff(X))/(ncol);
if ~mod(ncol,2)
	off = [off(1:ceil(length(off)/2)-1), off(1+ ceil(length(off)/2):length(off))]; 
end
bs = [];

for h = 1:ncol
	Xtmp= X(:,1)+ off(h)*(realwidth/2)- sign(off(h))*(~mod(ncol,2)*realwidth/4);
	b = bar(Xtmp, Y(:,h), width/(2*ncol), 'FaceColor', ycolor(h,:));
	errorbar(Xtmp, Y(:,h), L(:,h), U(:,h), 'LineStyle', 'none', 'Color', 'k');
    bs = [bs b];
end

set(gca,'XTick',X);
if ~isempty(varargin) && ~rotate
	set(gca,'XTickLabel',varargin{1:length(varargin)}(:));
end

hold off
