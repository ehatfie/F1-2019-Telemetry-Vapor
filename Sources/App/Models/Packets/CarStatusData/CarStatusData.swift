
//
//  CarStatusData.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation
import NIO

struct CarStatusData {
    let tractionControl: Int? // uint8 0 off - 2 high
    let antiLockBrakes: Int? // uint8 0 = off 1 = on
    let fuelMix: Int? // uint8 0 = lean, 1 = standard, 2 = rich, 3 = max
    let frontBrakeBias: Int? // uint8
    let pitLimiterStatus: Int? // uint8 0 = off 1 = on
    let fuelInTank: Float? // current fuel mass
    let fuelCapacity: Float?
    let fuelRemainingLaps: Float? // value on mfd
    let maxRPM: Int? // uint16
    let idleRPM: Int? // uint16
    let maxGears: Int? // uint8
    let drsAllowed: Int? // uint8, 0 = no, 1 = yes, -1 = unown
    
    let tiresWear: [Int?] // uint8, tire wear percentage
    
    // F1 Modern: 16 = C5, 17 = C4, 18 = C3, 19 = C2, 20 = C1, 7 = inter, 8 = wet
    // F1 Classic: 9 = dry, 10 = wet
    // F2: 11 = super soft, 12 = soft, 13 = medium, 14 = hard, 15 = wet
    let actualTireCompound: Int? // uint8
    
    let tiresDamage: [Int?] // uint8 * 4
    let tireVisualCompound: Int? // uint8 // 16 = soft, 17 = medium, 18 = hard, 7 = inter, 8 = wet GOES HERE??
    
    let frontLeftWingDamage: Int? // uint8, percentage
    let frontRightWingDamage: Int? // uint8, percentage
    let rearWingDamage: Int? // uint8, percentage
    let engineDamage: Int? //uint8, percentage
    let gearBoxDamage: Int? // uint8, percentage
    
    let vehicleFiaFlags: Int? // uint8, -1 = invalid/unknown, 0 = none, 1 = green
    let ersStoreEnergy: Float?
    let ersDeployMode: Int? // uint8, 0 = none, 1 = low, 2 = medium, 3 = high, 4 = overtake, 5 = hotlop
    let ersHarvestThisLapMGUK: Float?
    let ersHarvestThisLapMGUH: Float?
    let ersDeployedThisLap: Float?
    
    init(data: ByteBuffer) throws {
        var dataCopy = data
        
        self.tractionControl = dataCopy.readInt(as: UInt8.self)
        self.antiLockBrakes = dataCopy.readInt(as: UInt8.self)
        self.fuelMix = dataCopy.readInt(as: UInt8.self)
        self.frontBrakeBias = dataCopy.readInt(as: UInt8.self)
        self.pitLimiterStatus = dataCopy.readInt(as: UInt8.self)
        self.fuelInTank = dataCopy.readFloat()
        self.fuelCapacity = dataCopy.readFloat()
        self.fuelRemainingLaps = dataCopy.readFloat()
        self.maxRPM = dataCopy.readInt(as: UInt8.self)
        self.idleRPM = dataCopy.readInt(as: UInt8.self)
        self.maxGears = dataCopy.readInt(as: UInt8.self)
        self.drsAllowed = dataCopy.readInt(as: UInt8.self)
        
        var tires = [Int?]()
        
        for i in  0...4 {
            let val = dataCopy.readInt(as: UInt8.self)
            tires.append(val)
        }
        
        self.tiresWear = tires
        self.actualTireCompound = dataCopy.readInt(as: UInt8.self)
        
        tires.removeAll()
        
        for i in  0...4 {
            let val = dataCopy.readInt(as: UInt8.self)
            tires.append(val)
        }
        
        self.tiresDamage = tires
        self.tireVisualCompound = dataCopy.readInt(as: UInt8.self)
        
        self.frontLeftWingDamage = dataCopy.readInt(as: UInt8.self)
        self.frontRightWingDamage = dataCopy.readInt(as: UInt8.self)
        self.rearWingDamage = dataCopy.readInt(as: UInt8.self)
        self.engineDamage = dataCopy.readInt(as: UInt8.self)
        self.gearBoxDamage = dataCopy.readInt(as: UInt8.self)
        
        self.vehicleFiaFlags = dataCopy.readInt(as: UInt8.self)
        self.ersStoreEnergy = dataCopy.readFloat()
        self.ersDeployMode = dataCopy.readInt(as: UInt8.self)
        self.ersHarvestThisLapMGUK = dataCopy.readFloat()
        self.ersHarvestThisLapMGUH = dataCopy.readFloat()
        self.ersDeployedThisLap = dataCopy.readFloat()
        
        tires.removeAll()
    }
}
