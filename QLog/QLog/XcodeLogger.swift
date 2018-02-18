//
//  XcodeLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    var emoji: String {
        switch self {
        case .highlight:
            return "🔮"
        case .debug:
            return "🌀"
        case .info:
            return "📗"
        case .warning:
            return "⚠️"
        case .error:
            return "⛔️"
        }
    }

}

public class XcodeLogger: Logger {

    public var logLevel: LogLevel = .highlight

    public init(logLevel: LogLevel = .highlight) {
        self.logLevel = logLevel
    }

    public func doLog(_ logEntry: LogEntry) {
        print("\(logEntry.logLevel.emoji) \(logEntry.metaText)\(logEntry.text)")
    }

}
