var app = require('./app');
var http = require('http');
var port = process.env.PORT || 8010;

app.set('port', port);

var server = http.createServer(app);
server.listen(port);
