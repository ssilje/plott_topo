% function to plot Cosmo output in native rotated grid

function map_nico(X,unit,title_string,range,color,Cordfile,landmask,figurename,plot,Prud,tick_y,colorbar_mode,test_on,test)

%X=squeeze(data2print(3,:,:));

if landmask == 1
    X = cosmolandmask(X); % Apply landmask to dataset
    figurename=[figurename,'_landmask'];
end; %endif landmask == 1

% X = cosmowatermask(X); % Apply landmask to dataset
% figurename=[figurename,'_watermask'];

exist test_on 'var'

if ans == 0
    test_on=false;
end

% define how much points for circle plots
points=10;

% get grid with the real long lat coordinates
ncfile        = Cordfile; % name of the cdffile
fileinfo      = nc_info(ncfile); % general Infos of the netcdf
varname2      = 'lon'; % name of the variable which should be read in the netcdf
varname3      = 'lat'; % name of the variable which should be read in the netcdf
gridlon       = nc_varget(ncfile, varname2); % get lon lat grid for plotting
gridlat       = nc_varget(ncfile, varname3);

origin = newpole(39.25, -162); % calculate rotation vector to plot in the rotated grid

[gridlat2,gridlon2] = rotatem(gridlat,gridlon,origin,'forward','degrees'); % rotate the matrix with values of the parameters 

% The points in the netcdf are defined at the middle of the gridbox we need
% to correct for that with a small shift
gridlat2 = gridlat2-0.22;
gridlon2 = gridlon2-0.22;

LATLIM = [min(min(gridlat2)) max(max(gridlat2))]; % claculate the boundarys in rotated grid
LONLIM = [min(min(gridlon2)) max(max(gridlon2))];

LATLIM_org = [min(min(gridlat)) max(max(gridlat))]; % claculate the boundarys in not rotated grid
LONLIM_org = [min(min(gridlon)) max(max(gridlon))];

% cut out the boundary zones
LATLIM(1,1) = LATLIM(1,1)+5;
LATLIM(1,2) = LATLIM(1,2)-5;
LONLIM(1,1) = LONLIM(1,1)+5;
LONLIM(1,2) = LONLIM(1,2)-5;


% North south gradient define region
% North_south gradient area
% % North area
%     NA.leftcorn_lat=linspace(52,63,points)';
%     NA.leftcorn_lon=ones(size(NA.leftcorn_lat,1),1).*-5;
%     NA.rightcorn_lat=linspace(52,63,points)';
%     NA.rightcorn_lon=ones(size(NA.leftcorn_lat,1),1).*30;
%     NA.uppercorn_lat=ones(size(NA.leftcorn_lat,1),1).*52;
%     NA.uppercorn_lon=linspace(-5,30,points)';
%     NA.lowercorn_lat=ones(size(NA.leftcorn_lat,1),1).*63;
%     NA.lowercorn_lon=linspace(-5,30,points)';
% 
% % % South area
%     SA.leftcorn_lat=linspace(36,48,points)';
%     SA.leftcorn_lon=ones(size(SA.leftcorn_lat,1),1).*-10;
%     SA.rightcorn_lat=linspace(36,48,points)';
%     SA.rightcorn_lon=ones(size(SA.leftcorn_lat,1),1).*30;
%     SA.uppercorn_lat=ones(size(SA.leftcorn_lat,1),1).*36;
%     SA.uppercorn_lon=linspace(-10,30,points)';
%     SA.lowercorn_lat=ones(size(SA.leftcorn_lat,1),1).*48;
%     SA.lowercorn_lon=linspace(-10,30,points)';

    
% open figure with special characteristics
figurenico;
%figure;
%whitebg([1 1 1]) % changes the background color to light grey
hold on
clim(1) = min(range);
clim(2) = max(range);
h_proj=axesm('miller','maplatlim',LATLIM,'maplonlim',LONLIM)
%framem; mlabel; plabel; %gridm;

%'hier 1'



