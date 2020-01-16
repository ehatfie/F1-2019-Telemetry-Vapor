//
//  ButtonFlag.swift
//  
//
//  Created by Erik Hatfield on 12/31/19.
//

import Foundation
// uint16?
enum ButtonFlag: UInt16 {
    case CROSS = 0x0001
    case TRIANGLE = 0x0002
    case CIRCLE = 0x0004
    case SQUARE = 0x0008
    case D_PAD_LEFT = 0x0010
    case D_PAD_RIGHT = 0x0020
    case D_PAD_UP = 0x0040
    case D_PAD_DOWN = 0x0080
    case OPTIONS = 0x0100
    case L1 = 0x0200
    case R1 = 0x0400
    case L2 = 0x0800
    case R2 = 0x1000
    case LEFT_STICK_CLICK = 0x2000
    case RIGHT_STICK_CLICK = 0x4000
}
