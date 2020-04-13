#!/usr/bin/env imba

/**
 * Module dependencies.
 */

var app = require('../app')
var debug = require('debug')('your-app-name:server')
var http = require('http')


/**
 * Normalize a port into a number, string, or false.
 */

def normalizePort val
	var port = parseInt(val, 10)

	if isNaN(port)
		return val
	
	if port >= 0
		return port

	return false


var port = normalizePort(process.env.PORT || '3000')
/**
 * Event listener for HTTP server "error" event.
 */

def onError error
	if error.syscall !== 'listen'
		throw error

	var bind = typeof port === 'string' ? 'Pipe ' + port : 'Port ' + port

	// handle specific listen errors with friendly messages
	switch error.code
		when 'EACCES'
			console.error(bind + ' requires elevated privileges')
			process.exit(1)
			break
		when 'EADDRINUSE'
			console.error(bind + ' is already in use')
			process.exit(1)
			break
		else
			throw error

def onListening
	var addr = server.address()
	var bind = typeof addr === 'string' ? 'pipe ' + addr : 'port ' + addr.port
	debug('Listening on ' + bind)

app.set('port', port)

var server = http.createServer(app)
console.log(`http://localhost:{port}`)
server.listen(port)
server.on('error', onError)
server.on('listening', onListening)