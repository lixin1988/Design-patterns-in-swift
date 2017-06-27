protocol MetaObserver : Observer {
    func notifySubjectCreated(_ subject:Subject);
    func notifySubjectDestroyed(_ subject:Subject);
}

class MetaSubject : SubjectBase, MetaObserver {
    
    func notifySubjectCreated(_ subject: Subject) {
        sendNotification(Notification(type: NotificationTypes.SUBJECT_CREATED,
            data: subject));
    }
    
    func notifySubjectDestroyed(_ subject: Subject) {
        sendNotification(Notification(type: NotificationTypes.SUBJECT_DESTROYED,
            data: subject));
    }
    
    class var sharedInstance:MetaSubject {
        struct singletonWrapper {
            static let singleton = MetaSubject();
        }
        return singletonWrapper.singleton;
    }
    
    func notify(_ notification:Notification) {
        // do nothing - required for Observer conformance
    }
}

class ShortLivedSubject : SubjectBase {
    
    override init() {
        super.init();
        MetaSubject.sharedInstance.notifySubjectCreated(self);
    }
    
    deinit {
        MetaSubject.sharedInstance.notifySubjectDestroyed(self);
    }
}
