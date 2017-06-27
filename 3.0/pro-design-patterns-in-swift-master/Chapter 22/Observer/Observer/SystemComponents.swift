class ActivityLog : Observer {
    
    func notify(_ notification:Notification) {
        println("Auth request for \(notification.type.rawValue) "
            + "Success: \(notification.data!)");
    }
    
    func logActivity(_ activity:String) {
        println("Log: \(activity)");
    }
}

class FileCache : Observer {
    func notify(_ notification:Notification) {
        if let authNotification = notification as? AuthenticationNotification {
            if (authNotification.requestSuccessed
                && authNotification.userName != nil) {
                    loadFiles(authNotification.userName!);
            }
        }
    }
    
    func loadFiles(_ user:String) {
        println("Load files for \(user)");
    }
}

class AttackMonitor : MetaObserver {
    
    func notifySubjectCreated(_ subject: Subject) {
        if (subject is AuthenticationManager) {
            subject.addObservers(self);
        }
    }
    
    func notifySubjectDestroyed(_ subject: Subject) {
        subject.removeObserver(self);
    }
    
    func notify(_ notification: Notification) {
        monitorSuspiciousActivity
            = (notification.type == NotificationTypes.AUTH_FAIL);
    }
    
    var monitorSuspiciousActivity: Bool = false {
        didSet {
            println("Monitoring for attack: \(monitorSuspiciousActivity)");
        }
    }
}

