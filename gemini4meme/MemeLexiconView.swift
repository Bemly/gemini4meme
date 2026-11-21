//
//  MemeLexiconView.swift
//  gemini4meme
//
//  中文互联网抽象热梗词典与灵感拼贴台
//

import SwiftUI

struct MemeLexiconView: View {
    let onCopy: (String) -> Void
    let onSendToForge: (MemeLexiconEntry) -> Void

    @State private var searchText: String = ""
    @State private var selectedCategory: MemeCategory? = nil

    private var filteredEntries: [MemeLexiconEntry] {
        MemeEngine.searchLexicon(query: searchText, category: selectedCategory)
    }

    var body: some View {
        VStack(spacing: 0) {
            filterBar
            Divider()

            if filteredEntries.isEmpty {
                ContentUnavailableView.search(text: searchText)
            } else {
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 320), spacing: 14)],
                        spacing: 14
                    ) {
                        ForEach(filteredEntries) { entry in
                            lexiconCard(entry)
                        }
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle("抽象热梗词典")
        .searchable(text: $searchText, prompt: "搜索热梗、释义或出处（如：哈基米、夯、回答我）")
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                categoryChip(title: "全部热梗 (\(MemeEngine.lexicon.count))", category: nil, color: .accentColor)
                ForEach(MemeCategory.allCases) { category in
                    categoryChip(
                        title: "\(category.emoji) \(category.rawValue)",
                        category: category,
                        color: category.accentColor
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private func categoryChip(title: String, category: MemeCategory?, color: Color) -> some View {
        let isSelected = selectedCategory == category
        return Button {
            withAnimation(.snappy(duration: 0.2)) {
                selectedCategory = category
            }
        } label: {
            Text(title)
                .font(.subheadline.weight(isSelected ? .semibold : .regular))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? color.opacity(0.18) : Color(nsColor: .controlBackgroundColor), in: Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(isSelected ? color : Color.primary.opacity(0.08), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    private func lexiconCard(_ entry: MemeLexiconEntry) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.term)
                        .font(.title3.bold())
                    Label(entry.category.rawValue, systemImage: entry.category.symbol)
                        .font(.caption)
                        .foregroundStyle(entry.category.accentColor)
                }
                Spacer()
                Text(String(repeating: "🔥", count: entry.hotLevel))
                    .font(.caption)
                    .help("流行热度 \(entry.hotLevel)/5")
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("释义：\(entry.meaning)")
                    .font(.subheadline)
                    .foregroundStyle(.primary)

                Text("出处：\(entry.origin)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("经典例句")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text("「\(entry.example)」")
                    .font(.callout)
                    .textSelection(.enabled)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(entry.category.accentColor.opacity(0.08), in: RoundedRectangle(cornerRadius: 10))
            }

            Spacer(minLength: 4)

            HStack(spacing: 8) {
                Button {
                    onCopy(entry.example)
                } label: {
                    Label("复制例句", systemImage: "doc.on.doc")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Spacer()

                Button {
                    onSendToForge(entry)
                } label: {
                    Label("送入造梗工坊", systemImage: "wand.and.stars")
                        .font(.caption)
                }
                .buttonStyle(.borderedProminent)
                .tint(entry.category.accentColor)
                .controlSize(.small)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
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
