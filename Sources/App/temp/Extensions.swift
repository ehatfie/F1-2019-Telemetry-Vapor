//
//  File.swift
//  
//
//  Created by Erik Hatfield on 1/4/20.
//

import Foundation

extension UInt8 {
    func toInt() -> Int {
        let unsigned = self
        let signed = (unsigned <= UInt(Int.max)) ?
            Int(unsigned) :
            Int(unsigned - UInt8(Int.max) - 1) + Int.min

        return signed
    }
}
