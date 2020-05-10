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

// MARK: - Cards
public extension Node where Context: HTML.BodyContext {
    
    static func productCard(product: Product) -> Node {
        return .card(
            .cardHeader(
                .container(
                    .row(
                        .col(
                            .h3(.cardTitle("\(product.name)"))
                        ),
                        .col(sizes: [.sm(2), .md(2), .lg(1), .regular(2)],
                             .actionButton(action: .delete, title: "Delete", sku: product.sku)
                        ),
                        .col(sizes: [.sm(2), .md(2), .lg(1), .regular(2)],
                            .actionButton(action: .edit, title: "Edit", sku: product.sku)
                        )
                    )
                )
            ),
            .cardBody(
                .cardText("\(product.description)")
            ),
            .cardFooterMuted(
                .row(
                    .col(
                        .text("Created At: \(product.createdAt ?? "-")")
                    ),
                    .col(
                        .text("Updated At: \(product.updatedAt ?? "-")")
                    )
                )
            )
        )
    }
    
    static func addProductCard() -> Node {
        return .card(
            .cardHeader(
                .container(
                    .row(
                        .col(
                            .h3(.text("Add"))
                        ),
                        .col(
                            .attribute(named: "align", value: "right"),
                            .actionButton(action: .read, title: "Cancel")
                        )
                    )
                )
            ),
            .cardBody(
                .form(
                    .method(.post),
                    .enctype(.urlEncoded),
                    .input(
                        .type(.hidden),
                        .name("action"),
                        .value(Action.create.rawValue)
                    ),
                    .input(
                        .type(.hidden),
                        .name("sku"),
                        .value("\(UUID())")
                    ),
                    .inputField(
                        label: "Name:",
                        name: "name",
                        value: ""
                    ),
                    .inputField(
                        label: "Description:",
                        name: "description",
                        value: ""
                    ),
                    .row(
                        .col(.empty),
                        .col(
                            .attribute(named: "align", value: "right"),
                            .button(
                                .class("btn btn-primary"),
                                .attribute(named: "type", value: "submit"),
                                .text("Save")
                            )
                        )
                    )
                )
            )
        )
    }
    
    static func editProductCard(product: Product) -> Node {
        return .card(
            .cardHeader(
                .container(
                    .row(
                        .col(
                            .h3(.text("Edit"))
                        ),
                        .col(.attribute(named: "align", value: "right"),
                            .actionButton(action: .read, title: "Cancel")
                        )
                    )
                )
            ),
            .cardBody(
                .form(
                    .method(.post),
                    .enctype(.urlEncoded),
                    .input(
                        .type(.hidden),
                        .name("action"),
                        .value(Action.update.rawValue)
                    ),
                    .input(
                        .type(.hidden),
                        .name("sku"),
                        .value(product.sku)
                    ),
                    .inputField(
                        label: "Name",
                        name: "name",
                        value: product.name
                    ),
                    .inputField(
                        label: "Description",
                        name: "description",
                        value: product.description
                    ),
                    .inputField(
                        label: "Created At",
                        name: "createdAt",
                        value: product.createdAt ?? "",
                        isEnabled: false
                    ),
                    .inputField(
                        label: "Updated At",
                        name: "updatedAt",
                        value: product.updatedAt ?? "",
                        isEnabled: false
                    ),
                    .row(
                        .col(.empty),
                        .col(
                            .attribute(named: "align", value: "right"),
                             .button(
                                 .class("btn btn-primary"),
                                 .attribute(named: "type", value: "submit"),
                                 .text("Update")
                             )
                        )
                    )
                )
            )
        )
    }
}
