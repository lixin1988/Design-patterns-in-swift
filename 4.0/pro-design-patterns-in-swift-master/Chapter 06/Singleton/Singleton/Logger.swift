import Foundation;

let globalLogger = Logger();

final class Logger {
  private var data = [String]()
  private let arrayQ = DispatchQueue(label:"arrayQ");
  
  init() {
    // do nothing - required to stop instances being
    // created by code in other files
  }
  
  func log(msg:String) {
    arrayQ.async {
      self.data.append(msg);
    }
  }
  
  func printLog() {
    for msg in data {
      print("Log: \(msg)");
    }
  }
}
