//
//  MemeEngine.swift
//  hajimitest
//
//  中文互联网抽象热梗构造引擎与词库
//

import Foundation

enum MemeEngine {
    static let templates: [MemeTemplate] = [
        // MARK: - 哈基米圣经
        MemeTemplate(
            id: "hajimi_lvdou",
            title: "哈基米南北绿豆大法",
            subtitle: "魔性鬼畜洗脑，哈基米浓度 100%",
            category: .hajimi,
            slots: [
                MemeSlot(
                    id: "subject",
                    label: "主角 / 小生物",
                    placeholder: "圆头耄耋",
                    suggestions: ["圆头耄耋", "小区橘猫", "通宵写代码的我", "楼下大白鹅", "满级哈基米"]
                ),
                MemeSlot(
                    id: "food",
                    label: "关键供品",
                    placeholder: "南北绿豆",
                    suggestions: ["南北绿豆", "冰美式", "冻干小鱼干", "两块钱雪王", "过期猫条"]
                ),
                MemeSlot(
                    id: "action",
                    label: "抽象举动",
                    placeholder: "原地哈气三连击",
                    suggestions: ["原地哈气三连击", "开启涡轮增压跑酷", "在键盘上踩出 git push -f", "唱起曼波小曲", "一巴掌拍飞手机"]
                )
            ],
            pattern: "哈基米哦{food}，阿西嘎压库乃鲁！刚才路过看见一只{subject}，二话不说冲着我{action}，曼波~ 哇呜~ 直接给我整不会了，这波属于是顶级哈基米认证。",
            baseAbstractScore: 76
        ),
        MemeTemplate(
            id: "hajimi_manbo",
            title: "曼波赛博咏叹调",
            subtitle: "曼波~ 哇呜~ 精神状态丝滑切换",
            category: .hajimi,
            slots: [
                MemeSlot(
                    id: "scene",
                    label: "发生场景",
                    placeholder: "凌晨三点的工位",
                    suggestions: ["凌晨三点的工位", "早八第一排", "地铁晚高峰", "食堂打饭窗口", "相亲局现场"]
                ),
                MemeSlot(
                    id: "trigger",
                    label: "触发事件",
                    placeholder: "Xcode 又开始全量重编",
                    suggestions: ["Xcode 又开始全量重编", "外卖被偷了", "老板发来在吗", "手机只剩 1% 电量", "耳机突然外放鬼畜"]
                ),
                MemeSlot(
                    id: "ending",
                    label: "最终心态",
                    placeholder: "化身纯情哈基米开始曼波",
                    suggestions: ["化身纯情哈基米开始曼波", "灵魂出窍飞去二次元", "对着空气哈气", "当场躺平变成一块绿豆糕", "已老实并学会了猫叫"]
                )
            ],
            pattern: "家人们，我在{scene}遇到{trigger}，大脑 CPU 直接干烧，脑子里只剩下一句：曼波~ 曼波~ 欧马吉利曼波！现在已经{ending}，别救我，让音乐继续放。",
            baseAbstractScore: 72
        ),

        // MARK: - 抽象发疯
        MemeTemplate(
            id: "abstract_jiarenmen",
            title: "家人们谁懂啊发癫体",
            subtitle: "小红书/微博经典情绪拉满模板",
            category: .abstract,
            slots: [
                MemeSlot(
                    id: "person",
                    label: "离谱主角",
                    placeholder: "一个超级下头的逆天哥们",
                    suggestions: ["一个超级下头的逆天哥们", "隔壁工位卷王", "野生键盘侠", "我的前任电脑", "神秘路人甲"]
                ),
                MemeSlot(
                    id: "place",
                    label: "案发现场",
                    placeholder: "公司茶水间",
                    suggestions: ["公司茶水间", "大学图书馆", "小区电梯里", "微信百人大群", "海底捞排队区"]
                ),
                MemeSlot(
                    id: "event",
                    label: "逆天行为",
                    placeholder: "外放土味 DJ 还问我好不好听",
                    suggestions: ["外放土味 DJ 还问我好不好听", "把我的代码全删了说帮我重构", "吃泡面只喝汤把面倒了", "当众表演原地后空翻", "疯狂输出三千字小作文"]
                ),
                MemeSlot(
                    id: "reaction",
                    label: "我的反应",
                    placeholder: "一整个大无语住，差点当场阴暗爬行",
                    suggestions: ["一整个大无语住，差点当场阴暗爬行", "直接给我干沉默了", "脚趾抠出三室一厅", "汗流浃背了老弟", "当场笑出猪叫然后拉黑"]
                )
            ],
            pattern: "家人们谁懂啊！今天在{place}碰见{person}，居然当着所有人的面{event}！我真的会谢，我{reaction}。咱就是说，这很难评，祝他成功吧。",
            baseAbstractScore: 68
        ),
        MemeTemplate(
            id: "abstract_luren",
            title: "纯路人客观锐评",
            subtitle: "叠满甲之后精准开炮",
            category: .abstract,
            slots: [
                MemeSlot(
                    id: "subjectA",
                    label: "被拉踩对象",
                    placeholder: "连开两小时无意义周会",
                    suggestions: ["连开两小时无意义周会", "香菜披萨", "周一早九点", "收费 998 的成功学", "某知名半成品游戏"]
                ),
                MemeSlot(
                    id: "subjectB",
                    label: "封神对比对象",
                    placeholder: "楼下三块钱的烤肠",
                    suggestions: ["楼下三块钱的烤肠", "午休二十分钟", "一顿疯狂星期四", "带薪拉屎", "哈基米清唱版"]
                ),
                MemeSlot(
                    id: "verdict",
                    label: "暴论收尾",
                    placeholder: "建议直接抬走，下一位",
                    suggestions: ["建议直接抬走，下一位", "属于是给路人看笑了", "纯纯答辩，没啥好洗的", "不如回家种红薯", "这波我站对面，别喷我"]
                )
            ],
            pattern: "有一说一，纯路人，不吹不黑，先叠个甲：我对双方都没意见。但是平心而论，{subjectA}真的不如{subjectB}一根！理性讨论，勿喷，{verdict}。",
            baseAbstractScore: 65
        ),
        MemeTemplate(
            id: "abstract_fafeng",
            title: "阴暗爬行发疯文学",
            subtitle: "精神状态领先版本十年",
            category: .abstract,
            slots: [
                MemeSlot(
                    id: "trigger",
                    label: "破防诱因",
                    placeholder: "刚写完的文档没保存就闪退了",
                    suggestions: ["刚写完的文档没保存就闪退了", "周末突然被拉进紧急会议", "连抽十发全歪", "快递寄丢了", "闹钟响了八遍还是没醒"]
                ),
                MemeSlot(
                    id: "action",
                    label: "发疯形态",
                    placeholder: "扭曲、尖叫、在走廊里阴暗地爬行",
                    suggestions: ["扭曲、尖叫、在走廊里阴暗地爬行", "化身哥斯拉喷射彩虹激光", "在工位上旋转跳跃闭着眼", "变成一颗蘑菇静静发霉", "抱着柱子大喊莫欺少年穷"]
                ),
                MemeSlot(
                    id: "demand",
                    label: "卑微诉求",
                    placeholder: "立刻给我放三天带薪假",
                    suggestions: ["立刻给我放三天带薪假", "V 我 50 吃疯狂星期四", "让这个世界安静五分钟", "一键把 Bug 全变成 Feature", "马上端上一碗热乎的螺蛳粉"]
                )
            ],
            pattern: "哈哈哈哈哈哈我没疯！我真的没疯！只是因为{trigger}，我现在只想{action}！谁也别拦着我！我的精神状态非常美丽非常稳定！除非现在{demand}，否则谁来都不好使！",
            baseAbstractScore: 80
        ),

        // MARK: - 赛博牛马
        MemeTemplate(
            id: "workplace_buzzword",
            title: "大厂黑话 × 牛马破防",
            subtitle: "前半段高大上，后半段原形毕露",
            category: .workplace,
            slots: [
                MemeSlot(
                    id: "buzzword",
                    label: "高级黑话抓手",
                    placeholder: "拉通底层逻辑并对齐颗粒度",
                    suggestions: ["拉通底层逻辑并对齐颗粒度", "打造差异化生态闭环", "沉淀可复用的方法论抓手", "实现多维场景垂直赋能", "构建去中心化心智护城河"]
                ),
                MemeSlot(
                    id: "task",
                    label: "实际离谱需求",
                    placeholder: "把按钮放大一像素再改回原样",
                    suggestions: ["把按钮放大一像素再改回原样", "五分钟内做出一个五彩斑斓的黑", "零预算做到全网爆火", "通宵整理三百页没人看的 PPT", "兼容二十年前的浏览器"]
                ),
                MemeSlot(
                    id: "truth",
                    label: "牛马内心独白",
                    placeholder: "这班是一天也上不下去了，已老实求放过",
                    suggestions: ["这班是一天也上不下去了，已老实求放过", "我只是个想按时下班的赛博牛马", "月底发工资前我选择短暂失忆", "表面收到，心里已经辞职八百回", "建议直接把我打包优化掉谢谢"]
                )
            ],
            pattern: "关于这个项目，我们需要先{buzzword}，核心目标就是高效落地「{task}」，形成正向飞轮效应。——翻译成人话：{truth}。",
            baseAbstractScore: 66
        ),
        MemeTemplate(
            id: "workplace_laoshi",
            title: "已老实，求放过",
            subtitle: "赛博认怂，以退为进的终极防御",
            category: .workplace,
            slots: [
                MemeSlot(
                    id: "past",
                    label: "曾经年少轻狂",
                    placeholder: "靠努力就能实现财富自由",
                    suggestions: ["靠努力就能实现财富自由", "我写的代码绝不会有 Bug", "今晚十一点前一定睡觉", "大厂福报能让我成长", "熬夜刷手机不会掉头发"]
                ),
                MemeSlot(
                    id: "reality",
                    label: "现实精准毒打",
                    placeholder: "被连环需求按在地上摩擦",
                    suggestions: ["被连环需求按在地上摩擦", "体检报告亮起一片红灯", "工资刚到账就贡献给了房东", "线上崩溃日志刷屏三万条", "早八闹钟把我灵魂抽干"]
                ),
                MemeSlot(
                    id: "plea",
                    label: "现在唯一愿望",
                    placeholder: "每天准点下班且外卖不洒汤",
                    suggestions: ["每天准点下班且外卖不洒汤", "老板别在周五下午六点发微信", "空调 26 度加冰镇可乐", "发际线别再往后撤退了", "平静地当一条咸鱼"]
                )
            ],
            pattern: "已老实，求放过。以前我天真地以为{past}，结果现实直接让我{reality}。现在我彻底悟了，不装了，摊牌了，人生只求{plea}，其他的你们爱卷谁卷谁。",
            baseAbstractScore: 64
        ),

        // MARK: - 弱智吧哲学
        MemeTemplate(
            id: "ruozhiba_paradox",
            title: "弱智吧深夜神思考",
            subtitle: "看似毫无逻辑，细品竟然有点道理",
            category: .ruozhiba,
            slots: [
                MemeSlot(
                    id: "objectA",
                    label: "元素 A",
                    placeholder: "把一台开着冷风的空调",
                    suggestions: ["把一台开着冷风的空调", "如果我给我的影子", "把一瓶过期十年的毒药", "如果把一只复读机", "把两块磁铁的同极"]
                ),
                MemeSlot(
                    id: "objectB",
                    label: "奇妙操作 B",
                    placeholder: "放进正在加热的微波炉里",
                    suggestions: ["放进正在加热的微波炉里", "偷偷报一个早八网课", "倒进加满冰块的开水壶", "放在回音谷里循环播放", "粘在扫地机器人底盘上"]
                ),
                MemeSlot(
                    id: "paradox",
                    label: "烧脑灵魂结论",
                    placeholder: "那它最后到底是冷战还是热恋",
                    suggestions: ["那它最后到底是冷战还是热恋", "那算我缺勤还是影子替我卷了", "那算不算实现了永动机闭环", "那我是不是就拥有了量子叠加态", "那地球会不会因此少转半圈"]
                )
            ],
            pattern: "深夜突然想到一个问题：{objectA}{objectB}，{paradox}？在线等，挺急的，脑子已经开始冒烟了。",
            baseAbstractScore: 70
        ),
        MemeTemplate(
            id: "ruozhiba_feihua",
            title: "听君一席话废话大师",
            subtitle: "说了跟没说一样，但语气无比庄重",
            category: .ruozhiba,
            slots: [
                MemeSlot(
                    id: "topic",
                    label: "一本正经的主题",
                    placeholder: "怎么才能睡个好觉",
                    suggestions: ["怎么才能睡个好觉", "如何快速变成有钱人", "为什么代码总是报错", "怎样才能不感到饥饿", "如何提升人生幸福感"]
                ),
                MemeSlot(
                    id: "obviousA",
                    label: "废话前提",
                    placeholder: "当你彻底闭上眼睛并且睡着之后",
                    suggestions: ["当你彻底闭上眼睛并且睡着之后", "只要你的银行卡余额足够多", "如果你一行代码都不写", "当你吃饱喝足不再饿的时候", "只要你把所有烦恼都忘掉"]
                ),
                MemeSlot(
                    id: "obviousB",
                    label: "废话结论",
                    placeholder: "你就成功进入睡眠状态了",
                    suggestions: ["你就成功进入睡眠状态了", "你就不再是一个穷人了", "程序就绝对不会因为你而报错", "你就不会再觉得肚子饿了", "你就已经没有烦恼了"]
                )
            ],
            pattern: "关于「{topic}」，我总结了毕生经验：经过严密论证，{obviousA}，那么从某种意义上讲，{obviousB}。听君一席话，真是胜似一席话，建议全文背诵。",
            baseAbstractScore: 62
        ),

        // MARK: - 经典定型文
        MemeTemplate(
            id: "copypasta_yousaidright",
            title: "你说的对，但是……",
            subtitle: "万能转折定型文，强行安利一切",
            category: .copypasta,
            slots: [
                MemeSlot(
                    id: "work",
                    label: "安利对象名称",
                    placeholder: "哈基米抽象构造器",
                    suggestions: ["哈基米抽象构造器", "疯狂星期四", "早八睡觉大法", "SwiftUI 摸鱼指南", "楼下煎饼果子摊"]
                ),
                MemeSlot(
                    id: "creator",
                    label: "幕后研发方",
                    placeholder: "凌晨三点不睡觉的神秘网友",
                    suggestions: ["凌晨三点不睡觉的神秘网友", "资深赛博牛马协会", "小区橘猫联合会", "弱智吧诺贝尔评审团", "银河系摸鱼局"]
                ),
                MemeSlot(
                    id: "world",
                    label: "奇幻世界观",
                    placeholder: "充满抽象热梗与电子榨菜的互联网大陆",
                    suggestions: ["充满抽象热梗与电子榨菜的互联网大陆", "无限循环的周一早晨", "没有 DDL 的乌托邦", "全是猫猫头表情包的赛博宇宙", "碳水化合物神圣帝国"]
                ),
                MemeSlot(
                    id: "feature",
                    label: "离谱核心玩法",
                    placeholder: "收集散落各处的抽象圣经并一键发癫",
                    suggestions: ["收集散落各处的抽象圣经并一键发癫", "一边汗流浃背一边高喊优雅", "用最少的话激怒最多的群友", "在工位上实现精神瞬移", "把普通日常翻译成顶级热梗"]
                )
            ],
            pattern: "你说的对，但是《{work}》是由{creator}自主研发的一款全新开放世界抽象体验。故事发生在一个被称作「{world}」的幻想世界，在这里，被选中的人将被授予「抽象之眼」，导引热梗之力。你将扮演一位神秘的冲浪手，在自由的旅行中{feature}——同时，逐步发掘「互联网精神状态」的真相。",
            baseAbstractScore: 78
        ),
        MemeTemplate(
            id: "copypasta_tierlist",
            title: "夯到拉锐评排行榜",
            subtitle: "夯 / 顶级 / 人上人 / NPC / 拉完了",
            category: .copypasta,
            slots: [
                MemeSlot(
                    id: "item",
                    label: "被评分对象",
                    placeholder: "周五下午五点半的阳光",
                    suggestions: ["周五下午五点半的阳光", "冰镇西瓜最中间那一口", "早八突然宣布停课", "老板画的大饼", "带薪摸鱼喝奶茶"]
                ),
                MemeSlot(
                    id: "tier",
                    label: "档次定级",
                    placeholder: "夯爆了！直接给到夯！",
                    suggestions: ["夯爆了！直接给到夯！", "顶级，毫无疑问的顶级", "人上人，有点东西", "纯纯 NPC，不好不坏", "拉完了！直接扔进拉完了！"]
                ),
                MemeSlot(
                    id: "reason",
                    label: "锐评理由",
                    placeholder: "体验丝滑得像刚拆封的旗舰机，没有任何短板",
                    suggestions: ["体验丝滑得像刚拆封的旗舰机，没有任何短板", "懂的都懂，不懂的说明还没被毒打过", "情绪价值直接喂到嘴边，简直无敌", "主打一个食之无味弃之可惜", "看一眼就让人血压飙升，纯粹折磨人"]
                )
            ],
            pattern: "今天给「{item}」排个榜：不废话，{tier} 理由很简单：{reason}。同意的扣 1，不同意的评论区自己开一桌，我先去给下一个打分了。",
            baseAbstractScore: 74
        ),
        MemeTemplate(
            id: "copypasta_sixwords",
            title: "贴吧六字真言对线体",
            subtitle: "典、孝、急、乐、绷、赢",
            category: .copypasta,
            slots: [
                MemeSlot(
                    id: "target",
                    label: "观察对象",
                    placeholder: "群里那位老懂哥",
                    suggestions: ["群里那位老懂哥", "评论区热评第一", "刚睡醒的室友", "疯狂催更的甲方", "嘴硬的我自己"]
                ),
                MemeSlot(
                    id: "behavior",
                    label: "名场面行为",
                    placeholder: "洋洋洒洒写了五百字证明自己没破防",
                    suggestions: ["洋洋洒洒写了五百字证明自己没破防", "连发十条语音条复读同一句话", "嘴上说着无所谓但手速比谁都快", "把陈年老梗当新发现到处科普", "刚立完 Flag 三秒钟就被打脸"]
                ),
                MemeSlot(
                    id: "verdict",
                    label: "终极锐评",
                    placeholder: "典中典，已经开始替他脚趾扣地了",
                    suggestions: ["典中典，已经开始替他脚趾扣地了", "急了急了，汗流浃背了吧老弟", "绷不住了，这节目效果直接拉满", "赢麻了，建议直接录入抽象博物馆", "乐子人狂喜，请加大力度"]
                )
            ],
            pattern: "笑死，刚围观完{target}{behavior}，我只能评价六个字：典、急、乐、绷！{verdict}。",
            baseAbstractScore: 73
        ),

        // MARK: - 回答我咆哮
        MemeTemplate(
            id: "interrogation_lookinmyeyes",
            title: "回答我！Look in my eyes!",
            subtitle: "老祖宗同款压迫感灵魂拷问",
            category: .interrogation,
            slots: [
                MemeSlot(
                    id: "target",
                    label: "拷问对象",
                    placeholder: "凌晨两点还在刷短视频的你",
                    suggestions: ["凌晨两点还在刷短视频的你", "把 Bug 留给下一任的程序员", "说好只喝一杯奶茶的嘴", "周五下班前改需求的甲方", "把空调开到 16 度还盖棉被的你"]
                ),
                MemeSlot(
                    id: "crime",
                    label: "离谱罪状",
                    placeholder: "明明答应了早睡却越刷越精神",
                    suggestions: ["明明答应了早睡却越刷越精神", "写完代码一行注释都不留", "买了一堆书却只用来垫显示器", "说好减肥却点了双人份烧烤", "把所有截止日期都拖到最后一小时"]
                ),
                MemeSlot(
                    id: "question",
                    label: "灵魂质问",
                    placeholder: "明天早起的时候你的良心不会痛吗",
                    suggestions: ["明天早起的时候你的良心不会痛吗", "你对得起自己立下的年度 Flag 吗", "你是不是以为自己有九条命", "你到底什么时候才能真正长点记性", "你是怎么做到如此理直气壮的"]
                )
            ],
            pattern: "回答我！{target}，Look in my eyes！Tell me why！为什么{crime}？！{question}？！说话！回答我！啊能能能能能……算了，我也这样，一起摆烂吧。",
            baseAbstractScore: 84
        ),
        MemeTemplate(
            id: "interrogation_nawowenni",
            title: "那我问你反杀体",
            subtitle: "气势拉满，逻辑全靠音量支撑",
            category: .interrogation,
            slots: [
                MemeSlot(
                    id: "identity",
                    label: "对方宣称",
                    placeholder: "你不是说这个需求很简单十分钟就能搞定吗",
                    suggestions: ["你不是说这个需求很简单十分钟就能搞定吗", "你不是说今天绝对不熬夜吗", "你不是说这把稳赢吗", "你不是说自己只是随便逛逛不买吗", "你不是说天气预报说今天不下雨吗"]
                ),
                MemeSlot(
                    id: "scenario",
                    label: "打脸现状",
                    placeholder: "结果现在凌晨一点还在修崩溃",
                    suggestions: ["结果现在凌晨一点还在修崩溃", "结果购物车已经堆到四位数", "结果战绩直接打出 0-12", "结果出门就被淋成落汤鸡", "结果闹钟响了你连被窝都没出"]
                ),
                MemeSlot(
                    id: "counter",
                    label: "致命追问",
                    placeholder: "那你这嘴是不是开过光啊",
                    suggestions: ["那你这嘴是不是开过光啊", "那你刚才那股自信去哪了呢", "那现在这烂摊子咱俩谁来背锅", "那我请问你是不是在演我", "那我是不是还得给你颁个最佳喜剧奖"]
                )
            ],
            pattern: "那我问你！{identity}？{scenario}！那我问你，{counter}？！别低头，别装看不见，给我个解释！",
            baseAbstractScore: 79
        )
    ]

