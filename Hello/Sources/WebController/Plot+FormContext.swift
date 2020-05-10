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

public extension Node where Context: HTML.FormContext {
    static func inputField(label: Node<HTML.FormContext>, name: String, value: String, isEnabled: Bool = true) -> Node {
        return .formGroup(
            .label(
                .attribute(named: "for", value: name),
                label
            ),
            .if(isEnabled,
                .input(
                    .formControl,
                    .name(name),
                    .value(value)
                ),
            else:
                .input(
                    .formControl,
                    .readonly,
                    .name(name),
                    .value(value)
                )
            )
        )
    }
}
