protocol Message {
    init (message:String);
    func prepareMessage();
    var contentToSend:String { get };
}

class ClearMessage : Message {
    var message:String;
    
    required init(message:String) {
        self.message = message;
    }
    
    func prepareMessage() {
        // no action required
    }
    
    var contentToSend:String {
        return message;
    }
}

class EncryptedMessage : Message {
    var clearText:String;
    var cipherText:String?;
    
    required init(message:String) {
        self.clearText = message;
    }
    
    func prepareMessage() {
        cipherText = String(Array(clearText.characters.reverse()));
    }
    
    var contentToSend:String {
        return cipherText!;
    }
}
