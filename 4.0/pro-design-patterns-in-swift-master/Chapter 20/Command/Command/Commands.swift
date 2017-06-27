protocol Command {
    func execute(_ receiver:Any);
}

class CommandWrapper : Command {
    fileprivate let commands:[Command];
    
    init(commands:[Command]) {
        self.commands = commands;
    }
    
    func execute(_ receiver:Any) {
        for command in commands {
            command.execute(receiver);
        }
    }
}

class GenericCommand<T> : Command {
    fileprivate var instructions: (T) -> Void;
    
    init(instructions: @escaping (T) -> Void) {
        self.instructions = instructions;
    }
    
    func execute(_ receiver:Any) {
        if let safeReceiver = receiver as? T {
            instructions(safeReceiver);
        } else {
            fatalError("Receiver is not expected type");
        }
    }
    
    class func createCommand(_ instuctions: @escaping (T) -> Void) -> Command {
        return GenericCommand(instructions: instuctions);
    }
}
