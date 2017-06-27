import Foundation;

class Subject : NSObject {
    dynamic var counter = 0;
}

class Observer : NSObject {
    
    init(subject:Subject) {
        super.init();
        subject.addObserver(self, forKeyPath: "counter",
            options: NSKeyValueObservingOptions.new, context: nil);
    }
    
    override func observeValue(forKeyPath keyPath: String, of object: AnyObject,
        change: [AnyHashable: Any], context: UnsafeMutableRawPointer) {
            
            println("Notification: \(keyPath) = \(change[NSKeyValueChangeKey.newKey]!)");
    }
}

let subject = Subject();
let observer = Observer(subject: subject);
subject.counter += 1;
subject.counter = 22;
