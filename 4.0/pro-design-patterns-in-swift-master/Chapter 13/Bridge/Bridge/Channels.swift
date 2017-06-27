class Channel {
    
    enum Channels {
        case landline;
        case wireless;
        case satellite;
    }
    
    class func getChannel(_ channelType:Channels) -> Channel {
        switch channelType {
        case .landline:
            return LandlineChannel();
        case .wireless:
            return WirelessChannel();
        case .satellite:
            return SatelliteChannel();
        }
    }
    
    func sendMessage(_ msg:Message) {
        fatalError("Not implemented");
    }
}

class LandlineChannel : Channel {
    override func sendMessage(_ msg: Message) {
        print("Landline: \(msg.contentToSend)", terminator: "");
    }
    
}

class WirelessChannel : Channel {
    override func sendMessage(_ msg: Message) {
        print("Wireless: \(msg.contentToSend)", terminator: "");
    }
}
