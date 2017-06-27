import Foundation;

protocol Shape {
    func accept(_ visitor:Visitor);
}

protocol Visitor {
    func visit(_ shape:Circle);
    func visit(_ shape:Square);
    func visit(_ shape:Rectangle);
}

class AreaVisitor : Visitor {
    var totalArea:Float = 0;
    
    func visit(_ shape: Circle) {
        totalArea += (3.14 * powf(shape.radius, 2));
    }
    
    func visit(_ shape: Square) {
        totalArea += powf(shape.length, 2);
    }
    
    func visit(_ shape: Rectangle) {
        totalArea += (shape.xLen * shape.yLen);
    }
}

class EdgesVisitor : Visitor {
    var totalEdges = 0;
    
    func visit(_ shape: Circle) {
        totalEdges += 1;
    }
    
    func visit(_ shape: Square) {
        totalEdges += 4;
    }
    
    func visit(_ shape: Rectangle) {
        totalEdges += 4;
    }
}
