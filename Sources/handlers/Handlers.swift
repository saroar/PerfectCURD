//
//  Handlers.swift
//  PerfectCURD
//
//  Created by Alif on 13/05/2018.
//

import PerfectHTTP
import PerfectHTTPServer

class Handler {
    // An example request handler.
    // This 'handler' function can be referenced directly in the configuration below.
    func home(request: HTTPRequest, response: HTTPResponse) {
        // Respond with a simple message.
        response.setHeader(.contentType, value: "text/html")
        response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
        // Ensure that response.completed() is called when your processing is done.
        response.completed()
    }

}
