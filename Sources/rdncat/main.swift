import Foundation


if #available(macOS 10.14, *) {
var isServer = false

func initServer(port: UInt16) {
    let server = Server(port: port)
    try! server.start()
}

func initClient(server: String, destPort: UInt16, srcPort: UInt16? = nil) {
    let client = Client(host: server, destPort: destPort, srcPort: srcPort)
    client.start()
    while(true) {
      var command = readLine(strippingNewline: true)
      switch (command){
      case "CRLF":
          command = "\r\n"
      case "RETURN":
          command = "\n"
      case "exit":
          client.stop()
      default:
          break
      }
      client.connection.send(data: (command?.data(using: .utf8))!)
    }
}

let firstArgument = CommandLine.arguments[1]
switch (firstArgument) {
case "-l":
    isServer = true
default:
    break
}

if isServer {
    if let port = UInt16(CommandLine.arguments[2]) {
      initServer(port: port)
    } else {
        print("Error invalid port")
    }
} else {
    let server = CommandLine.arguments[1]
    if let destPort = UInt16(CommandLine.arguments[2]) {
      if CommandLine.arguments.count >= 4 {
        let srcPort = UInt16(CommandLine.arguments[3])
        initClient(server: server, destPort: destPort, srcPort: srcPort)
      } else {
        initClient(server: server, destPort: destPort)
      }
    } else {
        print("Error invalid destination port")
    }
}
RunLoop.current.run()

} else {
  let stderr = FileHandle.standardError
  let message = "Requires macOS 10.14 or newer"
  stderr.write(message.data(using: .utf8)!)
  exit(EXIT_FAILURE)
}
