import UIKit

extension Array {
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

var array = ["Apple", "Banana", "Apple", "Pear"]
var unlike = "Banana"
var newArray = array.filterDuplicates({$0}).filter({$0 != unlike})
print(newArray)

