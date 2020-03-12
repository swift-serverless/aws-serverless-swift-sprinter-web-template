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
import LambdaSwiftSprinter
import LambdaSwiftSprinterNioPlugin
import NIO
import NIOFoundationCompat

struct Event: Codable {

}

public struct APIGatewayProxyResult: Codable {

    public let isBase64Encoded: Bool?
    public let statusCode: Int
    public let headers: [String: String]?
    public let multiValueHeaders: [String: [String]]?
    public let body: String

    public init(isBase64Encoded: Bool? = false,
                statusCode: Int,
                headers: [String: String]? = nil,
                multiValueHeaders: [String: [String]]? = nil,
                body: String) {
        self.isBase64Encoded = isBase64Encoded
        self.statusCode = statusCode
        self.headers = headers
        self.multiValueHeaders = multiValueHeaders
        self.body = body
    }
}

enum MyLambdaError: Error {
    case invalidEvent
}

let hello: SyncCodableNIOLambda<Event, APIGatewayProxyResult> = { (event, context) throws -> EventLoopFuture<APIGatewayProxyResult> in
    
    let eventLoop = httpClient.eventLoopGroup.next()
    let response = APIGatewayProxyResult(statusCode: 200, body: "HelloWorld!")
    let future = eventLoop.makeSucceededFuture(response)
    return future
}

public func log(_ object: Any, flush: Bool = false) {
    fputs("\(object)\n", stderr)
    if flush {
        fflush(stderr)
    }
}

do {
    let sprinter = try SprinterNIO()
    sprinter.register(handler: "hello", lambda: hello)
    try sprinter.run()
} catch {
    log(String(describing: error))
}
