import Foundation
import Network

@available(macOS 10.14, *)
class Client {
    let connection: ClientConnection
    let host: NWEndpoint.Host
    let destPort: NWEndpoint.Port
    let srcPort: NWEndpoint.Port?
    
    init(host: String, destPort: UInt16, srcPort: UInt16?) {
        self.host = NWEndpoint.Host(host)
        self.destPort = NWEndpoint.Port(rawValue: destPort)!
        let nwConnection: NWConnection
        let params = NWParameters(tls: nil, tcp: .init())
        if let port = srcPort {
            self.srcPort = NWEndpoint.Port(rawValue: port)!
            params.requiredLocalEndpoint = NWEndpoint.hostPort(host: .ipv4(.any), port: self.srcPort!)
        } else {
            self.srcPort = nil
        }
        nwConnection = NWConnection(host: self.host, port: self.destPort, using: params)
        connection = ClientConnection(nwConnection: nwConnection)
    }
    
    func start() {
        print("Client started \(host) \(destPort)")
        connection.didStopCallback = didStopCallback(error:)
        connection.start()
    }
    
    func stop() {
        connection.stop()
    }
    
    func send(data: Data) {
        connection.send(data: data)
    }
    
    func didStopCallback(error: Error?) {
        if error == nil {
            exit(EXIT_SUCCESS)
        } else {
            exit(EXIT_FAILURE)
        }
    }
}
