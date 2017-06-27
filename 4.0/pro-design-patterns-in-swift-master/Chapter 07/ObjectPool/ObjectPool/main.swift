import Foundation

var queue = DispatchQueue(label:"workQ", attributes:[.concurrent])
var group = DispatchGroup()

print("Starting...")

for i in 1 ... 20 {
  queue.async(group: group, execute: {
    let book = Library.checkoutBook(reader: "reader#\(i)");
    if (book != nil) {
      Thread.sleep(forTimeInterval: TimeInterval(Int(arc4random())%3))
      Library.returnBook(book: book!);
    }
  })
}

group.wait()

print("All blocks complete");

Library.printReport();
