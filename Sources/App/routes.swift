import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        return "Hello, world!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)
    
    app.get("hello1") { req in
        req.view.render("hello", WelcomeContext(title: "HENLO", numbers: [1, 2]))
    }
}

struct WelcomeContext: Encodable {
    var title: String
    var numbers: [Int]
}
