# Drawing-with-Fourier-Epicycles
MATLAB GUI that computes the required epicycles to match a custom drawing by using DFTs

**NOTE: Please vote my contribution in MathWorks if you liked it! Thanks!
https://es.mathworks.com/matlabcentral/fileexchange/72821-drawing-with-fourier-epicycles
**

![Image](https://es.mathworks.com/matlabcentral/mlc-downloads/downloads/c504760e-4d92-452b-8c57-501e408f5b55/a9a8b935-5bd0-4baf-93f4-66c1b50c2729/images/screenshot.png)

An epicycle is an orbit revolving around a point on the deferent. This GUI computes the required epicycles (i.e., radii, frequency and phase of all of them) in order to match a previously drawn curve, depicting an animation to see the result. The function also allows for uploading the XY coordinates of a custom curve, if needed.

Example of use:
fourier_main;

--------------------------------------------------------------------------------------------------------
The main function is 'fourier_epicycles(curve_x, curve_y, no_circles)', the rest of them are required to plot the GUI. Thus, this function can be used separately. Basically, the function converts XY coordinates in a complex vector Z = X + iY. Afterwards, it computes the Discrete Fourier Transform of Z, which is used to derive the radii (abs(Z)), frequency (index) and initial phase (angle(Z)) of each circle.

Input parameters:
- curve_x: X coordinates of the curve.
- curve_y: Y coordinates of the curve.
- no_circles: (Optional) Maximum number of circles. The maximum drawing accuracy is reached if the no_circles is exactly the number of points of the curve.

Example of use:
load('heart.mat'); fourier_epicycles(curve_x, curve_y);
