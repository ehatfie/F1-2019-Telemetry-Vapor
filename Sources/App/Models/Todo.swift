import Fluent
import Vapor
import NIO

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID(key: "id")
    var id: Int?

    @Field(key: "title")
    var title: String

    init() { }

    init(id: Int? = nil, title: String, data: ByteBuffer) {
        self.id = id
        self.title = title
        
        var dataCopy = data
        
        
    }
}