    static let quickChips: [String] = [
        "哈基米", "曼波~", "已老实求放过", "汗流浃背了吧老弟",
        "这很难评", "纯路人", "夯爆了", "拉完了",
        "尊嘟假嘟", "回答我！", "包的", "神金",
        "泰酷辣", "急了急了", "典中典", "精神状态良好",
        "给你点个赞👍", "（阴暗爬行）", "V我50", "草生"
    ]

    static let lexicon: [MemeLexiconEntry] = [
        MemeLexiconEntry(
            id: "lex_hajimi",
            term: "哈基米 / 南北绿豆",
            category: .hajimi,
            origin: "源自《赛马娘》东海帝王哼唱「蜂蜜（はちみー）」的二创洗脑神曲，后演化成猫咪与万物抽象鬼畜代称。",
            meaning: "原指蜂蜜饮料，在中文互联网演变为可爱猫猫/小动物的昵称，以及鬼畜调音、魔性翻唱的通用灵魂符号。",
            example: "哈基米哦南北绿豆，阿西嘎压库乃鲁，楼下这只圆头橘猫今天哈气格外响亮。",
            hotLevel: 5
        ),
        MemeLexiconEntry(
            id: "lex_manbo",
            term: "曼波~（Manbo）",
            category: .hajimi,
            origin: "源自《赛马娘》诗歌剧角色语音「曼波、欧马吉利曼波」，配合鬼畜节奏全网爆火。",
            meaning: "表达一种魔性、欢脱、精神状态略微超前或彻底摆烂后的洗脑快乐。",
            example: "改完第 18 版需求后我整个人已经进入曼波状态：曼波~ 哇呜~",
            hotLevel: 5
        ),
        MemeLexiconEntry(
            id: "lex_huidaw",
            term: "回答我！Look in my eyes!",
            category: .interrogation,
            origin: "源自 AI 历史人物整活视频（如李世民、扁鹊等咆哮式质问），因极强反差感和情绪张力出圈。",
            meaning: "用于极度夸张地灵魂拷问某件离谱小事，自带咆哮与戏剧压迫感。",
            example: "回答我！Look in my eyes! Tell me why! 你为什么把最后一颗草莓吃掉了？！",
            hotLevel: 5
        ),
        MemeLexiconEntry(
            id: "lex_hang",
            term: "夯 / 拉完了",
            category: .copypasta,
            origin: "源自中文互联网从夯到拉排行榜（夯、顶级、人上人、NPC、拉完了）打分热潮。",
            meaning: "「夯」指强到离谱、天花板级别；「拉完了」指差到谷底、毫无亮点。",
            example: "周五下班吃顿火锅直接给到夯，周一早八开会纯纯拉完了。",
            hotLevel: 5
        ),
        MemeLexiconEntry(
            id: "lex_laoshi",
            term: "已老实，求放过",
            category: .workplace,
            origin: "源自网友被现实、难度或舆论精准教育后的光速滑跪话术。",
            meaning: "表示自己彻底认怂、不再嘴硬，求命运/老板/生活高抬贵手。",
            example: "尝试通宵重构祖传代码十分钟后：已老实，求放过，旧代码能跑就行。",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_hanliu",
            term: "汗流浃背了吧老弟",
            category: .abstract,
            origin: "源自游戏主播与对战圈调侃对手紧张破防的口头禅。",
            meaning: "用来打趣对方局势不妙、装不下去了，或者自己心虚时的自嘲。",
            example: "听到老师说今天随机点名抽背，全班一瞬间汗流浃背了吧老弟。",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_baode",
            term: "包的 / 包赢的",
            category: .abstract,
            origin: "源自方言「包在我身上」的极致压缩版，在游戏和日常聊天中高频使用。",
            meaning: "绝对没问题、肯定行（通常说完之后大概率会立 Flag 翻车）。",
            example: "「这次上线不会出 Bug 吧？」「包的哥们，包的！」",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_shenjin",
            term: "神金",
            category: .abstract,
            origin: "「神经（病）」的谐音温和版本，常配合「你没事吧」表情包使用。",
            meaning: "用来吐槽极其抽象、离谱但又让人忍俊不禁的行为。",
            example: "半夜两点给我发一段三分钟的猫叫 Remix，神金啊笑死我了。",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_nanping",
            term: "这很难评，祝他成功",
            category: .abstract,
            origin: "源自网友面对槽点过多、无从下嘴事件时的礼貌性阴阳锐评。",
            meaning: "表面客观克制，实则已经无力吐槽，只能双手合十送上祝福。",
            example: "他决定用记事本手写一个大型 3D 引擎，这很难评，祝他成功吧。",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_kelidu",
            term: "对齐颗粒度",
            category: .workplace,
            origin: "互联网大厂高频职场黑话，被网友广泛用于讽刺过度包装的沟通。",
            meaning: "原本指把细节信息同步清楚，现常被用于一本正经地把简单小事说得很玄乎。",
            example: "中午点外卖前，我们先拉个短会对齐一下辣度和加葱的颗粒度。",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_yixihua",
            term: "听君一席话，如听一席话",
            category: .ruozhiba,
            origin: "经典废话文学代表句式，化用自「听君一席话，胜读十年书」。",
            meaning: "调侃对方洋洋洒洒说了一大堆，但信息量为零。",
            example: "专家建议：想不困就要多睡觉。听君一席话，如听一席话。",
            hotLevel: 5
        ),
        MemeLexiconEntry(
            id: "lex_yinancrawl",
            term: "扭曲 / 尖叫 / 阴暗爬行",
            category: .abstract,
            origin: "发疯文学代表意象，常写在括号内作为情绪舞台提示。",
            meaning: "用极具画面感的夸张动作，宣泄当代人的焦虑、崩溃或无语。",
            example: "听说周末还要调休（尖叫）（扭曲）（阴暗地爬行）（撞墙）。",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_chunlu",
            term: "纯路人 / 叠甲",
            category: .copypasta,
            origin: "源自饭圈、游戏圈及评论区对线文化。",
            meaning: "发表暴论前先声明自己中立无偏见（叠满防御甲），防止被集火。",
            example: "纯路人，不吹不黑，先叠个甲：甜豆腐脑和咸豆腐脑我都吃，但别加香菜。",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_zundu",
            term: "尊嘟假嘟",
            category: .abstract,
            origin: "源自可爱猫猫配音短视频对「真的假的」的谐音卖萌念法。",
            meaning: "表示震惊、怀疑或阴阳怪气的「真的假的？」。",
            example: "老板说明天全员提前两小时下班？尊嘟假嘟 o.O？",
            hotLevel: 3
        ),
        MemeLexiconEntry(
            id: "lex_nengneng",
            term: "那我问你",
            category: .interrogation,
            origin: "源自短视频博主高频反问句式，以极强节奏感引发全网模仿与二创。",
            meaning: "用于理直气壮地反客为主、连环质问，无论有理没理先占气势高地。",
            example: "那我问你，我的外卖显示已送达，但我手里连根筷子都没有，那我吃空气吗？",
            hotLevel: 4
        ),
        MemeLexiconEntry(
            id: "lex_dian",
            term: "典 / 孝 / 急 / 乐 / 绷 / 赢",
            category: .copypasta,
            origin: "贴吧与弹幕文化提炼出的高度浓缩六字评价体系。",
            meaning: "用单个汉字精准概括网络对线或抽象名场面中的经典套路与情绪状态。",
            example: "看到这波熟悉的操作，评论区整齐划一地刷起了：典、急、乐、绷！",
            hotLevel: 5
        )
    ]