%%
% % North_south gradient area
%     linewid=8;
%     % North area
%     [NA.leftline_lat NA.leftline_lon]   = rotatem(NA.leftcorn_lat,NA.leftcorn_lon,origin,'forward','degrees');
%     [NA.rightline_lat NA.rightline_lon] = rotatem(NA.rightcorn_lat,NA.rightcorn_lon,origin,'forward','degrees');
%     [NA.upperline_lat NA.upperline_lon] = rotatem(NA.uppercorn_lat,NA.uppercorn_lon,origin,'forward','degrees');
%     [NA.lowerline_lat NA.lowerline_lon] = rotatem(NA.lowercorn_lat,NA.lowercorn_lon,origin,'forward','degrees');
% 
%      hold on
%     plotm(NA.leftline_lat, NA.leftline_lon, 'Color', 'blue','LineWidth',linewid)
%     plotm(NA.rightline_lat, NA.rightline_lon, 'Color', 'blue','LineWidth',linewid)
%     plotm(NA.upperline_lat, NA.upperline_lon, 'Color', 'blue','LineWidth',linewid)
%     plotm(NA.lowerline_lat, NA.lowerline_lon, 'Color', 'blue','LineWidth',linewid)
% 
%     [SA.leftline_lat SA.leftline_lon]   = rotatem(SA.leftcorn_lat,SA.leftcorn_lon,origin,'forward','degrees');
%     [SA.rightline_lat SA.rightline_lon] = rotatem(SA.rightcorn_lat,SA.rightcorn_lon,origin,'forward','degrees');
%     [SA.upperline_lat SA.upperline_lon] = rotatem(SA.uppercorn_lat,SA.uppercorn_lon,origin,'forward','degrees');
%     [SA.lowerline_lat SA.lowerline_lon] = rotatem(SA.lowercorn_lat,SA.lowercorn_lon,origin,'forward','degrees');
%     
%     hold on
%     plotm(SA.leftline_lat, SA.leftline_lon, 'Color', 'black','LineWidth',linewid)
%     plotm(SA.rightline_lat, SA.rightline_lon, 'Color', 'black','LineWidth',linewid)
%     plotm(SA.upperline_lat, SA.upperline_lon, 'Color', 'black','LineWidth',linewid)
%     plotm(SA.lowerline_lat, SA.lowerline_lon, 'Color', 'black','LineWidth',linewid)
% %%    
    
%'hier 2'
% ttest results
% if test_on
%     for i=1:129
%         i
%         for j=1:132
%             
%             if test(i,j)==0
%                 plotm(gridlat2(i,j),gridlon2(i,j),'k');
%             end
%         end
%     end
% end

% define fontsize
fontsi=40;
name='arial';
% 
% 
if test_on
    for i=1:129
        for j=1:132
            if test(i,j)==0
                X(i,j)=NaN;
            end
        end
    end
end

% make plot of parameter
hold on
colormap(color);
h=pcolorm(gridlat2,gridlon2,X);
set(h,'edgecolor','none');
caxis([clim(1) clim(2)])
tightmap
title(title_string,'Fontname','arial','Fontsize',fontsi-20);
set(gca,'color',[.8 .8 .8])


% id_o=find(test==0)
% plotm(gridlat2(id_o),gridlon2(id_o),'s','MarkerFaceColor',[.8 .8 .8],'MarkerEdgeColor',[.8 .8 .8],'MarkerSize',8);


% plot country boundarys
load worldlo.mat; % file containig boundarys
a=POline(1);
latg=a.lat;
longg=a.long;
[latg2,longg2] = rotatem(latg,longg,origin,'forward','degrees'); % rotate the coordinates in the new system 
bound=plotm(latg2,longg2,'k-');
set(bound,'linewidth',1.2);

% plot coastline
load coast
[lat2,long2] = rotatem(lat,long,origin,'forward','degrees');
plotm(lat2, long2, 'Color', 'black','LineWidth',1.5)

hold on
generate_long_lat(origin,LATLIM_org,LONLIM_org)

if Prud
plot_prud_boundary(points,origin)
end

% plot_At_Med_boundary(points,origin)

% make colorbar
if strcmp(colorbar_mode,'new')
    cb = cbarf_new(X,tick_y);
    % place colorbar in right position
    cb_pos=get(cb,'position');
    hpro_pos=get(h_proj,'position');
    set(cb,'position',[hpro_pos(1)+0.62 cb_pos(2) cb_pos(3) cb_pos(4)])
else
    cb = colorbar('YTick',tick_y(2:end-1));
end;
ytick = get(cb,'YTick');
ylab = get(cb,'ylabel');
set(ylab,'String',unit,'Fontname','arial','Fontsize',fontsi,'FontWeight','bold');
yticklab = get(cb,'YTickLabel');
set(cb,'YTickLabel',ytick,'Fontname','arial','fontsize',fontsi,'FontWeight','bold')








%cb_pos_new=get(cb,'position');
%set(cb,'position',[hpro_pos(1)+hpro_pos(3)+0.1 cb_pos(2) cb_pos(3) cb_pos(4)])


%'hier 3'

%% save the figure with print
set(gcf, 'PaperPositionMode','auto')
%set(gcf, 'InvertHardCopy', 'off'); % retain background color  % This leads
%to an occasonall error while printing to save the fugures maybe don't use
%it any more?
%set(gcf, 'Position',[100 500 450 900]);
if plot % only plot if true
    %print('-depsc2','-zbuffer',[figurename,'.eps'])
    %print('-depsc2','-painters',[figurename,'painters.eps'])
    %print('-depsc2','-opengl',[figurename,'opengl.eps'])
    print('-djpeg',figurename)
    print('-dsvg',figurename)
    %print('-dtiff',[figurename,'.tiff'])
    %print('-dpdf',[figurename,'.pdf']) %make pdf doesn't work properly
end;
%print('-dpdf',figurename)
