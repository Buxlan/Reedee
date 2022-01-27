//
//  Log.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 22.01.2022.
//

import Foundation
import XCGLogger

let log = XCGLogger.default

class LogInitializer {

    let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()

    init(_ application: UIApplication) {
        let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.systemDestination")
        systemDestination.showLogIdentifier = false
        systemDestination.showFunctionName = true
        systemDestination.showThreadName = true
        systemDestination.showLevel = true
        systemDestination.showFileName = true
        systemDestination.showLineNumber = true
        systemDestination.showDate = true
        log.add(destination: systemDestination)

        let logPath: URL = cacheDirectory.appendingPathComponent("TMKLog.txt")
        let fileDestination = AutoRotatingFileDestination(writeToFile: logPath, identifier: "advancedLogger.fileDestination",
                shouldAppend: true,
                attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication])
        fileDestination.showLogIdentifier = false
        fileDestination.showFunctionName = true
        fileDestination.showThreadName = true
        fileDestination.showLevel = true
        fileDestination.showFileName = true
        fileDestination.showLineNumber = true
        fileDestination.showDate = true
        fileDestination.logQueue = XCGLogger.logQueue
        fileDestination.targetMaxLogFiles = 10

        //#if DEBUG
        systemDestination.outputLevel = .info
        fileDestination.outputLevel = .debug
//        #else
//        systemDestination.outputLevel = .error
//        fileDestination.outputLevel = .error
//        #endif

        let ansiColorLogFormatter: ANSIColorLogFormatter = ANSIColorLogFormatter()
        ansiColorLogFormatter.colorize(level: .verbose, with: .colorIndex(number: 244), options: [.faint])
        ansiColorLogFormatter.colorize(level: .debug, with: .black)
        ansiColorLogFormatter.colorize(level: .info, with: .blue, options: [.underline])
        ansiColorLogFormatter.colorize(level: .warning, with: .red, options: [.faint])
        ansiColorLogFormatter.colorize(level: .error, with: .red, options: [.bold])
        ansiColorLogFormatter.colorize(level: .severe, with: .white, on: .red)
        fileDestination.formatters = [ansiColorLogFormatter]

        log.add(destination: fileDestination)
        log.logAppDetails()
    }
}

