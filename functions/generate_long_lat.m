function generate_long_lat(origin,LATLIM_org,LONLIM_org)


points=50;
latlo = linspace(LATLIM_org(1,1),LATLIM_org(1,2),points);
latlo = latlo';
d = size(latlo);
lonlo = ones(d(1,1),1); 
lonlo_a = lonlo.*(-10);
lonlo_b = lonlo.*(0);
lonlo_c = lonlo.*(10);
lonlo_d = lonlo.*(20);
lonlo_e = lonlo.*(30);
% lat lines
lonla = linspace(LONLIM_org(1,1)+4,LONLIM_org(1,2)+4,points);
lonla = lonla';
d = size(lonla);
latla = ones(d(1,1),1);
latla_a = latla.*(30);
latla_b = latla.*(40);
latla_c = latla.*(50);
latla_d = latla.*(60);
latla_e = latla.*(70);



% plot lon lat lines
[Lonlat_a,Lonlong_a] = rotatem(latlo,lonlo_a,origin,'forward','degrees');
[Lonlat_b,Lonlong_b] = rotatem(latlo,lonlo_b,origin,'forward','degrees');
[Lonlat_c,Lonlong_c] = rotatem(latlo,lonlo_c,origin,'forward','degrees');
[Lonlat_d,Lonlong_d] = rotatem(latlo,lonlo_d,origin,'forward','degrees');
[Lonlat_e,Lonlong_e] = rotatem(latlo,lonlo_e,origin,'forward','degrees');

hold on
plotm(Lonlat_a, Lonlong_a, '-.' , 'Color', 'black','LineWidth',1)
plotm(Lonlat_b, Lonlong_b, '-.' , 'Color', 'black','LineWidth',1)
plotm(Lonlat_c, Lonlong_c, '-.' , 'Color', 'black','LineWidth',1)
plotm(Lonlat_d, Lonlong_d, '-.' , 'Color', 'black','LineWidth',1)
plotm(Lonlat_e, Lonlong_e, '-.' , 'Color', 'black','LineWidth',1)

[Latlat_a,Latlong_a] = rotatem(latla_a,lonla,origin,'forward','degrees');
[Latlat_b,Latlong_b] = rotatem(latla_b,lonla,origin,'forward','degrees');
[Latlat_c,Latlong_c] = rotatem(latla_c,lonla,origin,'forward','degrees');
[Latlat_d,Latlong_d] = rotatem(latla_d,lonla,origin,'forward','degrees');
[Latlat_e,Latlong_e] = rotatem(latla_e,lonla,origin,'forward','degrees');

hold on
plotm(Latlat_a, Latlong_a, '--' , 'Color', 'black','LineWidth',1)
plotm(Latlat_b, Latlong_b, '--' , 'Color', 'black','LineWidth',1)
plotm(Latlat_c, Latlong_c, '--' , 'Color', 'black','LineWidth',1)
plotm(Latlat_d, Latlong_d, '--' , 'Color', 'black','LineWidth',1)
plotm(Latlat_e, Latlong_e, '--' ,'Color', 'black','LineWidth',1)



