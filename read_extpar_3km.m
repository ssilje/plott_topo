 
clear all
close all
%addpath(genpath('Plotutilities'))
DATA_extpar022='domain2019022210051.nc';
hsurf_022=ncread([DATA_extpar022],'HSURF');
lat022=ncread([DATA_extpar022],'lat');
lon022=ncread([DATA_extpar022],'lon');

hsurf_022_1d=reshape(hsurf_022,size(hsurf_022,1)*size(hsurf_022,2),1);
index_zero=find(hsurf_022_1d==0);
hsurf_022_1d(index_zero)=NaN;
hsurf_022_oceanNaN=reshape(hsurf_022_1d,size(hsurf_022,1),size(hsurf_022,2));

plot_color_name='topo_15lev.spk';
clear col_abs col_abs1
col_file=['plott_colors/' plot_color_name ];
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
LATLIM=[(min(min(lat022)) ) (max(max(lat022)))];
LONLIM=[(min(min(lon022))+0.5 ) (max(max(lon022))-0.5)];

%LATLIM=[(min(min(lat022)) +5) (max(max(lat022))-2)];
%LONLIM=[(min(min(lon022)) +0.5) (max(max(lon022))-8)];

h_proj=axesm('miller','maplatlim',LATLIM,'maplonlim',LONLIM);
%h_proj=axesm('miller');
% %framem; mlabel; plabel; gridm;
 framem; 
% %mlabel; plabel; gridm;
 hold on
 colormap(my_colmap_data);
 h=pcolorm(lat022,lon022,hsurf_022_oceanNaN);
 caxis([0 max(max(hsurf_022))]);
 set(h,'edgecolor','none');
 tightmap
 set(gca,'color',[.8 .8 .8])
% hold on
% plotm(lat2, long2, 'Color', 'black','LineWidth',1.5)
%Ytick_vector=linspace(0,6300,9);
%cb = colorbar('YTick',Ytick_vector);
Ytick_vector=[500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000]
X=hsurf_022_oceanNaN;
cb = cbarf_new(X,Ytick_vector);
    % place colorbar in right position
    cb_pos=get(cb,'position');
    hpro_pos=get(h_proj,'position')
    set(cb,'position',[hpro_pos(1)+0.75 cb_pos(2) cb_pos(3) cb_pos(4)])
    %set(cb,'position',[hpro_pos(1)+0.62 cb_pos(2) cb_pos(3) cb_pos(4)])



ytick = get(cb,'YTick');
ylab = get(cb,'ylabel');
set(ylab,'String','m','Fontname','arial','Fontsize',25,'FontWeight','bold');
yticklab = get(cb,'YTickLabel');
set(cb,'YTickLabel',ytick,'Fontname','arial','fontsize',15,'FontWeight','bold')
set(gcf, 'PaperPositionMode','auto')
print('-dsvg',['hsurf_3km'])