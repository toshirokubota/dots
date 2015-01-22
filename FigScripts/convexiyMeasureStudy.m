function [m1 m2 m3] = convexityMeasureStudy(K)
%This scripts study the convexity measure - area/length^2, we used to
%filter out some polygons in sortByGoodnessMeasure (and the measure
%implemented in GoodnessMeasure.dll).
%We use K uniformly placed points around a unit circle.

t = 2*pi/K;
%straight implementation 
m1 = (sin(t/2)*cos(t/2))/(2*sin(t/2))^2

%by analytic form
m2 = sin(2*pi/K)/(1-cos(2*pi/K))/4

%further reducing with Taylor series
m3 =  K/(4*pi)