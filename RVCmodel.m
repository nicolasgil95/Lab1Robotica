clear;clc;
%DHmodParameters=[a,    alpha,  d,  offset,-qlim,qlim]
DHmod=[0    pi    -10.45	0       -185*pi/180     185*pi/180
    05.00   pi/2    0       0       -130*pi/180     20*pi/180
	13.00	0		0		-pi/2   -100*pi/180     144*pi/180
	-0.55	pi/2    -15.25	0       -350*pi/180     350*pi/180
    0       -pi/2	0		0       -120*pi/180     120*pi/180
    0		pi/2    0       0       -350*pi/180     350*pi/180];
for i=1:6
    l(i)=Link('a',DHmod(i,1),'alpha',DHmod(i,2),'d',DHmod(i,3),'offset',DHmod(i,4),'modified','qlim',[DHmod(i,5) DHmod(i,6)]);
end
L=SerialLink(l,'name','KUKA')
clf;hold on;
L.plot([0,-pi/2,pi/2,0,0,0],'workspace',[-33.26 33.26 -33.26 33.26 38.71-47.97 38.71],'view',[30 30],'nowrist');