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
        if let port = srcPort {
            self.srcPort = NWEndpoint.Port(rawValue: port)!
            let params = NWParameters(tls: nil, tcp: .init())
            params.requiredLocalEndpoint = NWEndpoint.hostPort(host: .ipv4(.any), port: self.srcPort!)
            let nwConnection = NWConnection(host: self.host, port: self.destPort, using: params)
            connection = ClientConnection(nwConnection: nwConnection)
        } else {
            self.srcPort = nil
            let nwConnection = NWConnection(host: self.host, port: self.destPort, using: .tcp)
            connection = ClientConnection(nwConnection: nwConnection)
        }
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
