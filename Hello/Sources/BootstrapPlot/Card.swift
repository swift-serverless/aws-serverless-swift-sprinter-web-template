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

public extension Node where Context: HTML.BodyContext {
    static func card(_ nodes: Node<HTML.BodyContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("card"))
        return .element(named: "div", nodes: nodes)
    }

    static func cardHeader(_ nodes: Node<HTML.BodyContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("card-header"))
        return .element(named: "div", nodes: nodes)
    }

    static func cardBody(_ nodes: Node<HTML.BodyContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("card-body"))
        return .element(named: "div", nodes: nodes)
    }

    static func cardText(_ nodes: Node<HTML.BodyContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("card-text"))
        return .element(named: "div", nodes: nodes)
    }

    static func cardTitle(_ nodes: Node<HTML.BodyContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("card-title"))
        return .element(named: "div", nodes: nodes)
    }

    static func cardSubtitle(_ nodes: Node<HTML.BodyContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("card-subtitle"))
        return .element(named: "div", nodes: nodes)
    }
    
    static func cardFooterMuted(_ nodes: Node<HTML.BodyContext>...) -> Node {
        var nodes = nodes
        nodes.append(.class("card-footer text-muted"))
        return .element(named: "div", nodes: nodes)
    }
}
