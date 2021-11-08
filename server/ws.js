var WebSocketServer = require('ws').Server
var wss = new WebSocketServer({
  port: 8765,
  host: '0.0.0.0',
  perMessageDeflate: {
    zlibDeflateOptions: {
      // See zlib defaults.
      chunkSize: 1024,
      memLevel: 7,
      level: 3
    },
    zlibInflateOptions: {
      chunkSize: 10 * 1024
    },
    // Other options settable:
    clientNoContextTakeover: true, // Defaults to negotiated value.
    serverNoContextTakeover: true, // Defaults to negotiated value.
    serverMaxWindowBits: 10, // Defaults to negotiated value.
    // Below options specified as default values.
    concurrencyLimit: 10, // Limits zlib concurrency for perf.
    threshold: 1024 // Size (in bytes) below which messages
    // should not be compressed if context takeover is disabled.
  }
});
const users_cache = new Map();

wss.on('connection', function (ws, req, client) {
  
  var clientID = ws._socket._handle.fd;
  
  ws.id = clientID

  console.log(client + ", joined to room " + req.headers.room);

  users_cache.set(clientID, req.headers.room)
  console.log(users_cache)
  ws.on('message', function (message) {
    console.log('received: %s', message)
  
    wss.clients.forEach(function (client) {
      users_cache.forEach(function (value, key) {
          if(users_cache.get(ws.id) === value && users_cache.get(client.id) === value && client.id === key) /* room check */{
            client.send("guest" + ws.id + " : " + message.toString());
          }
      })

    });
  })

  wss.clients.forEach(function (client) {
    users_cache.forEach(function (value, key) {
        if(users_cache.get(client.id) === value && client.id != key) /* room check */{
          client.send("guest" + client.id + " joined room.");
        }
    })

  });
  /* setInterval(
    () => ws.send(`${new Date()}`),
    1000
  ) */
})

