import Foundation

func == (lhs:Person, rhs:Person) -> Bool {
    return lhs.name == rhs.name && lhs.city == rhs.city;
}

class Person : Equatable {
    var name:String;
    var city:String;
    
    init(_ name:String, _ city:String) {
        self.name = name;
        self.city = city;
    }
    
    var description: String {
        return "Name: \(self.name), City: \(self.city)";
    }
}

protocol Repository {
    
    var People:[Person] { get };
    
    func addPerson(_ person:Person);
    func removePerson(_ name:String);
    func updatePerson(_ name:String, newCity:String);
}

class MemoryRepository : Repository {
    fileprivate var peopleArray:[Person];
    
    init() {
        peopleArray = [
            Person("Bob", "New York"),
            Person("Alice", "London"),
            Person("Joe", "Paris")];
    }
    
    var People:[Person] {
        return self.peopleArray;
    }
    
    func addPerson(_ person: Person) {
        self.peopleArray.append(person);
    }
    
    func removePerson(_ name: String) {
        let nameLower = name.lowercased();
        self.peopleArray = peopleArray
            .filter({$0.name.lowercased() != nameLower});
    }
    
    func updatePerson(_ name: String, newCity: String) {
        let nameLower = name.lowercased();
        let test:(Person) -> Bool = {p in return p.name.lowercased() == nameLower};
        if let person = peopleArray.first(test) {
            person.city = newCity;
        }
    }
}
