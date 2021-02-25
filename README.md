# rdncat

### Example Setup

On a macOS system, listen on a local port:
```sh
nc -vlp 1337
```

Then from this directory, connect:
```sh
swift run rdncat localhost 1337 # use random source port, connect to localhost:1337
swift run rdncat localhost 1337 2345 # set source port to 2345, connect to localhost:1337
```

In the `nc` (netcat) window, you should see the connection like so, where `5678` is the random source port:
```
Connection from 127.0.0.1:5678
```

And in the `rdncat` window, you'll see the source port outputted as well:
```
Connected from Optional(127.0.0.1:5678)
```

--------

A Client-Server command-line tool that provides an echo server for `TCP` connections and a client to connect to any server accepting `TCP` connections.

The tool was created using [Apple's `NWFramework`](https://developer.apple.com/documentation/network).

You can read the article explaining the command-line tool, here:

[https://rderik.com/blog/building-a-server-client-aplication-using-apple-s-network-framework/](https://rderik.com/blog/building-a-server-client-aplication-using-apple-s-network-framework/)


You can also get the "macOS network programming in Swift" guide. It includes more topics on building network applications on macOS, including:

+ BSD Sockets in Swift
+ Apple's Network.framework
+ SwiftNIO

You can get it from the following link:

[rderik.com - Guides](https://rderik.com/guides/)
