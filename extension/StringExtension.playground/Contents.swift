import UIKit

var str = "Hello, playground"

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

var e = str.matches("playground")
print(e)

var b = str.matches("p.*a")
print(b)
