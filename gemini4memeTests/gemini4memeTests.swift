//
//  gemini4memeTests.swift
//  gemini4memeTests
//
//  Created by bemly on 2026/11/21.
//

import Testing
@testable import gemini4meme

@MainActor
struct gemini4memeTests {

    @Test func everyCategoryHasTemplatesAndLexiconEntries() {
        for category in MemeCategory.allCases {
            #expect(!MemeEngine.templates(for: category).isEmpty)
            #expect(!MemeEngine.searchLexicon(query: "", category: category).isEmpty)
        }
    }

    @Test func templateReplacesSlotsAndFallsBackToPlaceholder() {
        let template = MemeEngine.templates[0]
        var filters = AbstractFilterOptions()
        filters.intensity = 0.2
        filters.injectEmojis = false
        filters.appendHashtags = false

        let text = MemeEngine.generate(
            template: template,
            slotValues: ["subject": "测试猫猫", "food": "   ", "action": "原地起飞"],
            filters: filters
        )

        #expect(text.contains("测试猫猫"))
        #expect(text.contains("南北绿豆"))
        #expect(text.contains("原地起飞"))
        #expect(!text.contains("{subject}"))
        #expect(!text.contains("{food}"))
        #expect(!text.contains("{action}"))
    }

    @Test func abstractFiltersTransformTextAndRaiseScore() {
        let template = MemeEngine.templates.first(where: { $0.id == "abstract_jiarenmen" })!

        var mild = AbstractFilterOptions()
        mild.intensity = 0.1
        mild.injectEmojis = false
        mild.homophoneTwist = false
        mild.parenthesesDrama = false
        mild.screamingPunctuation = false
        mild.appendHashtags = false

        var intense = AbstractFilterOptions()
        intense.intensity = 0.95
        intense.injectEmojis = true
        intense.homophoneTwist = true
        intense.parenthesesDrama = true
        intense.screamingPunctuation = true
        intense.appendHashtags = true

        let values = MemeEngine.defaultValues(for: template)
        let mildText = MemeEngine.generate(template: template, slotValues: values, filters: mild, seed: 42)
        let intenseText = MemeEngine.generate(template: template, slotValues: values, filters: intense, seed: 42)

        #expect(intenseText.contains("尊嘟"))
        #expect(intenseText.contains("（"))
        #expect(intenseText.contains("！！！"))
        #expect(intenseText.contains("#"))

        let mildScore = MemeEngine.abstractScore(for: mildText, template: template, filters: mild)
        let intenseScore = MemeEngine.abstractScore(for: intenseText, template: template, filters: intense)
        #expect(intenseScore > mildScore)
    }

    @Test func lexiconSearchMatchesTermsAndCategories() {
        let hajimiResults = MemeEngine.searchLexicon(query: "哈基米", category: nil)
        #expect(!hajimiResults.isEmpty)
        #expect(hajimiResults.contains(where: { $0.term.contains("哈基米") }))

        let emptyResults = MemeEngine.searchLexicon(query: "不存在的神秘词条XYZ", category: nil)
        #expect(emptyResults.isEmpty)
    }
}
