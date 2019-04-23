import Foundation

let json = """
{
    "work": {
        "id": 2422333,
        "books_count": 222,
        "ratings_count": 860687,
        "text_reviews_count": 37786,
        "best_book": {
            "id": 375802,
            "title": "Ender's Game (Ender's Saga, #1)",
            "author": {
                "id": 589,
                "name": "Orson Scott Card"
            }
        }
    }
}
""".data(using: .utf8)!

struct SearchResult{
    let id: Int
    let booksCount: Int
    let ratingsCount: Int
    let textReviewsCount: Int
    
    enum OuterCodingKeys: String, CodingKey {
        case work
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case booksCount
        case ratingsCount
        case textReviewsCount
    }
}


extension SearchResult: Decodable {
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterCodingKeys.self)
        let innerContainer = try outerContainer.nestedContainer(keyedBy: CodingKeys.self, forKey:  .work)
        self.id = try innerContainer.decode(Int.self, forKey: .id)
        self.booksCount = try innerContainer.decode(Int.self, forKey: .booksCount)
        self.ratingsCount = try innerContainer.decode(Int.self, forKey: .ratingsCount)
        self.textReviewsCount = try innerContainer.decode(Int.self, forKey: .textReviewsCount)
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

let result = try! decoder.decode(SearchResult.self, from: json)


extension SearchResult: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: OuterCodingKeys.self)
        var innerContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .work)
        
        try innerContainer.encode(id, forKey:.id)
        try innerContainer.encode(booksCount, forKey:.booksCount)
        try innerContainer.encode(ratingsCount, forKey:.ratingsCount)
        try innerContainer.encode(textReviewsCount, forKey:.textReviewsCount)
    }
}

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase
let resultEncode = try! encoder.encode(result).stringDescription
print(resultEncode)
