// PAGE 1

import CoreGraphics

// Code from WWDC15 - 408_protocol_oriented_programming, the infamous Crustacean
let twoPi = CGFloat.pi * 2

/*
 A protocol for types that respond to primitive graphics commands. We start with the basics:
 */
protocol Renderer {
    func move(to position: CGPoint)
    
    func line(to position: CGPoint)
    
    func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat)
}

/*
 A Renderer that prints to the console.
 
 Printing the drawing commands comes in handy for debugging; you can't always see everything by looking at graphics.
 */
struct TestRenderer: Renderer {
    func move(to position: CGPoint) {
        debugPrint("move(to: CGPoint(\(position.x), \(position.y))")
    }
    
    func line(to position: CGPoint) {
        debugPrint("line(to: CGPoint(\(position.x), \(position.y))")
    }
    
    func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        debugPrint("arc(at: \(center), radius: \(radius)," + " startAngle: \(startAngle), endAngle: \(endAngle)")
    }
}

/*
 An element of a Diagram
 */
protocol Drawable {
    /// Issues drawing commands to `renderer` to represent `self`
    func draw(into renderer: Renderer)
}

/*
 Basic Drawables
 */
struct Polygon: Drawable {
    var corners: [CGPoint] = []
    
    func draw(into renderer: Renderer) {
        renderer.move(to: corners.last!)
        
        for p in corners {
            renderer.line(to: p)
        }
    }
}

struct Circle: Drawable {
    var center: CGPoint
    var radius: CGFloat
    
    func draw(into renderer: Renderer) {
        renderer.arc(at: center, radius: radius, startAngle: 0.0, endAngle: twoPi)
    }
}

/*
 Now a Diagram, which contains a heterogeneous array of Drawables
*/
struct Diagram: Drawable {
    var elements: [Drawable] = []
    
    func draw(into renderer: Renderer) {
        for f in elements {
            f.draw(into: renderer)
        }
    }
    
    mutating func add(other: Drawable) {
        elements.append(other)
    }
}

/*
 Retroactive Modeling:
 Here we extend CGContext to make it a Renderer. This would not be possible if Renderer were a base class rather than a protocol.
 */
extension CGContext: Renderer {
    func line(to position: CGPoint) {
        addLine(to: position)
    }
    
    func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        let arc = CGMutablePath()
        arc.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        addPath(arc)
    }
}

var circle = Circle(center: CGPoint(x: 187.5, y: 333.5), radius: 93.75)

var triangle = Polygon(corners: [
    CGPoint(x: 187.5, y: 427.25),
    CGPoint(x: 268.69, y: 286.625),
    CGPoint(x: 106.31, y: 286.625)])

var diagram = Diagram(elements: [circle, triangle])

/*
 Putting a Diagram inside itself

 If Diagrams had reference semantics, we could easily cause an infinite recursion in drawing just by inserting a Diagram into its own array of Drawables.  However, value semantics make this operation entirely benign.

 To ensure that the result can be observed visually, we need to alter the inserted diagram somehow; otherwise, all the elements would line up exactly with existing ones.  This is a nice demonstration of generic adapters in action.

 We start by creating a Drawable wrapper that applies scaling to some underlying Drawable instance; then we can wrap it around the diagram.
 */


/// A `Renderer` that passes drawing commands through to some `base` renderer, after applying uniform scaling to all distances.
struct ScaledRenderer: Renderer {
    let base: Renderer
    let scale: CGFloat
    
    func move(to position: CGPoint) {
        base.move(to: CGPoint(x: position.x * scale, y: position.y * scale))
    }
    
    func line(to position: CGPoint) {
        base.line(to: CGPoint(x: position.x * scale, y: position.y * scale))
    }
    
    func arc(at center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        let scaledCenter = CGPoint(x: center.x * scale, y: center.y * scale)
        base.arc(at: scaledCenter, radius: radius * scale, startAngle: startAngle, endAngle: endAngle)
    }
}

/// A `Drawable` that scales an instance of `Base`
struct Scaled<Base: Drawable>: Drawable {
    var scale: CGFloat
    var subject: Base
    
    func draw(into renderer: Renderer) {
        subject.draw(into: ScaledRenderer(base: renderer, scale: scale))
    }
}

// Now insert it
diagram.elements.append(Scaled(scale: 0.5, subject: diagram))
diagram.draw(into: TestRenderer())


/// Also, show it in the view. To see the result, View>Assistant Editor>Show Assistant Editor (opt-cmd-Return).
showCoreGraphicsDiagram(title: "Diagram") { diagram.draw(into: $0) }
