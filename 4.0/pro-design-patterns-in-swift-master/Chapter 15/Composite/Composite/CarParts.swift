protocol CarPart {
    
    var name:String { get };
    var price:Float { get };
    
    func addPart(part:CarPart)
    func removePart(part:CarPart)
}

class Part : CarPart {
    let name:String;
    let price:Float;
    
    init(name:String, price:Float) {
        self.name = name; self.price = price;
    }
    
    func addPart(part: CarPart) {
        // do nothing
    }
    
    func removePart(part: CarPart) {
        // do nothing
    }
}


class CompositePart : CarPart {
    let name:String;
    private var parts:[CarPart];
    
    init(name:String, parts:CarPart...) {
        self.name = name; self.parts = parts;
    }
    
    var price:Float {
        return parts.reduce(0, combine: {subtotal, part in
            return subtotal + part.price;
        });
    }
    
    func addPart(part:CarPart) {
        parts.append(part);
    }
    
    func removePart(part:CarPart) {
        for index in 0 ..< parts.count {
            if (parts[index].name  == part.name) {
                parts.removeAtIndex(index);
                break;
            }
        }
    }
}

