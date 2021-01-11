 
clear all
%close all
addpath(genpath('/home/ssilje/PLOT_MODEL_RESULTS/MATLAB/PLOT_Nico/Plotutilities'))
DATA_extpar022='domain2019022210051.nc';
hsurf_022=ncread([DATA_extpar022],'HSURF');
lat022=ncread([DATA_extpar022],'lat');
lon022=ncread([DATA_extpar022],'lon');

hsurf_022_1d=reshape(hsurf_022,size(hsurf_022,1)*size(hsurf_022,2),1);
index_zero=find(hsurf_022_1d==0);
hsurf_022_1d(index_zero)=NaN;
hsurf_022_oceanNaN=reshape(hsurf_022_1d,size(hsurf_022,1),size(hsurf_022,2));

plot_color_name='topo_15lev.spk';
%plot_color_name='terrestrial.spk';
clear col_abs col_abs1
col_file=['/home/ssilje/FUNKSJONER/funksjoner/plott_colors/' plot_color_name ];
nplotlev=16
[col_prec,col_r,col_g,col_b]=textread(col_file);
nplot=101/nplotlev;

col_r_interp=interp1(col_prec,col_r,[0:nplot:100]);
col_g_interp=interp1(col_prec,col_g,[0:nplot:100]);
col_b_interp=interp1(col_prec,col_b,[0:nplot:100]);
my_colmap_data=[col_r_interp;col_g_interp;col_b_interp]'/100;

% 
% 
% 

figure('Units','normalized','Position',[0 0 1 1],'visible','on') % visible off for plotting; The other option for fullscrenn print
%LATLIM=[(min(min(lat022)) +5) (max(max(lat022))-3)];
%LONLIM=[(min(min(lon022)) +5) (max(max(lon022))-8)];
LATLIM=[(min(min(lat022)) ) (max(max(lat022))-0.5)];
LONLIM=[(min(min(lon022))+1 ) (max(max(lon022))-1)];
h_proj=axesm('miller','maplatlim',LATLIM,'maplonlim',LONLIM);

%h_proj=axesm('miller');
% %framem; mlabel; plabel; gridm;
 framem; 
% %mlabel; plabel; gridm;
 hold on
% colormap(my_colmap_data);
 h=pcolorm(lat022,lon022,hsurf_022_oceanNaN);
 Ytick_vector=0:100:6300;
 %demcmap('inc',[-1 (max(max(hsurf_022_oceanNaN)))],100)
 %demcmap('inc',[(min(min(hsurf_022))) (max(max(hsurf_022)))],100)
 demcmap('inc',[1 (max(max(hsurf_022)))],100)
 %demcmap(hsurf_022_oceanNaN)

 caxis([100 max(max(hsurf_022))]);
 set(h,'edgecolor','none');
 tightmap

   set(gca,'color',[.8 .8 .8])

% 
% X=hsurf_022_oceanNaN;
% cb = cbarf_new(X,Ytick_vector);
%     % place colorbar in right position
%     cb_pos=get(cb,'position');
%     hpro_pos=get(h_proj,'position')
%     set(cb,'position',[hpro_pos(1)+0.75 cb_pos(2) cb_pos(3) cb_pos(4)])
% 
% ylab = get(cb,'ylabel');
% ytick = get(cb,'YTick');
% 
% set(ylab,'String','Elevation [m]','Fontname','arial','Fontsize',25,'FontWeight','bold');
% yticklab = get(cb,'YTickLabel');
% %set(cb,'YTickLabel',ytick,'Fontname','arial','fontsize',15,'FontWeight','bold')
% set(cb,'YTickLabel',[yticklab(1,:); yticklab(15,:); yticklab(30,:); yticklab(45,:); yticklab(end,:)],'YTick', [ytick(1) ytick(15) ytick(30) ytick(45) ytick(end)],'Fontname','arial','fontsize',15,'FontWeight','bold')
% 

set(gcf,'renderermode','manual');
set(gcf, 'PaperPositionMode','auto')


print('-dsvg','-r0', ['hsurf_3km'])
print('-depsc2','-r0', ['hsurf_3km.eps'])
print('-dpng', ['hsurf_3km.png'])
% print('-dpdf', '-bestfit',['hsurf_3km'])

%print('-dsvg',['hsurf_3km'])
 
% print('-depsc2',['hsurf_3km.eps'])
 %print('-dpdf', '-r300',['hsurf_3km'])
  %print('-dpdf', ['hsurf_3km'])