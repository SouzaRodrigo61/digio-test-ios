import ProjectDescription
import Foundation

// Função para obter a data atual formatada
func currentDateString() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter.string(from: date)
}

// Função para obter o nome do autor a partir do sistema
func systemAuthorName() -> String {
    if let fullName = runCommand(["id", "-F"]), !fullName.isEmpty {
        return fullName.trimmingCharacters(in: .whitespacesAndNewlines)
    } else if let userName = ProcessInfo.processInfo.environment["USER"] {
        return userName
    } else {
        return "Your Name"
    }
}

// Função para executar um comando e capturar a saída
func runCommand(_ arguments: [String]) -> String? {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = arguments

    let pipe = Pipe()
    process.standardOutput = pipe
    process.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    process.waitUntilExit()

    let output = String(data: data, encoding: .utf8)
    return output?.trimmingCharacters(in: .whitespacesAndNewlines)
}

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .optional("author", default: .string(systemAuthorName()))
let dateAttribute: Template.Attribute = .optional("date", default: .string(currentDateString())) // Data atual como valor padrão

let template = Template(
    description: "Template for creating a new feature",
    attributes: [
        nameAttribute,
        authorAttribute,
        dateAttribute,
    ],
    items: [
        .file(
            path: "Digio/Shared/\(nameAttribute)/\(nameAttribute).swift",
            templatePath: "Files/Sources/Feature.stencil"
        ),
        .file(
            path: "GetUpTimeTests/Shared/\(nameAttribute)/\(nameAttribute)Tests.swift",
            templatePath: "Files/Tests/Tests.stencil"
        ),
    ]
)
