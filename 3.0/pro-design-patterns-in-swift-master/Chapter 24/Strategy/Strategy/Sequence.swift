final class Sequence {
    fileprivate var numbers:[Int];
    
    init(_ numbers:Int...) {
        self.numbers = numbers;
    }
    
    func addNumber(_ value:Int) {
        self.numbers.append(value);
    }
    
    func compute(_ strategy:Strategy) -> Int {
        return strategy.execute(self.numbers);
    }
}
