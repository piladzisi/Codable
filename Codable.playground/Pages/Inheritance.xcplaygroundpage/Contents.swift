import Foundation

let json = """
{
  "media" : {
    "id" : "ABCD",
    "title" : "Some Title"
  },
  "isbn" : "123-434-2323-2323"
}
""".data(using: .utf8)!

class Media: Codable {
    let id: String
    let title: String
}

let decoder = JSONDecoder()
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let media = try! decoder.decode(Media.self, from: json)

class Book: Media {
   let isbn: String
    enum BookCodingKeys: String, CodingKey {
        case isbn
        case media
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BookCodingKeys.self)
        self.isbn = try container.decode(String.self, forKey: .isbn)
        try super.init(from: container.superDecoder(forKey: .media))
    }
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BookCodingKeys.self)
        try container.encode(isbn, forKey: .isbn)
        try super.encode(to: container.superEncoder(forKey: .media))
    }
}

let book = try! decoder.decode(Book.self, from: json)

book.id
book.title
book.isbn

print(try! encoder.encode(book).stringDescription)
