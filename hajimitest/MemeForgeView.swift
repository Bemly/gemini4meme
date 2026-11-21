//
//  MemeForgeView.swift
//  hajimitest
//
//  核心造梗工坊界面：流派切换、槽位填词、抽象浓度滤镜、实时卡片 & 群聊预览
//

import SwiftUI

struct MemeForgeView: View {
    @Binding var selectedCategory: MemeCategory
    @Binding var selectedTemplate: MemeTemplate
    @Binding var slotValues: [String: String]
    @Binding var extraSuffix: String
    @Binding var filters: AbstractFilterOptions
    @Binding var generationSeed: Int

    let onCopy: (String) -> Void
    let onSave: (String, MemeTemplate, Int) -> Void

    @State private var previewMode: PreviewMode = .card
    @State private var groupNickname: String = "纯情哈基米"
    @State private var simulatedReactions: [String] = []

    enum PreviewMode: String, CaseIterable, Identifiable {
        case card = "梗卡片"
        case chat = "群聊发癫预览"

        var id: String { rawValue }
    }

    private var generatedText: String {
        MemeEngine.generate(
            template: selectedTemplate,
            slotValues: slotValues,
            extraSuffix: extraSuffix,
            filters: filters,
            seed: generationSeed
        )
    }

    private var currentScore: Int {
        MemeEngine.abstractScore(
            for: generatedText,
            template: selectedTemplate,
            filters: filters
        )
    }

    private var rankInfo: MemeRankInfo {
        MemeEngine.rankInfo(for: currentScore)
    }

    var body: some View {
        HStack(spacing: 0) {
            configuratorPane
                .frame(minWidth: 300, maxWidth: .infinity)
            Divider()
            previewPane
                .frame(minWidth: 300, maxWidth: .infinity)
        }
        .navigationTitle("造梗工坊 · \(selectedCategory.rawValue)")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    randomizeCurrentTemplate()
                } label: {
                    Label("摇个大活", systemImage: "dice.fill")
                }
                .keyboardShortcut("r", modifiers: .command)
                .help("随机填充当前模板的所有槽位 (⌘R)")

                Button {
                    surpriseBlindBox()
                } label: {
                    Label("彻底盲盒", systemImage: "sparkles")
                }
                .help("连流派、模板和滤镜一起全随机")

                Button {
                    onSave(generatedText, selectedTemplate, currentScore)
                } label: {
                    Label("存入梗库", systemImage: "bookmark.fill")
                }
                .keyboardShortcut("s", modifiers: .command)
                .help("保存到我的梗库 (⌘S)")

