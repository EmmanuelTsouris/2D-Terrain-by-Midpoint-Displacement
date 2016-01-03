# 2D Terrain by Midpoint Displacement in SWIFT
SWIFT 2.x, Xcode 7.x, Mac OS Sample

## The Article
I was looking at different methods for generating 2D terrain and came accross this article by Loktar:

Simple 2d Terrain With Midpoint Displacement
http://www.somethinghitme.com/2013/11/11/simple-2d-terrain-with-midpoint-displacement/

I rewrote the JavaScript sample from the article in SWIFT (which was suprisingly easy). While there are other methods for 2D terrain generation, I thought this was a very nice implementation of midpoint displacement.

## What Does this Do?

The app generates an array of points representing the terrain. We then use the path to create an SKShapeNode. Clicking on the screen will generate a new node.

