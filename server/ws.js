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

wss.on('connection', function (ws) {
  ws.on('message', function (message) {
    console.log('received: %s', message)
    var clientID = ws._socket._handle.fd;
    wss.clients.forEach(function (client) {
      client.send("guest" + clientID + " : " + message.toString());
    });
  })
  var clientID = ws._socket._handle.fd;

  wss.clients.forEach(function (client) {
    client.send("new user joined guest" + clientID);
  });
  /* setInterval(
    () => ws.send(`${new Date()}`),
    1000
  ) */
})
