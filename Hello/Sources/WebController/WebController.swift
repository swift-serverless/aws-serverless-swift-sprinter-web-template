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
import ProductService

///Controls the update of the DB and delegates the ProductController to render the HTML
public class WebController {
    
    // MARK: - Public
    
    /**
     - Parameter queryString: The `application/x-www-form-urlencoded` string.
     The querySTring should not contain the symbol `+` .
     Use `%20` to replace it before calling this method.
     
     - Parameter controller: ProductController responsible of performing DB the CRUD operations on the DB.
     
     */
    public init(queryString: String, controller: ProductController) {
        action = Action(queryString: queryString)
        sku = Product.sku(queryString: queryString)
        product = Product(queryString: queryString)
        self.controller = controller
    }
    
    /// Update the DB performing the decoded Action using the ProductController
    public func update() {
        execute(action: action, product: product, sku: sku)
    }
    
    /// Render the HTML String using the current list of products
    public func render() -> String {
        return Presenter(action: action, product: product).render(products: products)
    }
    
    
    // MARK: - ProductController
    
    let controller: ProductController
    
    private func createProduct(product: Product?) {
        guard let product = product else {
            return
        }
        _ = try? controller.create(product: product).wait()
    }
    
    private func deleteProduct(sku: String?) {
        guard let sku = sku else {
            return
        }
        _ = try? controller.delete(sku: sku).wait()
    }
    
    private func editProduct(sku: String?) -> Product? {
        guard let sku = sku else {
            return nil
        }
        return try? controller.read(sku: sku).wait()
    }
    
    private func updateProduct(product: Product?) {
        guard let product = product else {
            return
        }
        _ = try? controller.update(product: product).wait()
    }
    
    // MARK: - Product
    
    private(set) var product: Product?
    private let sku: String?
    private var products = [Product]()
    
    // MARK: - Action
    
    let action: Action
    
    private func execute(action: Action, product: Product?, sku: String?) {
        switch action {
        case .create:
            createProduct(product: product)
        case .delete:
            deleteProduct(sku: sku)
        case .edit:
            self.product = editProduct(sku: sku)
            return
        case .update:
            updateProduct(product: product)
        default:
            break
        }
        products = (try? controller.list().wait()) ?? []
    }
}
