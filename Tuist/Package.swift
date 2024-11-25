// swift-tools-version: 5.10
import PackageDescription

#if TUIST
  import ProjectDescription

  let packageSettings = PackageSettings(
    productTypes: [:]
  )
#endif

let package = Package(
  name: "Digio",
  dependencies: [
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
  ]
)