    static let groupReactions: [String] = [
        "群主：？建议查查精神状态",
        "纯情哈基米：典中典，已转发相亲相爱一家人",
        "熬夜冠军：汗流浃背了吧老弟😅",
        "摸鱼大王：夯爆了！直接给到夯！",
        "路人甲：听君一席话，如听一席话🙏",
        "赛博牛马：已老实，求放过😭",
        "群友 B：撤回吧，我替你尴尬",
        "抽象鉴赏家：精神状态领先版本十年🔥"
    ]

    private static let homophoneMap: [(String, String)] = [
        ("真的", "尊嘟"),
        ("假的", "假嘟"),
        ("太酷了", "泰酷辣"),
        ("神经", "神金"),
        ("厉害", "夯爆了"),
        ("不错", "顶级"),
        ("不行", "拉完了"),
        ("确实", "包的"),
        ("肯定", "包的"),
        ("猫咪", "哈基米"),
        ("小猫", "哈基米"),
        ("无语", "大无语事件"),
        ("笑死", "笑拥了"),
        ("好笑", "草生")
    ]

    private static let dramaInterjections: [String] = [
        "（汗流浃背）",
        "（尖叫）",
        "（阴暗爬行）",
        "（双手合十）",
        "（战术喝水）",
        "（原地曼波）",
        "（瞳孔地震）"
    ]

