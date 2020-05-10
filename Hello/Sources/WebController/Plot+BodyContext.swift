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

// MARK: - Body Container
public extension Node where Context: HTML.BodyContext {

    static func headerContainer() -> Node {
        return .p(
            .container(
                .row(
                    .col(size: .regular(1),
                         .img(.src("https://avatars0.githubusercontent.com/u/55535272?s=50&v=4"))
                    ),
                    .col(size: .regular(1),.empty),
                    .col(
                        .h1("Hello Swift-Sprinter!")
                    )
                )
            )
        )
    }
    
    static func productListContainer(products: [Product]) -> Node {
        return .p(
            .container(
                .actionButton(action: .add, title: "Add"),
                .forEach(products) {
                    .p(
                        .productCard(product: $0)
                    )
                }
            )
        )
    }
    
    static func addProductContainer() -> Node {
        return .p(
            .container(
                .addProductCard()
            )
        )
    }
    
    static func editProductContainer(product: Product) -> Node {
        return .p(
            .container(
                .editProductCard(product: product)
            )
        )
    }
    
    static func debugActionText(action: Action) -> Node {
        return .p(
            .container(
                .text(action.rawValue)
            )
        )
    }
    
    static func errorContainer(action: Action) -> Node {
        return .p(
            .container(
                .h3("Invalid paramters on \(action.rawValue)")
            )
        )
    }
}
