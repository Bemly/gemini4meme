//
//  MemeVaultView.swift
//  gemini4meme
//
//  我的抽象梗库（SwiftData 持久化收藏与历史管理）
//

import SwiftData
import SwiftUI

struct MemeVaultView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MemeCreation.createdAt, order: .reverse) private var creations: [MemeCreation]

    let onCopy: (String) -> Void
    let onRemixInForge: (MemeCreation) -> Void
    let onJumpToForge: () -> Void

    @State private var searchText: String = ""
    @State private var favoritesOnly: Bool = false
    @State private var selectedCategory: MemeCategory? = nil

    private var filteredCreations: [MemeCreation] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        return creations.filter { item in
            if favoritesOnly && !item.isFavorite { return false }
            if let selectedCategory, item.category != selectedCategory { return false }
            if trimmed.isEmpty { return true }
            return item.content.localizedCaseInsensitiveContains(trimmed)
                || item.title.localizedCaseInsensitiveContains(trimmed)
                || item.categoryRaw.localizedCaseInsensitiveContains(trimmed)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            filterHeader
            Divider()

            if creations.isEmpty {
                ContentUnavailableView {
                    Label("梗库还是空的", systemImage: "archivebox")
                } description: {
                    Text("去「造梗工坊」整点抽象活，点击收藏后就会保存在这里。")
                } actions: {
                    Button("前往造梗工坊") {
                        onJumpToForge()
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else if filteredCreations.isEmpty {
                ContentUnavailableView.search(text: searchText)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredCreations) { creation in
                            vaultCard(creation)
                        }
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle("我的梗库 (\(creations.count))")
        .searchable(text: $searchText, prompt: "搜索已保存的抽象热梗")
    }

    private var filterHeader: some View {
        HStack(spacing: 12) {
            Toggle(isOn: $favoritesOnly) {
                Label("仅看星标收藏", systemImage: favoritesOnly ? "star.fill" : "star")
            }
            .toggleStyle(.button)
            .controlSize(.small)

            Picker("流派筛选", selection: $selectedCategory) {
                Text("全部流派").tag(MemeCategory?.none)
                ForEach(MemeCategory.allCases) { category in
                    Text("\(category.emoji) \(category.rawValue)").tag(MemeCategory?.some(category))
                }
            }
            .frame(width: 170)
            .controlSize(.small)

            Spacer()

            Text("共 \(filteredCreations.count) 条圣经")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private func vaultCard(_ creation: MemeCreation) -> some View {
        let rank = MemeEngine.rankInfo(for: creation.abstractScore)
        return VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("\(creation.category.emoji) \(creation.title)", systemImage: creation.category.symbol)
                    .font(.headline)
                    .foregroundStyle(creation.category.accentColor)

                Text("\(rank.badgeEmoji) \(creation.abstractScore)分")
                    .font(.caption.monospacedDigit())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(creation.category.accentColor.opacity(0.14), in: Capsule())

                Spacer()

                Text(creation.createdAt, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Button {
                    withAnimation {
                        creation.isFavorite.toggle()
                    }
                } label: {
                    Image(systemName: creation.isFavorite ? "star.fill" : "star")
                        .foregroundStyle(creation.isFavorite ? .yellow : .secondary)
                }
                .buttonStyle(.borderless)
                .help(creation.isFavorite ? "取消星标" : "加入星标")
            }

            Text(creation.content)
                .font(.body)
                .lineSpacing(4)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(Color(nsColor: .windowBackgroundColor), in: RoundedRectangle(cornerRadius: 10))

            HStack(spacing: 8) {
                ForEach(creation.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                    onRemixInForge(creation)
                } label: {
                    Label("回工坊二创", systemImage: "wand.and.stars")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Button {
                    onCopy(creation.content)
                } label: {
                    Label("复制", systemImage: "doc.on.doc")
                        .font(.caption)
                }
                .buttonStyle(.borderedProminent)
                .tint(creation.category.accentColor)
                .controlSize(.small)

                Button(role: .destructive) {
                    withAnimation {
                        modelContext.delete(creation)
                    }
                } label: {
                    Image(systemName: "trash")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .help("删除这条热梗")
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }
}