    private static let abstractOpeners: [String] = [
        "【紧急播报】",
        "家人们先别滑走，",
        "咱就是说，",
        "不是哥们，"
    ]

    private static let abstractClosers: [String] = [
        " 懂的都懂，不懂的建议多刷两小时评论区。",
        " 精神状态遥遥领先，已列入非物质抽象遗产。",
        " 曼波~ 哇呜~ 今天的互联网就先冲到这了。",
        " 汗流浃背了吧老弟，这波直接给到夯！"
    ]

    private static let categoryHashtags: [MemeCategory: [String]] = [
        .hajimi: ["#哈基米", "#南北绿豆", "#曼波文学"],
        .abstract: ["#抽象艺术", "#精神状态良好", "#家人们谁懂啊"],
        .workplace: ["#赛博牛马", "#已老实求放过", "#对齐颗粒度"],
        .ruozhiba: ["#弱智吧哲学", "#废话文学", "#听君一席话"],
        .copypasta: ["#定型文圣经", "#从夯到拉", "#互联网考古"],
        .interrogation: ["#回答我", "#LookInMyEyes", "#那我问你"]
    ]

    private static let categoryEmojis: [MemeCategory: [String]] = [
        .hajimi: ["🐱", "🎵", "🫘", "✨", "⚡"],
        .abstract: ["😅", "🤡", "💀", "😭", "🙏"],
        .workplace: ["💼", "🐮", "🐴", "🫠", "☕️"],
        .ruozhiba: ["🧠", "🤔", "💡", "🌀", "🗿"],
        .copypasta: ["📜", "🔥", "👍", "🏅", "👀"],
        .interrogation: ["😤", "🫵", "💢", "🗣️", "‼️"]
    ]

