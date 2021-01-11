function [ax,hfill]=cbarf(v,L,mode,scale);
%CBARF   Real filled colorbar.
%   Similar to the well known colorbarf but more realistic.
%   There are two things missing in colorbar and colorbarf:
%   1. the colorbar ticks are scaled according to the size of each
%   interval. If you don't want this, set SCALE to 'nonlinear'.
%   2. when color is saturated at the upper limit, or when is white,
%   below the lower limit, a triangle is added. The triangle
%   means "more/less than". Such information is not provided by the
%   existing tools, colorbar and colorbarf.
%   See the examples.
%   Besides, there is a bug (?) with contourf: in some cases, even
%   with the levels specified, one additional level is added and
%   corrensponds to the sourrounding line! In such case, colorbarf
%   adds one box for this fake level!
%
%   Syntax:
%      H=CBARF(DATA,LEVELS,MODE,SCALE)
%
%   Inputs:
%      DATA   The data used to create the contourf
%               (or alternative [min max] values for cbarf)
%      LEVELS Levels used (ex: contourf(x,y,DATA,LEVELS)
%      MODE   How the colorbar is placed [{'vertical'}, 'horiz']
%      SCALE  Colorbar ticks scaling [{'linear'},'nonlinear']
%
%   Output:
%       H   Handle for the axes created
%
%   Comment:
%      If you need to redraw the colorbar because caxis change for
%      instace, then just call cbarf without input arguments
%
%   Examples:
%      v=peaks;
%      L=[-5:-1 1:5];
%      figure
%      subplot(2,1,1)
%      contourf(v,L);
%      h1=cbarf(v,L);
%
%      caxis([-10 10])
%      cbarf;
%
%      subplot(2,1,2)
%      L=[5:15];
%      contourf(v,L);
%      h2=cbarf(v,L);
%
%   MMA 15-3-2007, martinho@fis.ua.pt

%   13-07-2007 - Added option SCALE, updated by Hvid Ribergaard
%   14-05-2008 - Corrected colors for the nonlinear case

% Martinho Marta Almeida
%    Department of Physics
%    University of Aveiro, Portugal


% Mads Hvid Ribergaard
%    Center for Ocean and Ice
%    Danish Meteorological Institute

% Adobted by Nico Kroener
% ETH Zürich
% 10.02.2016

 
% L=tick_y;
% v=squeeze(data2print(3,:,:))

% find previous cbarf:
ax0=gca;

% if no cbarf yet, then input arguments are needed:
scale='linear';
mode='vertical';
if nargin < 2
    disp(['## ',mfilename,' : not enough input arguments'])
    return
end
mv=min(v(:));
Mv=max(v(:));

% Mode
if isequal(lower(mode(1)),'h')
  isVertical=0;
  mode='horiz';
else
  isVertical=1;
  mode='vertical';
end

% Scale
if isequal(lower(scale(1)),'l')
  isLinear=1;
  scale='linear';
else
  isLinear=0;
  scale='nonlinear';
end

clim=get(ax0,'clim');
cmap=get(gcf,'colormap');

% create nex axes if needed:
au=get(ax0,'units');
set(ax0,'units','pixel'); ap=get(ax0,'position');
W=25;
dW=20;

% greate new axes for colorbar
ax0Pos = [ap(1) ap(2) ap(3)  ap(4)];
axPos  = [ap(1)+ap(3)-W  ap(2) W ap(4)];
set(ax0,'position',ax0Pos)
ud.L=L;
ud.Mm=[mv Mv];
ax=axes('units','pixel','tag',['cbarf_',mode,'_',scale],'userdata',ud);
set(ax0,'userdata',ax);


set(ax0,'units',au)
set(ax,'units','pixel','position',axPos)
set(ax,'units','normalized')

% Find number of colors
[~,Nl]=size(L);
Ncl=Nl-1;
colscal=cmap;

% draw rectangles:
for i=2:Ncl-1
    hold on;
    fill([0 1 1 0],[L(i) L(i) L(i+1) L(i+1)],colscal(i,:));
end;

yl=[L(1) L(end)];

% add triangle at top/right:
ap=get(ax,'position');
fill([0 1 .5],[L(end-1) L(end-1) L(end-1)+diff(yl)/15],colscal(end,:),'clipping','off');
set(ax,'position',[ap(1:3) ap(4)-ap(4)/15])

% add triangle at bottom/left:
ap=get(ax,'position');
fill([0 1 .5],[L(1+1) L(1+1) L(1+1)-diff(yl)/15],colscal(1,:),'clipping','off');
set(ax,'position',[ap(1) ap(2)+ap(4)/15 ap(3) ap(4)-ap(4)/15])

% set limits and ticks
set(ax,'xtick',[],'yaxislocation','right','ytick',L(2:end-1),'yticklabel',L(2:end-1));
ylim([L(2) L(end-1)])

hfill=get(ax,'Children');
axes(ax0)

