//
//  BubbleTransmitter.swift
//  MiaomiaoClient
//
//  Created by Bjørn Inge Berg on 08/01/2020.
//  Copyright © 2020 Mark Wilson. All rights reserved.
//

import Foundation
import CoreBluetooth
import UIKit

public enum BubbleResponseType: UInt8 {
    case dataPacket = 130
    case bubbleInfo = 128 // = wakeUp + device info
    case noSensor = 191
    case serialNumber = 192
}

// The Bubble uses the same serviceUUID,
// writeCharachteristic and notifyCharachteristic
// as the MiaoMiao, but different byte sequences
class BubbleTransmitter: MiaoMiaoTransmitter{
    override class var shortTransmitterName: String {
        "bubble"
    }
    override class var manufacturerer: String {
        "bubbledevteam"
    }

    override class var smallImage: UIImage? {

        return UIImage(named: "bubble", in: Bundle.current, compatibleWith: nil)
    }

    override static func canSupportPeripheral(_ peripheral:CBPeripheral)->Bool{
        peripheral.name?.lowercased().starts(with: "bubble") ?? false
    }

    override func requestData(writeCharacteristics: CBCharacteristic, peripheral: CBPeripheral) {
        print("dabear:: bubbleRequestData")
        rxBuffer.resetAllBytes()
        //timer?.invalidate()
        print("-----set: ", writeCharacteristics)
        peripheral.writeValue(Data([0x00, 0x00, 0x05]), for: writeCharacteristics, type: .withResponse)


    }
    override func updateValueForNotifyCharacteristics(_ value: Data, peripheral: CBPeripheral, writeCharacteristic: CBCharacteristic?) {
        print("dabear:: bubbleDidUpdateValueForNotifyCharacteristics")
        guard let firstByte = value.first, let bubbleResponseState = BubbleResponseType(rawValue: firstByte) else {
           return
        }
        switch bubbleResponseState {
        case .bubbleInfo:
           let hardware = value[2].description + ".0"
           let firmware = value[1].description + ".0"
           let battery = Int(value[4])
           metadata = .init(hardware: hardware, firmware: firmware, battery: battery)

           print("dabear:: Got bubbledevice: \(metadata)")
           if let writeCharacteristic = writeCharacteristic {
               print("-----set: ", writeCharacteristic)
               peripheral.writeValue(Data([0x02, 0x00, 0x00, 0x00, 0x00, 0x2B]), for: writeCharacteristic, type: .withResponse)
           }
        case .dataPacket:
           rxBuffer.append(value.suffix(from: 4))
           if rxBuffer.count >= 352 {
               handleCompleteMessage()
               rxBuffer.resetAllBytes()
           }
        case .noSensor:
            delegate?.libreTransmitterReceivedMessage(0x0000, txFlags: 0x34, payloadData: rxBuffer)


           rxBuffer.resetAllBytes()
        case .serialNumber:
           rxBuffer.append(value.subdata(in: 2..<10))
        }
    }


    private var rxBuffer = Data()
    private var sensorData : SensorData?
    private var metadata: LibreTransmitterMetadata?

    override func handleCompleteMessage() {
        print("dabear:: bubbleHandleCompleteMessage")

        guard rxBuffer.count >= 352 else {
            return
        }

        let data = rxBuffer.subdata(in: 8..<352)
        print("dabear:: bubbleHandleCompleteMessage raw data: \([UInt8](rxBuffer))")
        sensorData = SensorData(uuid: rxBuffer.subdata(in: 0..<8), bytes: [UInt8](data), date: Date())


        if let sensorData = sensorData, let metadata = metadata {
            delegate?.libreTransmitterDidUpdate(with: sensorData, and: metadata)
        }


    }

}