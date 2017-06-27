import Foundation;

class Calculator {
    fileprivate(set) var total = 0;
    typealias CommandClosure = ((Calculator) -> Void);
    fileprivate var history = [CommandClosure]();
    fileprivate var queue = DispatchQueue(label: "arrayQ", attributes: []);
    
    func add(_ amount:Int) {
        addMacro(Calculator.add, amount: amount);
        total += amount;
    }
    
    func subtract(_ amount:Int) {
        addMacro(Calculator.subtract, amount: amount);
        total -= amount;
    }
    
    func multiply(_ amount:Int) {
        addMacro(Calculator.multiply, amount: amount);
        total = total * amount;
    }
    
    func divide(_ amount:Int) {
        addMacro(Calculator.divide, amount: amount);
        total = total / amount;
    }
    
    fileprivate func addMacro(_ method:@escaping (Calculator) -> (Int) -> Void, amount:Int) {
        self.queue.sync(execute: {() in
            self.history.append({ calc in  method(calc)(amount)});
        });
    }
    
    func getMacroCommand() -> ((Calculator) -> Void) {
        var commands = [CommandClosure]();
        queue.sync(execute: {() in
            commands = self.history
        });
        return { calc in
            if (commands.count > 0) {
                for index in 0 ..< commands.count {
                    commands[index](calc);
                }
            }
        };
    }
}
