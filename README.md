# GODOT_CUSTOM_LIGHTING
Custom 2D lighting in Godot 4.0 beta 10 using palette swapping shaders.
I decided to not upload the entire project since it was an experimental mess :)

In short, it works by having all sprites being drawn in grayscale and then sampling each texture for different grayscale-values. Then we
replace the grayscale-value for each pixel to a set color. This gives us full control of the color for the said value. In script we can change
each grayscale color as a function of the distance to a light source and have its emitted light color decide which colors to affect in neighbouring
sprites.

Demo vid at: https://youtu.be/d4rsFTs34Ww

<p align="center">
  <img src="https://github.com/matlin975/GODOT_CUSTOM_LIGHTING/blob/main/pics/demo1.png"/>
</p>

<p align="center">
  <img src="https://github.com/matlin975/GODOT_CUSTOM_LIGHTING/blob/main/pics/demo2.png"/>
</p>

<p align="center">
  <img src="https://github.com/matlin975/GODOT_CUSTOM_LIGHTING/blob/main/pics/demo3.png"/>
</p>

<p align="center">
  <img src="https://github.com/matlin975/GODOT_CUSTOM_LIGHTING/blob/main/pics/demo4.png"/>
</p>
