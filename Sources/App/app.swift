import Vapor

public func app(_ environment: Environment) throws -> Application {
    var environment = environment
    try LoggingSystem.bootstrap(from: &environment)
    let app = Application(environment)
    try configure(app)
    
        DispatchQueue.global().async {
            do {
                startUDP()
            } catch {
                
            }
    }
    print("THREAD")
    return app
}

