//
//  ContentView.swift
//  hajimitest
//
//  Created by bemly on 2026/11/21.
//

import AppKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MemeCreation.createdAt, order: .reverse) private var creations: [MemeCreation]

    @State private var selectedSection: AppSection? = .forge
    @State private var selectedCategory: MemeCategory = .hajimi
    @State private var selectedTemplate: MemeTemplate = MemeEngine.templates[0]
    @State private var slotValues: [String: String] = MemeEngine.defaultValues(for: MemeEngine.templates[0])
    @State private var extraSuffix: String = ""
    @State private var filters = AbstractFilterOptions()
    @State private var generationSeed: Int = 1

    @State private var toastMessage: String? = nil
    @State private var toastTask: Task<Void, Never>? = nil

    var body: some View {
        NavigationSplitView {
            sidebarContent
                .navigationSplitViewColumnWidth(min: 185, ideal: 205, max: 245)
        } detail: {
            Group {
                switch selectedSection ?? .forge {
                case .forge:
                    MemeForgeView(
                        selectedCategory: $selectedCategory,
                        selectedTemplate: $selectedTemplate,
                        slotValues: $slotValues,
                        extraSuffix: $extraSuffix,
                        filters: $filters,
                        generationSeed: $generationSeed,
                        onCopy: copyToClipboard,
                        onSave: saveCreation
                    )
                case .lexicon:
                    MemeLexiconView(
                        onCopy: copyToClipboard,
                        onSendToForge: sendLexiconEntryToForge
                    )
                case .vault:
                    MemeVaultView(
                        onCopy: copyToClipboard,
                        onRemixInForge: remixCreationInForge,
                        onJumpToForge: { selectedSection = .forge }
                    )
                }
            }
            .overlay(alignment: .bottom) {
                if let toastMessage {
                    toastBanner(toastMessage)
                        .padding(.bottom, 22)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(duration: 0.28), value: toastMessage)
        }
    }

    private var sidebarContent: some View {
        List(selection: $selectedSection) {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Text("🐱")
                            .font(.title2)
                        VStack(alignment: .leading, spacing: 1) {
                            Text("哈基米造梗机")
                                .font(.headline)
                            Text("中文互联网抽象热梗构造器")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.vertical, 6)
            }

            Section("功能导航") {
                ForEach(AppSection.allCases) { section in
                    NavigationLink(value: section) {
                        HStack {
                            Label(section.rawValue, systemImage: section.symbol)
                            Spacer()
                            if section == .vault && !creations.isEmpty {
                                Text("\(creations.count)")
                                    .font(.caption2.monospacedDigit())
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.secondary.opacity(0.18), in: Capsule())
                            } else if section == .lexicon {
                                Text("\(MemeEngine.lexicon.count)")
                                    .font(.caption2.monospacedDigit())
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }

            Section("快速切换流派") {
                ForEach(MemeCategory.allCases) { category in
                    Button {
                        jumpToCategory(category)
                    } label: {
                        HStack(spacing: 8) {
                            Text(category.emoji)
                            Text(category.rawValue)
                                .font(.subheadline)
                            Spacer()
                            if selectedSection == .forge && selectedCategory == category {
                                Circle()
                                    .fill(category.accentColor)
                                    .frame(width: 7, height: 7)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.sidebar)
    }

    private func toastBanner(_ message: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
            Text(message)
                .font(.subheadline.weight(.medium))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.ultraThickMaterial, in: Capsule())
        .overlay(
            Capsule()
                .strokeBorder(Color.primary.opacity(0.12), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.15), radius: 10, y: 4)
    }

    // MARK: - Actions

    private func jumpToCategory(_ category: MemeCategory) {
        selectedCategory = category
        if let first = MemeEngine.templates(for: category).first {
            selectedTemplate = first
            slotValues = MemeEngine.defaultValues(for: first)
        }
        selectedSection = .forge
    }

    private func copyToClipboard(_ text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        showToast("已复制到剪贴板，快去群里发癫吧！")
    }

    private func saveCreation(content: String, template: MemeTemplate, score: Int) {
        let record = MemeCreation(
            title: template.title,
            content: content,
            category: template.category,
            templateID: template.id,
            abstractScore: score,
            isFavorite: true,
            tags: MemeEngine.hashtags(for: template.category)
        )
        modelContext.insert(record)
        showToast("已收录至「我的梗库」⭐")
    }

    private func sendLexiconEntryToForge(_ entry: MemeLexiconEntry) {
        selectedCategory = entry.category
        if let first = MemeEngine.templates(for: entry.category).first {
            selectedTemplate = first
            slotValues = MemeEngine.defaultValues(for: first)
        }
        if extraSuffix.isEmpty {
            extraSuffix = entry.term
        } else {
            extraSuffix += " \(entry.term)"
        }
        selectedSection = .forge
        showToast("已将「\(entry.term)」送入造梗工坊")
    }

    private func remixCreationInForge(_ creation: MemeCreation) {
        if let matchedTemplate = MemeEngine.templates.first(where: { $0.id == creation.templateID }) {
            selectedCategory = matchedTemplate.category
            selectedTemplate = matchedTemplate
            slotValues = MemeEngine.randomizedValues(for: matchedTemplate)
        } else {
            selectedCategory = creation.category
        }
        extraSuffix = ""
        generationSeed += 1
        selectedSection = .forge
        showToast("已载入同类模板，准备开始二创！")
    }

    private func showToast(_ message: String) {
        toastTask?.cancel()
        toastMessage = message
        toastTask = Task {
            try? await Task.sleep(for: .seconds(2.2))
            guard !Task.isCancelled else { return }
            toastMessage = nil
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: MemeCreation.self, inMemory: true)
        .frame(width: 1020, height: 680)
}
