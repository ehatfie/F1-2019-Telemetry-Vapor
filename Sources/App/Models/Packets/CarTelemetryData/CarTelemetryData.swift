//
//  CarTelemetryData.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct CarTelemetryData {
    let speed: Int?  // uint 16 speed in kmh
    let throttle: Float? // amount of throttle 0.0 - 1.0
    let steer: Float? // -1.0 = full left, 1.0 = full right
    let brake: Float? // amount of brake 0 to 100
    let clutch: Int? // uint8 amount of clutch 0 to 100
    let gear: Int? // int8 gear selected -1 = r, 0 = N, 1 - 7
    let engineRPM: Int? // uint16
    let drs: Int? // uint8 0 = off, 1 = on
    let revLightsPercent: Int? // uint8
    let brakesTemperature: [Int?] // uint16 * 4 celcius
    let tiresSurfaceTemperature: [Int?] // uint16 * 4 celcius
    let tiresInnerTemperature: [Int?] // uint16 * 4
    let engineTemperature: [Int?] // uint 16 temp in celcius
    let tirePressure: [Float?] //
    let surfaceType: Int? // uint8 driving surface, make enum??
    
    init(data: ByteBuffer) throws {
        var dataCopy = data
        
        self.speed = dataCopy.readInt(as: UInt16.self)
        self.throttle = dataCopy.readFloat()
        self.steer = dataCopy.readFloat()
        self.brake = dataCopy.readFloat()
        self.clutch = dataCopy.readInt(as: UInt8.self)
        self.gear = dataCopy.readInt(as: UInt8.self)
        self.engineRPM = dataCopy.readInt(as: UInt16.self)
        self.drs = dataCopy.readInt(as: UInt8.self)
        self.revLightsPercent = dataCopy.readInt(as: UInt8.self)
        
        var temps = [Int?]()
        
        for _ in  0...4 {
            let temp = dataCopy.readInt(as: UInt16.self)
            temps.append(temp)
        }
        
        self.brakesTemperature = temps
        temps.removeAll()
        
        for _ in  0...4 {
            let temp = dataCopy.readInt(as: UInt16.self)
            temps.append(temp)
        }
        
        self.tiresSurfaceTemperature = temps
        temps.removeAll()
        
        for _ in  0...4 {
            let temp = dataCopy.readInt(as: UInt16.self)
            temps.append(temp)
        }
        
        self.tiresInnerTemperature = temps
        temps.removeAll()
        
        for _ in  0...4 {
            let temp = dataCopy.readInt(as: UInt16.self)
            temps.append(temp)
        }
        
        self.engineTemperature = temps
        
        var pressures = [Float?]()
        
        for _ in 0...4 {
            let pressure: Float? = dataCopy.readFloat()
            pressures.append(pressure)
        }
        
        self.tirePressure = pressures
        self.surfaceType = dataCopy.readInt(as: UInt8.self)
    }
}
