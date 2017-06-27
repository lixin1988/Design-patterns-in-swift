import Foundation

final class Library {
  private var books:[Book];
  private let pool:Pool<Book>;
  
  private init(stockLevel:Int) {
    books = [Book]();
    for count in 1 ... stockLevel {
      books.append(Book(author: "Dickens, Charles", title: "Hard Times",
                        stock: count))
    }
    pool = Pool<Book>(items:books);
  }
  
  private class var singleton:Library {
    struct SingletonWrapper {
      static let singleton = Library(stockLevel:2);
    }
    return SingletonWrapper.singleton;
  }
  
  class func checkoutBook(reader:String) -> Book? {
    let book = singleton.pool.getFromPool();
    book?.reader = reader;
    book?.checkoutCount = (book?.checkoutCount)!+1;
    return book;
  }
  
  class func returnBook(book:Book) {
    book.reader = nil;
    singleton.pool.returnToPool(item: book);
  }
  
  class func printReport() {
    for book in singleton.books {
      print("...Book#\(book.stockNumber)...");
      print("Checked out \(book.checkoutCount) times");
      if (book.reader != nil) {
        print("Checked out to \(book.reader!)");
      } else {
        print("In stock");
      }
    }
  }
}
