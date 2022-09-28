import PackagePlugin
import Foundation

@main
struct GenerateContributors: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        guard let filePath = Bundle.main.path(forResource: "Contributors", ofType: "txt") else {
            return
        }
        let process = Process()
        process.executableURL = URL(fileURLWithPath: filePath)
        process.arguments = ["log"]

        let pipe = Pipe()
        process.standardOutput = pipe
        try process.run()
        process.waitUntilExit()

        let data = try pipe.fileHandleForReading.readToEnd()
        if let data = data {
            let output = String(decoding: data, as: UTF8.self)

            let contributors = Set(output.components(separatedBy: .newlines).sorted().filter { !$0.isEmpty })
            try contributors.joined(separator: "\n").write(toFile: "Sources/SessionCommandPlugin/Contributors.txt", atomically: true, encoding: .utf8)
        }
        
//        let list = ["User A", "User B", "User C"]
//        try list.joined(separator: "\n").write(toFile: "Sources/SessionCommandPlugin/Contributors.txt", atomically: true, encoding: .utf8)
    }
    
}
