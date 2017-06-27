import Foundation

let repository = MemoryRepository();

let controllerChain = PersonController(repo: repository, nextController:
    CityController(repo: repository, nextController: nil));

var stdIn = FileHandle.standardInput;
var command = Command.LIST_PEOPLE;
var data = [String]();

while (true) {
    
    if let view = controllerChain.handleCommand(command, data:data) {
        view.execute();
        print("--Commands--");
        for command in Command.ALL {
            print(command.rawValue);
        }
    } else {
        fatalError("No view");
    }
    
    let input:String = String(data: stdIn.availableData,
        encoding: .utf8) ?? "";
    
    let inputArray:[String] = input.split();
    
    if (inputArray.count > 0) {
        command = Command.getFromInput(inputArray.first!) ?? Command.LIST_PEOPLE;
        if (inputArray.count > 1) {
            data = Array(inputArray[1...inputArray.count - 1]);
        } else {
            data = [];
        }
    }
    print("Command \(command.rawValue) Data \(data)");
}
