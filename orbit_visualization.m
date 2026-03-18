clear; clc; close all;
%输入轨道参数 
a = 0;          
e = 0;          
omega = 0;        
sheng = 0;         
jin = 0;        
  

disp('卫星轨道参数（单位：度）');
a = input('长半轴长度(km)：');
e = input('偏心率：');
omega = input('轨道倾角(度)：');
sheng = input('升交点赤经(度)：');
jin = input('近地点角距(度)：');

%生成卫星轨道点 
theta = linspace(0, 2*pi, 1000); % 真近点角
r = a*(1-e^2)./(1+e*cos(theta)); % 轨道半径
x_orbit = r.*cos(theta);
y_orbit = r.*sin(theta);
z_orbit = zeros(size(x_orbit));


% 轨道旋转 
Rz_omega = [cos(omega), -sin(omega), 0;
            sin(omega),  cos(omega), 0;
            0,           0,          1];

Rx_omega = [1, 0,      0;
        0, cos(omega), -sin(omega);
        0, sin(omega),  cos(omega)];

Rz_sheng = [cos(sheng), -sin(sheng), 0;
           sin(sheng),  cos(sheng), 0;
           0,          0,         1];

Rot = Rz_sheng * Rx_omega * Rz_omega; % 豆包生成部分

% 旋转后轨道
orb = Rot * [x_orbit; y_orbit; z_orbit];
x = orb(1,:);
y = orb(2,:);
z = orb(3,:);

%地球
R_earth = 6371; 
[Xe,Ye,Ze] = sphere(50);
Xe = Xe*R_earth;
Ye = Ye*R_earth;
Ze = Ze*R_earth;

img = imread('map.jpg');  
img = flipud(img);
img = im2double(img);  

% h = surf(x, y, z, , img, 'FaceColor', 'texturemap');
figure('Color','white');
h = surf(Xe,Ye,Ze,img,'FaceColor','texturemap'); % 透明度用FaceAlpha 
set(h, 'EdgeColor', 'none');%1
hold on;%保留继续画图 
axis equal;%三坐标轴单位等长
grid on;%能转
view(45, 30);
 
%lighting gouraud;
material dull;
%材质

%开始画线

circ = linspace(0,2*pi,200);
eq_x = R_earth*cos(circ);
eq_y = R_earth*sin(circ);
eq_z = zeros(size(circ));
plot3(eq_x,eq_y,eq_z,'green','LineWidth',1);% 赤道 绿色 线长1



ziwuxian = linspace(-pi/2,pi/2,100);
zi_x = R_earth*cos(ziwuxian);
zi_y = zeros(size(ziwuxian));
zi_z = R_earth*sin(ziwuxian);
plot3(zi_x,zi_y,zi_z,'g','LineWidth',1);% 子午线半圆弧

%画卫星轨道
plot3(x,y,z,'red','LineWidth',1);

%
xlabel('X (km)'); ylabel('Y (km)'); zlabel('Z (km)');



axis vis3d; % 鼠标交互
camlight;
hold off;


 % 导入图片名改为map.jpg  
