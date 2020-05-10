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
import ProductService

public extension Product {
    init?(dictionary: [String: String]) {
        guard let sku = dictionary["sku"],
            let name = dictionary["name"],
            let description = dictionary["description"] else {
            return nil
        }
        self.init(sku: sku,
                  name: name,
                  description: description,
                  createdAt: dictionary["createdAt"],
                  updatedAt: dictionary["updatedAt"])
    }

    init?(queryString: String) {
        let url = "http://localhost?\(queryString)"
        let val = URLComponents(string: url)
        let values = val?.parameters() ?? [:]
        self.init(dictionary: values)
    }

    static func sku(queryString: String) -> String? {
        let url = "http://localhost?\(queryString)"
        let val = URLComponents(string: url)
        let values = val?.parameters() ?? [:]
        guard let value = values["sku"] else {
            return nil
        }
        return value
    }
}
