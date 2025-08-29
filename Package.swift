// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Kuroneko",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(name: "Kuroneko", targets: ["Kuroneko"]),
  ],
  targets: [
    .target(name: "Kuroneko"),
    .testTarget( name: "KuronekoTests",dependencies: ["Kuroneko"]),
  ]
)