                Button {
                    onCopy(generatedText)
                } label: {
                    Label("复制发癫", systemImage: "doc.on.doc.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(selectedCategory.accentColor)
                .keyboardShortcut("c", modifiers: [.command, .shift])
                .help("复制当前抽象热梗到剪贴板 (⇧⌘C)")
            }
        }
    }

    // MARK: - 左侧配置区

    private var configuratorPane: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                categorySelectorSection
                templatePickerSection
                slotsEditorSection
                filterConsoleSection
                extraSeasoningSection
            }
            .padding(20)
        }
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private var categorySelectorSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader(title: "1. 选择抽象流派", subtitle: selectedCategory.tagline)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 8)], spacing: 8) {
                ForEach(MemeCategory.allCases) { category in
                    let isSelected = category == selectedCategory
                    Button {
                        selectCategory(category)
                    } label: {
                        HStack(spacing: 6) {
                            Text(category.emoji)
                            Text(category.rawValue)
                                .font(.subheadline.weight(isSelected ? .semibold : .regular))
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(isSelected ? category.accentColor.opacity(0.18) : Color(nsColor: .controlBackgroundColor))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .strokeBorder(isSelected ? category.accentColor : Color.primary.opacity(0.08), lineWidth: isSelected ? 1.5 : 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var templatePickerSection: some View {
        let templates = MemeEngine.templates(for: selectedCategory)
        return VStack(alignment: .leading, spacing: 10) {
            sectionHeader(title: "2. 挑选圣经模板", subtitle: "同一流派内置多种高频爆款句式")

            VStack(spacing: 8) {
                ForEach(templates) { template in
                    let isSelected = template.id == selectedTemplate.id
                    Button {
                        selectTemplate(template)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(isSelected ? selectedCategory.accentColor : .secondary)
                                .font(.title3)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(template.title)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                Text(template.subtitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("基础含梗 \(template.baseAbstractScore)")
                                .font(.caption2.monospacedDigit())
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(selectedCategory.accentColor.opacity(0.12), in: Capsule())
                                .foregroundStyle(selectedCategory.accentColor)
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(isSelected ? selectedCategory.accentColor.opacity(0.1) : Color(nsColor: .controlBackgroundColor))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .strokeBorder(isSelected ? selectedCategory.accentColor.opacity(0.6) : Color.primary.opacity(0.07), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var slotsEditorSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                sectionHeader(title: "3. 填入你的灵魂素材", subtitle: "留空自动使用默认整活词，可点骰子单独重抽")
                Spacer()
                Button {
                    randomizeCurrentTemplate()
                } label: {
                    Label("全槽随机", systemImage: "dice")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }

            VStack(spacing: 12) {
                ForEach(selectedTemplate.slots) { slot in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(slot.label)
                                .font(.subheadline.weight(.medium))
                            Spacer()
                            Button {
                                randomizeSlot(slot)
                            } label: {
                                Label("换一个", systemImage: "shuffle")
                                    .font(.caption2)
                            }
                            .buttonStyle(.borderless)
                            .foregroundStyle(selectedCategory.accentColor)
                        }

                        TextField(slot.placeholder, text: bindingForSlot(slot.id))
                            .textFieldStyle(.roundedBorder)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 6) {
                                ForEach(slot.suggestions, id: \.self) { suggestion in
                                    Button {
                                        slotValues[slot.id] = suggestion
                                    } label: {
                                        Text(suggestion)
                                            .font(.caption2)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.secondary.opacity(0.12), in: Capsule())
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color(nsColor: .controlBackgroundColor))
                    )
                }
            }
        }
    }

    private var filterConsoleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader(title: "4. 抽象浓度与滤镜调音台", subtitle: "实时调节发癫程度与加密风格")

            VStack(alignment: .leading, spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("抽象浓度")
                            .font(.subheadline.weight(.medium))
                        Spacer()
                        Text("\(Int(filters.intensity * 100))%")
                            .font(.subheadline.monospacedDigit().bold())
                            .foregroundStyle(selectedCategory.accentColor)
                    }
                    Slider(value: $filters.intensity, in: 0...1, step: 0.05)
                        .tint(selectedCategory.accentColor)
                    HStack {
                        Text("温和玩梗")
                        Spacer()
                        Text("精神美丽")
                        Spacer()
                        Text("彻底发癫")
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }

                Divider()

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    Toggle("Emoji 爆浆 😅", isOn: $filters.injectEmojis)
                    Toggle("谐音黑话加密", isOn: $filters.homophoneTwist)
                    Toggle("括号内心戏", isOn: $filters.parenthesesDrama)
                    Toggle("咆哮标点！！！", isOn: $filters.screamingPunctuation)
                    Toggle("热搜标签 #", isOn: $filters.appendHashtags)
                }
                .toggleStyle(.switch)
                .controlSize(.small)
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(nsColor: .controlBackgroundColor))
            )
        }
    }

    private var extraSeasoningSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                sectionHeader(title: "5. 自由加料区", subtitle: "点击热梗词条一键撒料，或手写补刀")
                Spacer()
                if !extraSuffix.isEmpty {
                    Button("清空加料") {
                        extraSuffix = ""
                    }
                    .font(.caption)
                    .buttonStyle(.borderless)
                    .foregroundStyle(.secondary)
                }
            }

            TextField("例如：家人们谁懂啊，顺便 V 我 50", text: $extraSuffix)
                .textFieldStyle(.roundedBorder)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 95), spacing: 6)], spacing: 6) {
                ForEach(MemeEngine.quickChips, id: \.self) { chip in
                    Button {
                        appendChip(chip)
                    } label: {
                        Text("+ \(chip)")
                            .font(.caption)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 8)
                            .background(selectedCategory.accentColor.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(.primary)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    // MARK: - 右侧实时预览区

    private var previewPane: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Picker("预览样式", selection: $previewMode) {
                    ForEach(PreviewMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .labelsHidden()
                .pickerStyle(.segmented)
                .frame(maxWidth: 200)

                Spacer()

                Button {
                    generationSeed += 1
                } label: {
                    Label("换个味儿", systemImage: "arrow.trianglehead.2.clockwise")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .help("保持输入不变，重新随机搭配表情与抽象词缀")
            }
            .padding(.horizontal, 18)
            .padding(.top, 16)
            .padding(.bottom, 12)

            ScrollView {
                VStack(spacing: 16) {
                    scoreDashboardCard

                    if previewMode == .card {
                        memeResultCard
                    } else {
                        groupChatPreviewCard
                    }

                    quickActionBar
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 24)
            }
        }
        .background(Color(nsColor: .underPageBackgroundColor))
    }

    private var scoreDashboardCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(rankInfo.badgeEmoji)
                    .font(.largeTitle)

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text("抽象段位：\(rankInfo.title)")
                            .font(.headline)
                        Text("\(currentScore) 分")
                            .font(.caption.monospacedDigit().bold())
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(selectedCategory.accentColor.opacity(0.18), in: Capsule())
                            .foregroundStyle(selectedCategory.accentColor)
                    }
                    Text(rankInfo.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(generatedText.count) 字")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: Double(currentScore), total: 100)
                .tint(selectedCategory.accentColor)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(selectedCategory.accentColor.opacity(0.25), lineWidth: 1)
        )
    }

    private var memeResultCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label(selectedTemplate.title, systemImage: selectedCategory.symbol)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(selectedCategory.accentColor)
                Spacer()
                Text(selectedCategory.emoji)
                    .font(.title3)
            }

            Divider()

            Text(generatedText)
                .font(.system(size: 17, weight: .medium, design: .rounded))
                .lineSpacing(6)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 6)

            HStack {
                Text("生成自「哈基米抽象热梗构造器」")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                Spacer()
                Text("可直接拖选或一键复制")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            selectedCategory.accentColor.opacity(0.12),
                            Color(nsColor: .controlBackgroundColor)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(selectedCategory.accentColor.opacity(0.35), lineWidth: 1.5)
        )
        .shadow(color: selectedCategory.accentColor.opacity(0.08), radius: 12, y: 4)
    }

    private var groupChatPreviewCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundStyle(selectedCategory.accentColor)
                Text("相亲相爱抽象一家人 (498)")
                    .font(.subheadline.weight(.semibold))
                Spacer()
                TextField("我的群昵称", text: $groupNickname)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 120)
                    .controlSize(.small)
            }

            Divider()

            // 模拟自己发出的气泡
            HStack(alignment: .top, spacing: 10) {
                Spacer(minLength: 24)

                VStack(alignment: .trailing, spacing: 4) {
                    Text(groupNickname.isEmpty ? "纯情哈基米" : groupNickname)
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                    Text(generatedText)
                        .font(.body)
                        .lineSpacing(4)
                        .textSelection(.enabled)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color.green.opacity(0.22))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .strokeBorder(Color.green.opacity(0.35), lineWidth: 1)
                        )
                }

                Text(selectedCategory.emoji)
                    .font(.title2)
                    .frame(width: 36, height: 36)
                    .background(selectedCategory.accentColor.opacity(0.2), in: Circle())
            }

            // 模拟群友反应
            if !simulatedReactions.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(simulatedReactions, id: \.self) { reaction in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                            Text(reaction)
                                .font(.callout)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(Color(nsColor: .windowBackgroundColor))
                                )
                            Spacer()
                        }
                    }
                }
                .padding(.top, 4)
            }

            HStack {
                Button {
                    triggerGroupReaction()
                } label: {
                    Label("模拟群友破防回复", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                if !simulatedReactions.isEmpty {
                    Button("清屏") {
                        withAnimation {
                            simulatedReactions.removeAll()
                        }
                    }
                    .font(.caption)
                    .buttonStyle(.borderless)
                    .foregroundStyle(.secondary)
                }
                Spacer()
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }

    private var quickActionBar: some View {
        HStack(spacing: 10) {
            Button {
                onCopy(generatedText)
            } label: {
                Label("一键复制去群里发癫", systemImage: "doc.on.doc.fill")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .tint(selectedCategory.accentColor)
            .controlSize(.large)

            Button {
                onSave(generatedText, selectedTemplate, currentScore)
            } label: {
                Label("收藏入库", systemImage: "bookmark.fill")
                    .lineLimit(1)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .fixedSize(horizontal: true, vertical: false)
        }
    }

    // MARK: - Helpers

    private func sectionHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func bindingForSlot(_ id: String) -> Binding<String> {
        Binding(
            get: { slotValues[id] ?? "" },
            set: { slotValues[id] = $0 }
        )
    }

    private func selectCategory(_ category: MemeCategory) {
        withAnimation(.snappy(duration: 0.2)) {
            selectedCategory = category
            if let first = MemeEngine.templates(for: category).first {
                selectedTemplate = first
                slotValues = MemeEngine.defaultValues(for: first)
            }
        }
    }

    private func selectTemplate(_ template: MemeTemplate) {
        withAnimation(.snappy(duration: 0.2)) {
            selectedTemplate = template
            slotValues = MemeEngine.defaultValues(for: template)
        }
    }

    private func randomizeSlot(_ slot: MemeSlot) {
        let current = slotValues[slot.id]
        let candidates = slot.suggestions.filter { $0 != current }
        slotValues[slot.id] = candidates.randomElement() ?? slot.suggestions.randomElement() ?? slot.placeholder
    }

    private func randomizeCurrentTemplate() {
        withAnimation(.snappy(duration: 0.2)) {
            slotValues = MemeEngine.randomizedValues(for: selectedTemplate)
            generationSeed += 1
        }
    }

    private func surpriseBlindBox() {
        withAnimation(.snappy(duration: 0.25)) {
            if let randomTemplate = MemeEngine.templates.randomElement() {
                selectedCategory = randomTemplate.category
                selectedTemplate = randomTemplate
                slotValues = MemeEngine.randomizedValues(for: randomTemplate)
                filters.intensity = Double([0.35, 0.55, 0.75, 0.9, 1.0].randomElement() ?? 0.75)
                filters.injectEmojis = true
                filters.homophoneTwist = Bool.random()
                filters.parenthesesDrama = Bool.random()
                filters.screamingPunctuation = Bool.random()
                generationSeed += 1
            }
        }
    }

    private func appendChip(_ chip: String) {
        if extraSuffix.isEmpty {
            extraSuffix = chip
        } else {
            extraSuffix += " \(chip)"
        }
    }

    private func triggerGroupReaction() {
        let unused = MemeEngine.groupReactions.filter { !simulatedReactions.contains($0) }
        let pick = unused.randomElement() ?? MemeEngine.groupReactions.randomElement()!
        withAnimation(.spring(duration: 0.3)) {
            if simulatedReactions.count >= 4 {
                simulatedReactions.removeFirst()
            }
            simulatedReactions.append(pick)
        }
    }
}
