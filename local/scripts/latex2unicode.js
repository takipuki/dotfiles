#! /usr/bin/env -S NODE_PATH=/usr/lib/node_modules/ node

var unicodeit = require('unicodeit');

process.stdin.on("data", data => {
	data = data.toString();
	process.stdout.write(unicodeit.replace(data));
})
