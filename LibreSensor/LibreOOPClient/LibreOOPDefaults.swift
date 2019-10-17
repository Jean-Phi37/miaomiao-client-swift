//
//  LibreOOPDefaults.swift
//  SwitftOOPWeb
//
//  Created by Bjørn Inge Berg on 23.04.2018.
//  Copyright © 2018 Bjørn Inge Berg. All rights reserved.
//

import Foundation

struct LibreOOPDefaults {
    private static var _defaultState: [UInt8] = [
        0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    ]
    // Example Libre patch contents.
    // This would typically by a full readout of the sensor from a blureader,blucon, miaomiao or some other nfc to bluetooth bridge.
    private static var _testPatchAlwaysReturning63: [UInt8] = [
        0x3a, 0xcf, 0x10, 0x16, 0x03, 0x00, 0x00, 0x00, // 0x00 Begin of header
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 0x02 End of header
        0x4f, 0x11, 0x08, 0x10, 0xad, 0x02, 0xc8, 0xd4, // 0x03 Begin of body. CRC shoud be 4f 11. trendIndex: 8, historyIndex: 16
        0x5b, 0x00, 0xaa, 0x02, 0xc8, 0xb4, 0x1b, 0x80, // 0x04
        0xa9, 0x02, 0xc8, 0x9c, 0x5b, 0x00, 0xa9, 0x02, // 0x05
        0xc8, 0x8c, 0x1b, 0x80, 0xb0, 0x02, 0xc8, 0x30, // 0x06
        0x5c, 0x80, 0xb0, 0x02, 0x88, 0xe6, 0x9c, 0x80, // 0x07
        0xb8, 0x02, 0xc8, 0x3c, 0x9d, 0x80, 0xb8, 0x02, // 0x08
        0xc8, 0x60, 0x9d, 0x80, 0xa1, 0x02, 0xc8, 0xdc, // 0x09
        0x9e, 0x80, 0xab, 0x02, 0xc8, 0x14, 0x9e, 0x80, // 0x0A
        0xa9, 0x02, 0xc8, 0xc0, 0x9d, 0x80, 0xab, 0x02, // 0x0B
        0xc8, 0x78, 0x9d, 0x80, 0xaa, 0x02, 0xc8, 0x40, // 0x0C
        0x9d, 0x80, 0xa8, 0x02, 0xc8, 0x08, 0x9d, 0x80, // 0x0D
        0xa8, 0x02, 0xc8, 0x2c, 0x5c, 0x80, 0xad, 0x02, // 0x0E
        0xc8, 0xf8, 0x5b, 0x00, 0x29, 0x06, 0xc8, 0xf4, // 0x0F
        0x9b, 0x80, 0xc9, 0x05, 0xc8, 0x8c, 0xde, 0x80, // 0x10
        0xc3, 0x05, 0xc8, 0x28, 0x9e, 0x80, 0x2c, 0x06, // 0x11
        0xc8, 0xd0, 0x9e, 0x80, 0x7b, 0x06, 0x88, 0xa6, // 0x12
        0x9e, 0x80, 0xf9, 0x05, 0xc8, 0xb0, 0x9e, 0x80, // 0x13
        0x99, 0x05, 0xc8, 0xf0, 0x9e, 0x80, 0x2e, 0x05, // 0x14
        0xc8, 0x00, 0x9f, 0x80, 0x81, 0x04, 0xc8, 0x48, // 0x15
        0xa0, 0x80, 0x5d, 0x04, 0xc8, 0x38, 0x9d, 0x80, // 0x16
        0x12, 0x04, 0xc8, 0x10, 0x9e, 0x80, 0xcf, 0x03, // 0x17
        0xc8, 0x4c, 0x9e, 0x80, 0x6f, 0x03, 0xc8, 0xb8, // 0x18
        0x9e, 0x80, 0x19, 0x03, 0xc8, 0x40, 0x9f, 0x80, // 0x19
        0xc5, 0x02, 0xc8, 0xf4, 0x9e, 0x80, 0xaa, 0x02, // 0x1A
        0xc8, 0xf8, 0x5b, 0x00, 0xa2, 0x04, 0xc8, 0x38, // 0x1B
        0x9a, 0x00, 0xd1, 0x04, 0xc8, 0x28, 0x9b, 0x80, // 0x1C
        0xe4, 0x04, 0xc8, 0xe0, 0x1a, 0x80, 0x8f, 0x04, // 0x1D
        0xc8, 0x20, 0x9b, 0x80, 0x22, 0x06, 0xc8, 0x50, // 0x1E
        0x5b, 0x80, 0xbc, 0x06, 0xc8, 0x54, 0x9c, 0x80, // 0x1F
        0x7f, 0x05, 0xc8, 0x24, 0x5c, 0x80, 0xc9, 0x05, // 0x20
        0xc8, 0x38, 0x5c, 0x80, 0x38, 0x05, 0xc8, 0xf4, // 0x21
        0x1a, 0x80, 0x37, 0x07, 0xc8, 0x84, 0x5b, 0x80, // 0x22
        0xfb, 0x08, 0xc8, 0x4c, 0x9c, 0x80, 0xfb, 0x09, // 0x23
        0xc8, 0x7c, 0x9b, 0x80, 0x77, 0x0a, 0xc8, 0xe4, // 0x24
        0x5a, 0x80, 0xdf, 0x09, 0xc8, 0x88, 0x9f, 0x80, // 0x25
        0x6d, 0x08, 0xc8, 0x2c, 0x9f, 0x80, 0xc3, 0x06, // 0x26
        0xc8, 0xb0, 0x9d, 0x80, 0xd9, 0x11, 0x00, 0x00, // 0x27 End of body. Time: 4569 (0xd911 -> bytes swapped -> 0x11d9 = 4569)
        0x72, 0xc2, 0x00, 0x08, 0x82, 0x05, 0x09, 0x51, // 0x28 Beginn of footer
        0x14, 0x07, 0x96, 0x80, 0x5a, 0x00, 0xed, 0xa6, // 0x29
        0x0e, 0x6e, 0x1a, 0xc8, 0x04, 0xdd, 0x58, 0x6d  // 0x2A End of footer
    ]
    public static var TestPatchAlwaysReturning63: [UInt8] {
        return _testPatchAlwaysReturning63.map { $0 }
    }

    public static var defaultState: String {
        return Data(_defaultState).base64EncodedString()
    }
    public static var sensorStartTimestamp = 0x0e181349
    public static var sensorScanTimestamp = 0x0e1c4794
    public static var currentUtcOffset = 0x0036ee80
}
