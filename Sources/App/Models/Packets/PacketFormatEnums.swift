//
//  File.swift
//  
//
//  Created by Erik Hatfield on 12/30/19.
//

import Foundation

enum PacketFormat: Int {
    case motion = 0
    case session = 1
    case lapData = 2
    case event = 3
    case participants = 4
    case carSetups = 5
    case carTelemetry = 6
    case carStatus = 7
}
