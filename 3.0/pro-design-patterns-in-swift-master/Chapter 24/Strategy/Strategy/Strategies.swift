protocol Strategy {
    func execute(_ values:[Int]) -> Int;
}

class ClosureStrategy : Strategy {
    fileprivate let closure:([Int]) -> Int;
    
    init(_ closure:@escaping ([Int]) -> Int) {
    self.closure = closure;
    }
    
    func execute(_ values: [Int]) -> Int {
    return self.closure(values);
    }
}

class SumStrategy: Strategy {
    
    func execute(_ values: [Int]) -> Int {
        return values.reduce(0, {$0 + $1});
    }
}

class MultiplyStrategy: Strategy {
    
    func execute(_ values: [Int]) -> Int {
        return values.reduce(1, {$0 * $1});
    }
}
