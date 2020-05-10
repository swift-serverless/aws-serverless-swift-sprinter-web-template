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

import BootstrapPlot
import Foundation
import Plot
import ProductService

///Present the HTML according to the Action
public class Presenter {

    private var action: Action
    private var product: Product?

    // MARK: - Public
    
    /**
     - Parameter action: The `Action` to perform.
     
     - Parameter product: The `Product` to edit.
     
     */
    public init(action: Action, product: Product?) {
        self.action = action
        self.product = product
    }
    
    /**
    Render HTML String.
    - Parameter products: The list of `Product` to render.
    
    */
    public func render(products: [Product]) -> String {
        present(products: products).render()
    }

    // MARK: Private
    
    private func present(products: [Product]) -> HTML {
        let node: Node<HTML.BodyContext>

        switch action {
        case .add:
            node = .addProductContainer()
        case .edit:
            guard let product = product else {
                node = .errorContainer(action: action)
                break
            }
            node = .editProductContainer(product: product)
        default:
            node = .productListContainer(products: products)
        }
        return commonHTML(node)
    }

    func commonHTML(_ node: Node<HTML.BodyContext>) -> HTML {
        return HTML(
            .head(
                .encoding(.utf8),
                .viewport(.accordingToDevice),
                .linkBootstrap()
            ),
            .body(
                .headerContainer(),
                node
            )
        )
    }
}
