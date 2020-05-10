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

// MARK: - Action Button
public extension Node where Context: HTML.BodyContext {

    static func actionButton(action: Action, title: String, sku: String) -> Node {
        return .form(
            .method(.post),
            .enctype(.urlEncoded),
            .input(
                .type(.hidden),
                .name("action"),
                .value(action.rawValue)
            ),
            .input(
                .type(.hidden),
                .name("sku"),
                .value(sku)
            ),
            .if(action != .delete,
                .button(
                    .class("btn btn-primary"),
                    .attribute(named: "type", value: "submit"),
                    .text(title)
                ),
                else:
                .button(
                    .class("btn btn-outline-primary"),
                    .attribute(named: "type", value: "submit"),
                    .text(title)
                )
            )
        )
    }
    
    static func actionButton(action: Action, title: String) -> Node {
        return .form(
            .method(.post),
            .enctype(.urlEncoded),
            .input(
                .type(.hidden),
                .name("action"),
                .value(action.rawValue)
            ),
            .if(action != .read,
                .button(
                    .class("btn btn-primary"),
                    .attribute(named: "type", value: "submit"),
                    .text(title)
                ),
                else:
                .button(
                    .class("btn btn-outline-primary"),
                    .attribute(named: "type", value: "submit"),
                    .text(title)
                )
            )
        )
    }
}
