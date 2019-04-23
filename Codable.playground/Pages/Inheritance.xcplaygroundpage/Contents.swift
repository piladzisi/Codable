import Foundation

let json = """
{
    "id": "ABCD",
    "title": "Some Title"
}
""".data(using: .utf8)!

class Media: Codable {
    let id: String
    let title: String
}

let decoder = JSONDecoder()
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
