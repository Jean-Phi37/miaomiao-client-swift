//
//  DataExtensions.swift
//  MiaomiaoClient
//
//  Created by Bjørn Inge Berg on 22/09/2019.
//  Copyright © 2019 Mark Wilson. All rights reserved.
//

import Foundation

extension Data {
    mutating func resetAllBytes() {
        self = Data()
    }

    // From Stackoverflow, see https://stackoverflow.com/questions/39075043/how-to-convert-data-to-hex-string-in-swift
    private static let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }

    public func hexEncodedString() -> String {
        return String(self.reduce(into: "".unicodeScalars, { result, value in
            result.append(Data.hexAlphabet[Int(value / 16)])
            result.append(Data.hexAlphabet[Int(value % 16)])
        }))
    }
}