    static func templates(for category: MemeCategory) -> [MemeTemplate] {
        templates.filter { $0.category == category }
    }

    static func defaultValues(for template: MemeTemplate) -> [String: String] {
        Dictionary(uniqueKeysWithValues: template.slots.map { ($0.id, $0.placeholder) })
    }

    static func randomizedValues(for template: MemeTemplate) -> [String: String] {
        Dictionary(uniqueKeysWithValues: template.slots.map { slot in
            let pick = slot.suggestions.randomElement() ?? slot.placeholder
            return (slot.id, pick)
        })
    }

    static func generate(
        template: MemeTemplate,
        slotValues: [String: String],
        extraSuffix: String = "",
        filters: AbstractFilterOptions,
        seed: Int = 0
    ) -> String {
        var result = template.pattern

        for slot in template.slots {
            let raw = slotValues[slot.id]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let value = raw.isEmpty ? slot.placeholder : raw
            result = result.replacingOccurrences(of: "{\(slot.id)}", with: value)
        }

        let trimmedExtra = extraSuffix.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedExtra.isEmpty {
            result += " \(trimmedExtra)"
        }

        if filters.homophoneTwist {
            for (original, replacement) in homophoneMap {
                result = result.replacingOccurrences(of: original, with: replacement)
            }
        }

        let clampedIntensity = min(max(filters.intensity, 0.0), 1.0)
        let stableSeed = abs(seed + template.id.hashValue)

        if clampedIntensity >= 0.55 {
            let opener = abstractOpeners[stableSeed % abstractOpeners.count]
            if !result.hasPrefix(opener) {
                result = opener + result
            }
        }

        if clampedIntensity >= 0.78 {
            let closer = abstractClosers[(stableSeed / 3) % abstractClosers.count]
            result += closer
        }

        if filters.parenthesesDrama {
            let count = clampedIntensity >= 0.7 ? 2 : 1
            let first = dramaInterjections[stableSeed % dramaInterjections.count]
            let second = dramaInterjections[(stableSeed + 2) % dramaInterjections.count]
            let dramaSuffix = count == 2 ? "\(first)\(second)" : first
            if let commaRange = result.range(of: "，") {
                result.insert(contentsOf: first, at: commaRange.upperBound)
                if count == 2 {
                    result += " \(second)"
                }
            } else {
                result += " \(dramaSuffix)"
            }
        }

        if filters.screamingPunctuation {
            result = result
                .replacingOccurrences(of: "。", with: "！！")
                .replacingOccurrences(of: "！", with: "！！！")
            if !result.hasSuffix("！") && !result.hasSuffix("!") {
                result += "！！！"
            }
        }

        if filters.injectEmojis {
            let pool = categoryEmojis[template.category] ?? ["😅", "🔥", "🤡"]
            let e1 = pool[stableSeed % pool.count]
            let e2 = pool[(stableSeed + 1) % pool.count]
            let e3 = pool[(stableSeed + 2) % pool.count]
            if clampedIntensity >= 0.65 {
                result = "\(e1) \(result) \(e2)\(e3)"
            } else {
                result = "\(result) \(e1)\(e2)"
            }
        }

        if filters.appendHashtags {
            let tags = categoryHashtags[template.category] ?? ["#抽象热梗", "#互联网文学"]
            result += "\n\n" + tags.joined(separator: " ")
        }

        return result
    }

