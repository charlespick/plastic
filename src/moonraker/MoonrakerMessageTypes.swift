//
//  MoonrakerMessageTypes.swift
//  Plastic
//
//  Created by Charles Pickering on 9/13/22.
//

import Foundation

enum MoonrakerMethod: String {
    case printerInfo = "printer.info"
    case serverInfo = "server.info"
    case printerEmergency_stop = "printer.emergency_stop"
    case printerRestart = "printer.restart"
    case printerFirmware_restart = "printer.firmware_restart"
    //case notifyProcStatUpdate
}
