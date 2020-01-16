import Vapor

public func app(_ environment: Environment) throws -> Application {
    var environment = environment
    try LoggingSystem.bootstrap(from: &environment)
    let app = Application(environment)
    try configure(app)
    
    
    startUDP()
    //let eventGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount-4)
    
    return app
}


public func setupUdpHandler() {
    print("SETUP HANDLER")
    //let udp = UdpEchoHandler()
    //udp.start()
}
