#!/usr/bin/env node

var server = require('./');

port = 3000
server.listen(port);
console.log(
    "Express server listening on port %d in %s mode",
    port,
    server.settings.env);
