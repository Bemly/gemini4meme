//
//  hajimitestApp.swift
//  hajimitest
//
//  Created by bemly on 2026/11/21.
//

import SwiftData
import SwiftUI

@main
struct hajimitestApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MemeCreation.self,
        ])
        let modelConfiguration = ModelConfiguration(
            "MemeForgeStore",
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // 如果本地持久化库初始化失败，降级为内存存储避免崩溃
            let fallbackConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: true
            )
            do {
                return try ModelContainer(for: schema, configurations: [fallbackConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }()

    var body: some Scene {
        WindowGroup("哈基米抽象热梗构造器") {
            ContentView()
                .frame(minWidth: 880, minHeight: 600)
        }
        .defaultSize(width: 1080, height: 720)
        .modelContainer(sharedModelContainer)
    }
}
