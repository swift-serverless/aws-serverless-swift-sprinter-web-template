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

public enum Action: String {
    case add
    case edit
    case create
    case read
    case update
    case delete
    case unkown

    public init(queryString: String) {
        let url = "http://localhost?\(queryString)"
        let val = URLComponents(string: url)
        let dictionary = val?.parameters() ?? [:]
        guard let rawValue = dictionary["action"],
            let action = Action(rawValue: rawValue)
        else {
            self = .unkown
            return
        }
        self = action
    }
}

public extension URLComponents {
    func parameters() -> [String: String] {
        var dictionary: [String: String] = [:]
        queryItems?.forEach { item in
            guard let value = item.value else { return }
            dictionary[item.name] = value
        }
        return dictionary
    }
}
