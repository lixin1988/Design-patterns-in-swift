import Foundation

class Pool<T> {
  private var data = [T]();
  private let arrayQ = DispatchQueue(label:"arrayQ");
  private let semaphore :DispatchSemaphore
  
  init(items:[T]) {
    data.reserveCapacity(data.count);
    for item in items {
      data.append(item);
    }
    self.semaphore = DispatchSemaphore(value:items.count);
  }
  
  func getFromPool() -> T? {
    var result:T?;
    
    self.semaphore.wait()
    arrayQ.async {
      result = self.data.remove(at: 0);
    }
    
    return result;
  }
  
  func returnToPool(item:T) {
    arrayQ.async {
      self.data.append(item);
      self.semaphore.signal();
    }
  }
}
