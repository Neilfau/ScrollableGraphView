
import UIKit

// MARK: Delegate definition that provides the data required by the drawing layers.
internal protocol ScrollableGraphViewDrawingDelegate {
    func intervalForActivePoints() -> CountableRange<Int>
    func rangeForActivePoints() -> (min: Double, max: Double)
    func graphPoint(forIndex index: Int) -> GraphPoint
    
    func currentPath() -> UIBezierPath
}


internal class ScrollableGraphViewDrawingLayer : CAShapeLayer {
    
    var offset: CGFloat = 0 {
        didSet {
            offsetDidChange()
        }
    }
    
    var viewportWidth: CGFloat = 0
    var viewportHeight: CGFloat = 0
    var zeroYPosition: CGFloat = 0
    
    var graphViewDrawingDelegate: ScrollableGraphViewDrawingDelegate? = nil
    
    var active = true
    
    init(viewportWidth: CGFloat, viewportHeight: CGFloat, offset: CGFloat = 0) {
        super.init()
        
        self.viewportWidth = viewportWidth
        self.viewportHeight = viewportHeight
        
        self.frame = CGRect(origin: CGPoint(x: offset, y: 0), size: CGSize(width: self.viewportWidth, height: self.viewportHeight))
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // Get rid of any animations.
        self.actions = ["position" : NSNull(), "bounds" : NSNull()]
    }
    
    private func offsetDidChange() {
        self.frame.origin.x = offset
        self.bounds.origin.x = offset
    }
    
    func updatePath() {
        fatalError("updatePath needs to be implemented by the subclass")
    }
}
