class LogManager {
    static let LogFileDirectory = "\(NSHomeDirectory())/Documents"
    static var ShouldLogFile = true

    static func getLogMessage<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let timestamp = dateFormatter.string(from: Date())
        return "<\(timestamp)>[\(method)][\(message)]"
    }

    static func log<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
            logConsole(message, file: file, method: method, line: line)
        #endif
        logFile(message, file: file, method: method, line: line)
    }

    static func logConsole<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        let msg = getLogMessage(message, file: file, method: method, line: line)
        print(msg)
    }

    static func logFile<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        if ShouldLogFile {
            let msg = "\(getLogMessage(message, file: file, method: method, line: line))\n"
            let fileManager = FileManager()
            // check directory
            if !fileManager.fileExists(atPath: LogFileDirectory) {
                do {
                    try fileManager.createDirectory(at: URL(fileURLWithPath: LogFileDirectory), withIntermediateDirectories: true, attributes: [:])
                } catch {
                    log("Create log file directory fail.")
                    return
                }
            }
            // check log file
            let logFilePath = "\(LogFileDirectory)/\(getFileName())"
            if !fileManager.fileExists(atPath: logFilePath) {
                if !fileManager.createFile(atPath: logFilePath, contents: nil, attributes: [:]) {
                    log("Create log file fail.")
                    return
                }
            }
            // write file
            if fileManager.isWritableFile(atPath: logFilePath) {
                if let fileHandle = FileHandle(forWritingAtPath: logFilePath) {
                    fileHandle.seekToEndOfFile()
                    if let msgData = msg.data(using: String.Encoding.utf8) {
                        fileHandle.write(msgData)
                    }
                    fileHandle.closeFile()
                }
            }
        }
    }

    static func getFileName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: Date())
        return "\(date).log"
    }

    static func deleteLogFile(before date: Date) {
        let fileManager = FileManager()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let logFile = "\(dateFormatter.string(from: date)).log"
        do {
            let fileList = try fileManager.contentsOfDirectory(atPath: LogFileDirectory)
            for fileName in fileList {
                if fileName < logFile {
                    do {
                        let filePath = "\(LogFileDirectory)/\(fileName)"
                        try fileManager.removeItem(at: URL(fileURLWithPath: filePath))
                    } catch {
                        print("Delete \(fileName) fail.")
                    }
                }
            }
        } catch {
            print("Delete log file(s) fail.")
            return
        }
    }
}
