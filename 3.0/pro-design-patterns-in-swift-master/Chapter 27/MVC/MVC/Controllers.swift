class ControllerBase {
    fileprivate let repository:Repository;
    fileprivate let nextController:ControllerBase?;
    
    init(repo:Repository, nextController:ControllerBase?) {
        self.repository = repo;
        self.nextController = nextController;
    }
    
    func handleCommand(_ command:Command, data:[String]) -> View? {
        return nextController?.handleCommand(command, data:data);
    }
}

class PersonController : ControllerBase {
    
    override func handleCommand(_ command: Command,data:[String]) -> View? {
        switch command {
        case .LIST_PEOPLE:
            return listAll();
        case .ADD_PERSON:
            return addPerson(data[0], city: data[1]);
        case .DELETE_PERSON:
            return deletePerson(data[0]);
        case .UPDATE_PERSON:
            return updatePerson(data[0], newCity:data[1]);
        case .SEARCH:
            return search(data[0]);
        default:
            return super.handleCommand(command, data: data);
        }
    }
    
    fileprivate func listAll() -> View {
        return PersonListView(data:repository.People);
    }
    
    fileprivate func addPerson(_ name:String, city:String) -> View {
        repository.addPerson(Person(name, city));
        return listAll();
    }
    
    fileprivate func deletePerson(_ name:String) -> View {
        repository.removePerson(name);
        return listAll();
    }
    
    fileprivate func updatePerson(_ name:String, newCity:String) -> View {
        repository.updatePerson(name, newCity: newCity);
        return listAll();
    }
    
    fileprivate func search(_ term:String) -> View {
        let termLower = term.lowercased();
        let matches = repository.People.filter({ person in
            return person.name.lowercased().range(of: termLower) != nil
                || person.city.lowercased().range(of: termLower) != nil});
        return PersonListView(data: matches);
    } 
}

class CityController : ControllerBase {
    
    override func handleCommand(_ command: Command, data: [String]) -> View? {
        switch command {
        case .LIST_CITIES:
            return listAll();
        case .SEARCH_CITIES:
            return search(data[0]);
        case .DELETE_CITY:
            return delete(data[0]);
        default:
            return super.handleCommand(command, data: data);
        }
    }
    
    fileprivate func listAll() -> View {
        return CityListView(data: repository.People.map({$0.city}).unique());
    }
    
    fileprivate func search(_ city:String) -> View {
        let cityLower = city.lowercased();
        let matches:[Person] = repository.People
            .filter({ $0.city.lowercased() == cityLower });
        return PersonListView(data: matches);
    }
    
    fileprivate func delete(_ city:String) -> View {
        let cityLower = city.lowercased();
        let toDelete = repository.People
            .filter({ $0.city.lowercased() == cityLower });
        for person in toDelete {
            repository.removePerson(person.name);
        }
        return PersonListView(data: repository.People);
    }
}
