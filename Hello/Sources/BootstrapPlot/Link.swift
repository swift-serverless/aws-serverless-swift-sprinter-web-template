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

public extension Node where Context == HTML.HeadContext {
    /// Add a `<link/>`required for Bootstrap
    static func linkBootstrap() -> Node {
        return .link(
            .rel(.stylesheet),
            .attribute(named: "crossorigin", value: "anonymous"),
            .href("https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"),
            .integrity("sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh")
        )
    }
}
