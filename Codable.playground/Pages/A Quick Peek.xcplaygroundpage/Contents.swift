import Foundation

let json = """
{
    "name": "Anna",
    "id": 1,
    "role": "Developer",
    "start_date": "April 2012"
}
""".data(using: .utf8)!

struct Employee: Codable {
    let name: String
    let id: Int
    let role: String
    let startDate: String
    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case id
//        case role
//        case startDate
//   }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.role = try container.decode(String.self, forKey: .role)
//        self.startDate = try container.decode(String.self, forKey: .startDate)
//    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let employee = try! decoder.decode(Employee.self, from: json)

employee.name
employee.id 

//extension Employee: Encodable {
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(id, forKey: .id)
//        try container.encode(role, forKey: .role)
//    }
//}
let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase
let encodedEmployee = try! encoder.encode(employee)

//print(encodedEmployee.stringDescription)

