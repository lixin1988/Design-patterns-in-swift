protocol View {
    
    func execute();
}

class PersonListView : View {
    fileprivate let people:[Person];
    
    init(data:[Person]) {
        self.people = data;
    }
    
    func execute() {
        for person in people {
            print("\(person.name) : \(person.city)");
        }
    }
}

class CityListView : View {
    fileprivate let cities:[String];
    
    init(data:[String]) {
        self.cities = data;
    }
    
    func execute() {
        for city in self.cities {
            print("City: \(city)");
        }
    }
}

