import Vapor
import Routing
import SQLite
import Fluent
/// Register your application's routes here.

struct User: Content {
    var name: String
    var email: String
}

public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    

        router.get("name") { req in
        return "name"
    }
    
    // get parameter from user
   router.get("hello", String.parameter) { req -> String in
      
      let name = try req.parameters.next(String.self)
      
      return "Hello, \(name)!"
    }
    
    // return json
    router.get("user") { req -> User in
        return User(
            name: "Vapor User",
            email: "user@vapor.codes"
        )
    }

    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
