//
//  GameScene.swift
//  2D Terrain by Midpoint Displacement
//
//  Created by Emmanuel Tsouris on 1/3/16.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Emmanuel Tsouris
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import SpriteKit

class GameScene: SKScene {
    
    let terrainGenerator = TerrainGenerator()
    var terrainNode: SKShapeNode!
    
    override func didMoveToView(view: SKView) {

        terrainNode = buildTerrainNode(1.0)
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)
        
        terrainNode.removeFromParent()
        terrainNode = buildTerrainNode(location.y)
        self.addChild(terrainNode)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func buildTerrainNode(height: CGFloat) -> SKShapeNode {
        
        // How much to displace the points
        let displacement = height * 0.5
        
        // Width and Height of the Terrain
        let terrainSize = CGSize(width: self.size.width, height: height)
        print("terrainSize: \(terrainSize)")
        
        // get the points
        var terPoints = terrainGenerator.createTerrain(terrainSize, displace: displacement, roughness: 0.4);
        
        terrainNode = SKShapeNode()
        
        let pathToDraw = CGPathCreateMutable()
        
        // draw the points
        CGPathMoveToPoint(pathToDraw, nil, 0, 0)
        CGPathAddLineToPoint(pathToDraw, nil, 0, terPoints[0])
        
        for var t = 1; t < terPoints.count; t++ {
            CGPathAddLineToPoint(pathToDraw, nil, CGFloat(t), terPoints[t])
        }
        
        // finish creating the rect so we can fill it
        CGPathAddLineToPoint(pathToDraw, nil, self.size.width, 0)
        
        CGPathCloseSubpath(pathToDraw)
        
        // Add the path to the node
        terrainNode.path = pathToDraw
        
        // Colors
        terrainNode.strokeColor = SKColor.redColor()
        terrainNode.fillColor = SKColor.blackColor()
        
        return terrainNode

    }
}
