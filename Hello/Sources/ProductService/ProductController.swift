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

import Foundation
import NIO

public class ProductController {
    let service: ProductService

    public init(service: ProductService) {
        self.service = service
    }

    public func create(product: Product) throws -> EventLoopFuture<Product> {
        let future = service.createItem(product: product)
            .flatMapThrowing { _ -> Product in
                product
            }
        return future
    }

    public func read(sku: String) throws -> EventLoopFuture<Product> {
        let future = service.readItem(key: sku)
            .flatMapThrowing { data -> Product in
                try Product(dictionary: data.item ?? [:])
            }
        return future
    }

    public func update(product: Product) throws -> EventLoopFuture<Product> {
        let future = service.updateItem(product: product)
            .flatMapThrowing { (_) -> Product in
                product
            }
        return future
    }

    public func delete(sku: String) throws -> EventLoopFuture<Void> {
        let future = service.deleteItem(key: sku)
            .flatMapThrowing { (_) -> Void in
                ()
            }
        return future
    }

    public func list() throws -> EventLoopFuture<[Product]> {
        let future = service.listItems()
            .flatMapThrowing { data -> [Product] in
                let products: [Product]? = try data.items?
                    .compactMap { (item) -> Product in
                        try Product(dictionary: item)
                    }
                return products ?? []
            }
        return future
    }
}
