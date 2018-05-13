//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//


import Foundation
import PerfectHTTP
import PerfectHTTPServer
import PerfectPostgreSQL
import PerfectCRUD

// postgres sample configuration

let db = Database(configuration: try PostgresDatabaseConfiguration("host=localhost dbname=addaapi user=alif password=password"))
try db.create(Person.self, policy: .reconcileTable)

let personTable = db.table(Person.self)
let numbersTable = db.table(PhoneNumber.self)

// Add an index for personId, if it does not already exist.
try numbersTable.index(\.personId)

//// Insert some sample data.
//do {
//    // Insert some sample data.
//    let owen = Person(id: UUID(), firstName: "Owen", lastName: "Lars", phoneNumbers: nil)
//    let beru = Person(id: UUID(), firstName: "Beru", lastName: "Lars", phoneNumbers: nil)
//    
//    // Insert the people
//    try personTable.insert([owen, beru])
//
//    // Give them some phone numbers
//    try numbersTable.insert([
//        PhoneNumber(personId: owen.id, planetCode: 12, number: "555-555-1212"),
//        PhoneNumber(personId: owen.id, planetCode: 15, number: "555-555-2222"),
//        PhoneNumber(personId: beru.id, planetCode: 12, number: "555-555-1212")])
//}

// Perform a query.
// Let's find all people with the last name of Lars which have a phone number on planet 12.
let query = try personTable
    .order(by: \.lastName, \.firstName)
    .join(\.phoneNumbers, on: \.id, equals: \.personId)
    .order(descending: \.planetCode)
    .where(\Person.lastName == "Lars" && \PhoneNumber.planetCode == 12)
    .select()

// Loop through the results and print the names.
for user in query {
    // We joined PhoneNumbers, so we should have values here.
    guard let numbers = user.phoneNumbers else {
        continue
    }
    for number in numbers {
        print(number.number)
    }
}

// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(request: HTTPRequest, response: HTTPResponse) {
	// Respond with a simple message.
	response.setHeader(.contentType, value: "text/html")
	response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
	// Ensure that response.completed() is called when your processing is done.
	response.completed()
}

// Configuration data for an example server.
// This example configuration shows how to launch a servhttps://github.com/PerfectlySoft/Perfect-CRUD.giter
// using a configuration dictionary.


let confData = [
	"servers": [
		// Configuration data for one server which:
		//	* Serves the hello world message at <host>:<port>/
		//	* Serves static files out of the "./webroot"
		//		directory (which must be located in the current working directory).
		//	* Performs content compression on outgoing data when appropriate.
		[
			"name":"localhost",
			"port":8181,
			"routes":[
				["method":"get", "uri":"/", "handler":handler],
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
				 "documentRoot":"./webroot",
				 "allowResponseFilters":true]
			],
			"filters":[
				[
				"type":"response",
				"priority":"high",
				"name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		]
	]
]

do {
	// Launch the servers based on the configuration data.
	try HTTPServer.launch(configurationData: confData)
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

