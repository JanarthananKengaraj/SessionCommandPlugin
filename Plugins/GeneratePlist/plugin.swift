import PackagePlugin
import Foundation

@main
struct GenerateContributors: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        guard let filePath = arguments.first else {
            return
        }
        do {
            // Trying to write the file based on input path
            // arguments => Input path
            let list = [filePath]
            try list.joined(separator: "\n").write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            // Inacse of error while writing file on the input path
            let list = ["\(error.localizedDescription)"]
            try list.joined(separator: "\n").write(toFile: "file.txt", atomically: true, encoding: .utf8)
        }
    }
    
}