    static func abstractScore(
        for text: String,
        template: MemeTemplate,
        filters: AbstractFilterOptions
    ) -> Int {
        var score = Double(template.baseAbstractScore) * 0.65
        score += filters.intensity * 26.0
        if filters.injectEmojis { score += 5 }
        if filters.homophoneTwist { score += 6 }
        if filters.parenthesesDrama { score += 7 }
        if filters.screamingPunctuation { score += 5 }
        if filters.appendHashtags { score += 3 }

        let buzzwordBonus = quickChips.reduce(0) { partial, chip in
            text.contains(chip) ? partial + 2 : partial
        }
        score += Double(min(buzzwordBonus, 14))

        return max(15, min(100, Int(score.rounded())))
    }

    static func rankInfo(for score: Int) -> MemeRankInfo {
        switch score {
        case ..<45:
            return MemeRankInfo(
                title: "现充路人",
                subtitle: "含梗量偏低，建议拉高抽象浓度",
                badgeEmoji: "🙂"
            )
        case 45..<68:
            return MemeRankInfo(
                title: "中级冲浪手",
                subtitle: "味道已经出来了，适合发朋友圈试水",
                badgeEmoji: "🏄"
            )
        case 68..<86:
            return MemeRankInfo(
                title: "抽象圣体",
                subtitle: "群友看完已经开始汗流浃背了",
                badgeEmoji: "🔥"
            )
        default:
            return MemeRankInfo(
                title: "互联网抽象大帝",
                subtitle: "精神状态遥遥领先，建议立刻申遗",
                badgeEmoji: "👑"
            )
        }
    }

    static func hashtags(for category: MemeCategory) -> [String] {
        categoryHashtags[category] ?? ["#抽象热梗"]
    }

    static func searchLexicon(query: String, category: MemeCategory?) -> [MemeLexiconEntry] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        return lexicon.filter { entry in
            let matchesCategory = category == nil || entry.category == category
            guard matchesCategory else { return false }
            if trimmed.isEmpty { return true }
            return entry.term.localizedCaseInsensitiveContains(trimmed)
                || entry.meaning.localizedCaseInsensitiveContains(trimmed)
                || entry.origin.localizedCaseInsensitiveContains(trimmed)
                || entry.example.localizedCaseInsensitiveContains(trimmed)
        }
    }
}
