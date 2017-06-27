class NewCoDirectoryAdapter : EmployeeDataSource {
    fileprivate let directory:NewCoDirectory;
    
    init() {
        directory = NewCoDirectory();
    }
    
    var employees:[Employee] {
        return directory.getStaff().values.map({ sv -> Employee in
            return Employee(name: sv.getName(), title: sv.getJob());
        });
    }
    
    func searchByName(_ name:String) -> [Employee] {
        return createEmployees(filter: {(sv:NewCoStaffMember) -> Bool in
            return sv.getName().range(of: name) != nil;
        });
    }
    
    func searchByTitle(_ title:String) -> [Employee] {
        return createEmployees(filter: {(sv:NewCoStaffMember) -> Bool in
            return sv.getJob().range(of: title) != nil;
        });
    }
    
    fileprivate func createEmployees(filter filterClosure:((NewCoStaffMember) -> Bool))
        -> [Employee] {
            return directory.getStaff().values.filter(filterClosure).map({entry -> Employee in
                    return Employee(name: entry.getName(), title: entry.getJob());
            });
    }
}
