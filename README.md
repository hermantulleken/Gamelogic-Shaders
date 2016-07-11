# Shaders
This repository contains shaders for Unity, useful for 2D games or interface components.

UnlitGradientShader is useful for colorizing textures.

It takes a texture, and three colors. The texture is interpreted as greyscale. The resulting colors are interpolated between either the main color and the low color (if the grey is less than 0.5) or between the main color and the high color (if the grey is larger than 0.5). When the low and high colors are black and white respectively, the effect is a normal colorize effect.

The other shaders are meant to render shapes in a single color. The following shapes are provided:
  * circle
  * ring
  * square ring
  * regular hexagon 
  * regular hexagon ring
  * equilateral triangle
  * equilateral triangle ring
  * regular six-pointed star
  * regular six-pointed star ring
  * rose
  * asteroid

The shapes are antialised (the antilaising is reolsution independant).

The math for hexagons, triangles, and stars is explained in this document: http://www.gamelogic.co.za/downloads/HexMath2.pdf
