//    Copyright 2019 (c) Andrea Scuderi - https://github.com/swift-sprinter
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

import AsyncHTTPClient
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import AWSDynamoDB
import LambdaSwiftSprinter
import LambdaSwiftSprinterNioPlugin
import NIO
import NIOFoundationCompat
import NIOHTTP1
import ProductService
import WebController

enum HelloError: Error {
    case invalidEvent
    case tableNameNotFound
}

public func log(_ object: Any, flush: Bool = false) {
    fputs("\(object)\n", stderr)
    if flush {
        fflush(stderr)
    }
}

let localStackDB = "DB"
let tableName = ProcessInfo.processInfo.environment["PRODUCTS_TABLE_NAME"] ?? localStackDB

let region: Region

if let awsRegion = ProcessInfo.processInfo.environment["AWS_REGION"] {
    let value = Region(rawValue: awsRegion)
    region = value
    log("AWS_REGION: \(region)")
} else {
    // Default configuration
    region = .useast1
    log("AWS_REGION: us-east-1")
}

let awsClient: AWSHTTPClient = httpClient as! AWSHTTPClient

let db = DynamoDB(region: region, httpClientProvider: .shared(awsClient))

let service = ProductService(db: db, tableName: tableName)
let controller = ProductController(service: service)

struct Event: Codable {
    let body: [String: String]
}

let hello: SyncCodableNIOLambda<APIGatewayProxySimpleEvent, APIGatewayProxyResult> = { (event, context) throws -> EventLoopFuture<APIGatewayProxyResult> in
    
    let queryString = event.body?.replacingOccurrences(of: "+", with: "%20") ?? ""
    let webController = WebController(queryString: queryString, controller: controller)
    webController.update()
    let body = webController.render()
    let eventLoop = httpClient.eventLoopGroup.next()
    let response = APIGatewayProxyResult(statusCode: 200, body: body)
    let future = eventLoop.makeSucceededFuture(response)
    return future
}

do {
    let sprinter = try SprinterNIO()
    sprinter.register(handler: "hello", lambda: hello)
    try sprinter.run()
} catch {
    log(String(describing: error))
}
