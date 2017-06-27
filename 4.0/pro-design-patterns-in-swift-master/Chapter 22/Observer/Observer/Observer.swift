import Foundation;

enum NotificationTypes : String {
    case AUTH_SUCCESS = "AUTH_SUCCESS";
    case AUTH_FAIL = "AUTH_FAIL";
    case SUBJECT_CREATED = "SUBJECT_CREATE";
    case SUBJECT_DESTROYED = "SUBJECT_DESTROYED";    
}

class Notification {
    let type:NotificationTypes;
    let data:Any?;
    
    init(type:NotificationTypes, data:Any?) {
    self.type = type; self.data = data;
    }
}

class AuthenticationNotification: Notification {
    
    init(user:String, success:Bool) {
    super.init(type: success ? NotificationTypes.AUTH_SUCCESS
    : NotificationTypes.AUTH_FAIL, data: user);
    }
    
    var userName : String? {
    return self.data as! String?;
    }
    
    var requestSuccessed : Bool {
    return self.type == NotificationTypes.AUTH_SUCCESS;
    }
}

protocol Observer : class {
    func notify(_ notification:Notification);
}

protocol Subject {
    func addObservers(_ observers:Observer...);
    func removeObserver(_ observer:Observer);
}

private class WeakObserverReference {
    weak var observer:Observer?;
    
    init(observer:Observer) {
        self.observer = observer;
    }
}

class SubjectBase : Subject {
    fileprivate var observers = [WeakObserverReference]();
    fileprivate var collectionQueue = DispatchQueue(label: "colQ",
        attributes: DispatchQueue.Attributes.concurrent);
    
    func addObservers(_ observers: Observer...) {
        self.collectionQueue.sync(flags: .barrier, execute: { () in
            for newOb in observers {
                self.observers.append(WeakObserverReference(observer: newOb));
            }
        });
    }
    
    func removeObserver(_ observer: Observer) {
        self.collectionQueue.sync(flags: .barrier, execute: { () in
            self.observers = filter(self.observers, { weakref in
                return weakref.observer != nil && weakref.observer !== observer;
            });
        });
    }
    
    func sendNotification(_ notification:Notification) {
        self.collectionQueue.sync(execute: { () in
            for ob in self.observers {
                ob.observer?.notify(notification);
            }
        });
    }
}

