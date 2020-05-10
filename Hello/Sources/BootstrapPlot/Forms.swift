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
import Plot

public extension Node where Context: HTML.FormContext {
    static func formGroup(_ nodes: Node<HTML.FormContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("form-group"))
        return .element(named: "div", nodes: nodes)
    }

    static func label(_ nodes: Node<HTML.BodyContext>...) -> Node {
        return .element(named: "label", nodes: nodes)
    }

    static func label(_ nodes: Node<HTML.FormContext>...) -> Node {
        return .element(named: "label", nodes: nodes)
    }

    static func formControl(_ nodes: Node<HTML.FormContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("form-control"))
        return .element(named: "div", nodes: nodes)
    }

    static func formRow(_ nodes: Node<HTML.FormContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("form-row"))
        return .element(named: "div", nodes: nodes)
    }

    static func formCol(_ nodes: Node<HTML.FormContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("form-col"))
        return .element(named: "div", nodes: nodes)
    }
}

public extension Attribute where Context == HTML.InputContext {
    static var readonly: Attribute {
        .attribute(named: "readonly", value: "true")
    }

    static var formControl: Attribute {
        .class("form-control")
    }
}
