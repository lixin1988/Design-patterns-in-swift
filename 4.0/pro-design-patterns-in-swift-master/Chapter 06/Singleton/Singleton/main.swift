import Foundation

var server = BackupServer.server;

let queue = DispatchQueue(label:"workQueue", attributes:[.concurrent]);
let group = DispatchGroup();

for _ in 0 ..< 100 {
  queue.async(group: group, execute: {
    BackupServer.server.backup(
      item: DataItem(type: DataItem.ItemType.Email, data: "bob@example.com"))
  })
  
}

group.wait(timeout: .now());

print("\(server.getData().count) items were backed up");
