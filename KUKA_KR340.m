close all
clc
clear variables
% Se ponen longitudes
L1 = 10.45;
L2 =  5.00;
L3 = 13.00;
L4 =  0.55;
L5 = 15.25;
L6 =  2.90;
% Definición de los eslabones
link(1) = Link('revolute', 'alpha',   +pi, 'a',   0, 'd', -L1,  'offset',     0, 'qlim', [-185*pi/180,  185*pi/180], 'modified');
link(2) = Link('revolute', 'alpha', +pi/2, 'a',  L2, 'd',   0,  'offset',     0, 'qlim', [-130*pi/180,   20*pi/180], 'modified');
link(3) = Link('revolute', 'alpha',     0, 'a',  L3, 'd',   0,  'offset', -pi/2, 'qlim', [-100*pi/180,  144*pi/180], 'modified');
link(4) = Link('revolute', 'alpha', +pi/2, 'a', -L4, 'd', -L5,  'offset',     0, 'qlim', [-350*pi/180,  350*pi/180], 'modified');
link(5) = Link('revolute', 'alpha', -pi/2, 'a',   0, 'd',   0,  'offset',     0, 'qlim', [-120*pi/180,  120*pi/180], 'modified');
link(6) = Link('revolute', 'alpha', +pi/2, 'a',   0, 'd',   0,  'offset',     0, 'qlim', [-350*pi/180,  350*pi/180], 'modified');
% Creación de robot
Kuka_KR340 = SerialLink(link,'name','KR340')
% Definición del Tool
R_TCPa3 = [[1 0 0]' [0 -1 0]' [0 0 -1]'];
P_TCPen3 = [0 0 -L6]';
T_TCPa3 = [[R_TCPa3 P_TCPen3]; [0 0 0 1]]
Kuka_KR340.tool = T_TCPa3;
% Visualización
hold on
Kuka_KR340.plot([0 0 0 0 0 0],'workspace',[-20.00 20.00 -20.00 20.00 -20.00 20.00],'noa','jaxes', 'view',[30 30])
trplot(eye(4), 'width',2,'arrow')
Kuka_KR340.teach([0 -pi/2 pi/2 0 0 0])
axis([-40.00 40.00 -40.00 40.00 -30.00 45.00]);
%Coordenadas generalizadas
T_EF = Kuka_KR340.fkine([0 0 0 0 0 0]);
X_o = tr2rpy(T_EF,'deg');
X_p = T_EF(1:3,4);
X = [X_p; X_o']
% Espacio alcanzable
Q2_min = -130*pi/180;
Q2_max = 20*pi/180;
pasoQ2 = 1*pi/180;

Q3_min = -100*pi/180;
Q3_max = 144*pi/180;
pasoQ3 = 1*pi/180;

i = 1;
for q2 =Q2_min:pasoQ2:Q2_max
    i
    T_EF = Kuka_KR340.fkine([0 q2 Q3_min 0 0 0]);
    %Kuka_KR340.teach([0 q2 Q3_min 0 0 0])
    X_p = T_EF(1:3,4);
    linea1_X(i) = X_p(1);
    linea1_Y(i) = X_p(2);
    linea1_Z(i) = X_p(3);
    i= i+1;
end
plot3(linea1_X,linea1_Y,linea1_Z)

i = 1;
for q3 =Q3_min:pasoQ3:Q3_max
    T_EF = Kuka_KR340.fkine([0 Q2_min q3 0 0 0]);
    %Kuka_KR340.teach([0 Q2_min q3 0 0 0])
    X_p = T_EF(1:3,4);
    linea2_X(i) = X_p(1);
    linea2_Y(i) = X_p(2);
    linea2_Z(i) = X_p(3);
    i= i+1;
end
plot3(linea2_X,linea2_Y,linea2_Z)

i = 1;
for q2 =Q2_min:pasoQ2:Q2_max
    T_EF = Kuka_KR340.fkine([0 q2 0 0 0 0]);
    %Kuka_KR340.teach([0 q2 0 0 0 0])
    X_p = T_EF(1:3,4);
    linea3_X(i) = X_p(1);
    linea3_Y(i) = X_p(2);
    linea3_Z(i) = X_p(3);
    i= i+1;
end
plot3(linea3_X,linea3_Y,linea3_Z)

i = 1;
for q3 =Q3_min:pasoQ3:Q3_max
    T_EF = Kuka_KR340.fkine([0 Q2_max q3 0 0 0]);
    %Kuka_KR340.teach([0 Q2_max q3 0 0 0])
    X_p = T_EF(1:3,4);
    linea4_X(i) = X_p(1);
    linea4_Y(i) = X_p(2);
    linea4_Z(i) = X_p(3);
    i= i+1;
end
plot3(linea4_X,linea4_Y,linea4_Z)

i = 1;
for q2 =Q2_max:-pasoQ2:Q2_min
    T_EF = Kuka_KR340.fkine([0 q2 Q3_max 0 0 0]);
    %Kuka_KR340.teach([0 q2 Q3_max 0 0 0])
    X_p = T_EF(1:3,4);
    lineaX(i) = X_p(1);
    lineaY(i) = X_p(2);
    lineaZ(i) = X_p(3);
    i= i+1;
end
plot3(lineaX,lineaY,lineaZ)

hold off