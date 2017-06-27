var comms = Communicator(channel: Channel.Channels.satellite);

comms.sendCleartextMessage("Hello!");
comms.sendSecureMessage("This is a secret");
comms.sendPriorityMessage("This is important");
