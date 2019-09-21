# Drawing-with-Fourier-Epicycles
MATLAB GUI that computes the required epicycles to match a custom drawing by using DFTs

# NOTE: Please vote my contribution in MathWorks if you liked it! Thanks!


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
