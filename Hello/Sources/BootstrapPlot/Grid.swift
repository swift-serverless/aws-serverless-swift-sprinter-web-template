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
    enum GridSize {
        case regular(UInt?)
        case sm(UInt?)
        case md(UInt?)
        case lg(UInt?)
        case xl(UInt?)

        var name: String {
            switch self {
            case let .regular(i):
                if let i = i { return "-\(i)" } else { return "" }
            case let .sm(i):
                if let i = i { return "-sm-\(i)" } else { return "-sm" }
            case let .md(i):
                if let i = i { return "-md-\(i)" } else { return "-md" }
            case let .lg(i):
                if let i = i { return "-lg-\(i)" } else { return "-lg" }
            case let .xl(i):
                if let i = i { return "-xl-\(i)" } else { return "-xl" }
            }
        }

        func `class`(name: String) -> Node<HTML.BodyContext> {
            return .attribute(named: "class", value: "\(name)\(self.name)")
        }
    }

    static func row(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .div(.class("row"), .group(nodes))
    }

    static func col(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .div(.class("col"), .group(nodes))
    }

    static func col(size: GridSize, _ nodes: Node<HTML.BodyContext>...) -> Node {
        .div(size.class(name: "col"), .group(nodes))
    }
    
    static func col(sizes: [GridSize], _ nodes: Node<HTML.BodyContext>...) -> Node {
        let name = sizes.reduce("") { value,size  in return "\(value) col\(size.name)" }
        return .div(.class(name), .group(nodes))
    }
}
