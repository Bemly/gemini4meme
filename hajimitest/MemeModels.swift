//
//  MemeModels.swift
//  hajimitest
//
//  中文互联网抽象热梗构造器 - 核心数据模型
//

import Foundation
import SwiftData
import SwiftUI

enum MemeCategory: String, CaseIterable, Identifiable, Codable, Sendable {
    case hajimi = "哈基米圣经"
    case abstract = "抽象发疯"
    case workplace = "赛博牛马"
    case ruozhiba = "弱智吧哲学"
    case copypasta = "经典定型文"
    case interrogation = "回答我咆哮"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .hajimi: return "cat.fill"
        case .abstract: return "flame.fill"
        case .workplace: return "briefcase.fill"
        case .ruozhiba: return "brain.head.profile"
        case .copypasta: return "text.quote"
        case .interrogation: return "megaphone.fill"
        }
    }

    var emoji: String {
        switch self {
        case .hajimi: return "🐱"
        case .abstract: return "🤯"
        case .workplace: return "💼"
        case .ruozhiba: return "🧠"
        case .copypasta: return "📜"
        case .interrogation: return "😤"
        }
    }

    var accentColor: Color {
        switch self {
        case .hajimi: return .orange
        case .abstract: return .pink
        case .workplace: return .indigo
        case .ruozhiba: return .teal
        case .copypasta: return .purple
        case .interrogation: return .red
        }
    }

    var tagline: String {
        switch self {
        case .hajimi: return "哈基米哦南北绿豆，曼波旋律刻进 DNA"
        case .abstract: return "典孝急乐绷，情绪价值与精神状态双重拉满"
        case .workplace: return "先对齐颗粒度，再已老实求放过"
        case .ruozhiba: return "听君一席话，如听一席话的赛博哲学"
        case .copypasta: return "贴吧与评论区祖传圣经，一键丝滑套壳"
        case .interrogation: return "Look in my eyes! 灵魂拷问直接输出"
        }
    }
}

struct MemeSlot: Identifiable, Hashable, Sendable {
    let id: String
    let label: String
    let placeholder: String
    let suggestions: [String]
}

struct MemeTemplate: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let subtitle: String
    let category: MemeCategory
    let slots: [MemeSlot]
    let pattern: String
    let baseAbstractScore: Int
}

struct AbstractFilterOptions: Equatable, Sendable {
    var intensity: Double = 0.45
    var injectEmojis: Bool = true
    var homophoneTwist: Bool = false
    var parenthesesDrama: Bool = false
    var screamingPunctuation: Bool = false
    var appendHashtags: Bool = true
}

struct MemeLexiconEntry: Identifiable, Hashable, Sendable {
    let id: String
    let term: String
    let category: MemeCategory
    let origin: String
    let meaning: String
    let example: String
    let hotLevel: Int
}

struct MemeRankInfo: Equatable, Sendable {
    let title: String
    let subtitle: String
    let badgeEmoji: String
}

enum AppSection: String, CaseIterable, Identifiable {
    case forge = "造梗工坊"
    case lexicon = "抽象词典"
    case vault = "我的梗库"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .forge: return "wand.and.stars"
        case .lexicon: return "books.vertical.fill"
        case .vault: return "archivebox.fill"
        }
    }
}

@Model
final class MemeCreation {
    var id: UUID
    var title: String
    var content: String
    var categoryRaw: String
    var templateID: String
    var abstractScore: Int
    var isFavorite: Bool
    var createdAt: Date
    var tagsRaw: String

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        category: MemeCategory,
        templateID: String,
        abstractScore: Int,
        isFavorite: Bool = false,
        createdAt: Date = Date(),
        tags: [String] = []
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.categoryRaw = category.rawValue
        self.templateID = templateID
        self.abstractScore = abstractScore
        self.isFavorite = isFavorite
        self.createdAt = createdAt
        self.tagsRaw = tags.joined(separator: ",")
    }

    var category: MemeCategory {
        MemeCategory(rawValue: categoryRaw) ?? .abstract
    }

    var tags: [String] {
        tagsRaw
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}
