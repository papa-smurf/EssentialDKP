if GetLocale() == "zhCN" then
  local _, core = ...;
  local MonDKP = core.MonDKP;
  
  core.BossList = {
    MC = {
      "鲁西弗隆", "玛格曼达", "基赫纳斯",
      "加尔", "迦顿男爵", "沙斯拉尔", "萨弗隆先驱者", 
      "焚化者古雷曼格", "管理者埃克索图斯", "拉格纳罗斯"
    },
    BWL = {
      "狂野的拉佐格尔", "堕落的瓦拉斯塔茲", "勒什雷尔",
      "费尔默", "埃博诺克", "弗莱格尔", "克洛玛古斯", 
      "奈法利安"
    },
    AQ = {
      "预言者斯克拉姆", "沙尔图拉", "顽强的范克瑞斯",
      "哈霍兰公主", "双子皇帝", "克苏恩", 
      "异种蝎皇族", "维希度斯", "奥罗"
    },
    NAXX = {
      "阿努布雷坎", "黑女巫法琳娜", "迈克斯纳",
      "瘟疫使者诺斯", "肮脏的希尔盖", "洛欧塞布", 
      "教官拉苏维奥斯", "收割者戈提克", "四骑士",
      "帕奇维克", "格罗布鲁斯", "格拉斯", "塔迪乌斯",
      "萨菲隆", "克尔苏加德"
    },
    ZG = {
      "血领主曼多基尔", "加兹兰卡", "噬魂者哈卡", "高阶祭司塞卡尔", "高阶祭司温诺希斯", "高级祭祀阿罗可可",
      "高阶祭司耶克里克", "妖术师金度", "高阶祭司玛尔里", "疯狂之缘"
    },
    AQ20 = {
      "『狩猎者』阿亚米斯", "『暴食者』布鲁", "拉贾克斯将军", "库林纳克斯", "莫阿姆", "『无疤者』奥斯里安"
    },
    ONYXIA = {"奥妮克希亚"},
    WORLD = {
      "艾索雷苟斯", "卡札克领主", "艾莫莉丝", "雷索", "伊索德雷", "泰拉尔"
    }
  }

  core.ZoneList = {
    "熔火之心", "黑翼巢穴", "安其拉神庙", "纳克萨玛斯", "祖尔古鲁布", "安其拉废墟", "奥妮克希亚的巢穴", "世界老板"
  }

  core.L = {
    Player                = "播放器",
    Class                 = "类",
    TotalDKP              = "DKP总计",
    EntriesShown          = "显示的条目",
    Filters               = "筛选器",
    AdjustDKP             = "调整DKP",
    ManageDKP             = "管理DKP列表",
    DefaultSettings       = "默认设置",
    LootHistory           = "战利品历史",
    DKPHistory            = "DKP历史",
    Manage                = "管理",
    Options               = "选件",
    AdjustDesc            = "从左侧选择单个玩家（按住Shift键并单击以选择多个玩家），或单击下面的“全选”，然后输入要调整的金额。\n\n范围可以通过下面的“仅显示突袭”或“过滤器”标签进行调整。",
    ReasonForAdjustment   = "调整原因",
    SelectReason          = "选择原因",
    OnTimeBonus           = "准时奖金",
    BossKillBonus         = "老板杀死奖金",
    RaidCompletionBonus   = "突袭完成奖金",
    NewBossKillBonus      = "新上司杀死奖金",
    CorrectingError       = "纠正错误",
    DKPAdjust             = "DKP调整",
    UnexcusedAbsence      = "无故缺席",
    Other                 = "其他",
    FirstKill             = "第一次杀",
    EnterOtherReasonHere  = "在此输入其他原因",
    Points                = "点数",
    WeeklyDKPDecay        = "每周DKP衰减",
    ApplyDecay            = "套用衰减",
    AppDecayTTDesc        = "您希望每周减少的DKP条目数量减少了DKP数量。这应该是一个正数。如果未在下面选择“仅选定的玩家”，它将应用于所有条目。",
    AppDecayTTWarn        = "警告：无法撤消。",
    AddNegValues          = "添加到负值",
    AddNegTTDesc          = "选中后，DKP值为负的任何玩家的债务都会减少上述百分比。所有其他百分比均降低了上述百分比。未经检查，负数的玩家不受衰减的影响。",
    AddNegTTWarn          = "此复选框仅影响负面DKP播放器的上述衰减行为。",
    SelPlayersOnly        = "仅限选定玩家",
    SelPlayersTTDesc      = "将上述DKP衰减应用于DKP表上的 |cffff0000只要|r 选定的播放器",
    SelPlayersTTWarn      = "对衰减超出阈值的玩家有用。",
    WeeklyDecayTTDesc     = "您希望每周减少的DKP条目数量减少了DKP数量。这应该是一个正数。如果未在下面选择“仅选定的玩家”，它将应用于所有条目。",
    WeeklyDecayTTWarn     = "警告：无法撤消。",
    WeeklyDecay           = "每周衰变",
    AdjustDKPTTDesc       = "将以上条目应用于DKP表中的所有选定播放器。",
    AdjustDKPTTWarn       = "此项将广播给您公会中的所有在线玩家。",
    PointsTTDesc          = "在DKP表上输入要分配给选定播放器的DKP数量。可以在下面的“选项”标签中更改默认值。",
    PointsTTWarn          = "使用负数从所选播放器中删除DKP。",
    Reason                = "原因",
    ReasonTTDesc          = "选择DKP调整的原因。如果选择“ 老板杀死奖金 ”或“ 新上司杀死奖金 ”，则会创建一个附加的下拉列表来选择区域和Boss。 “ 其他 ”将创建一个文本框供您输入自定义原因",
    ReasonTTWarn          = "当老板被杀死时，将自动为您选择合适的区域和老板",
    WARNING               = "警G",
    OutdateModifyWarn     = "您正在尝试修改过时的DKP表。这可能会无意间破坏了具有最新表的人员的数据。\n\n您确定要这样做吗",
    YES                   = "",
    NO                    = "没",
    OK                    = "",
    PlayerReasonValidate  = "未选择玩家或原",
    PlayerValidate        = "未选择玩",
    OtherReasonValidate   = "没有其他-选择原",
    RaidDKPAdjustBy       = "突袭DKP调整",
    DKPAdjustBy           = "DKP调整",
    ForReason             = "由于原",
    ForPlayers            = "对于以下玩",
    RaidTimerBonusConfirm = "您确定要对这次突袭应用“按时”奖金吗",
    RaidResume            = "突袭已恢复",
    RaidStart             = "突袭计时器已启动",
    RaidPause             = "突袭行动已于暂",
    PauseRaid             = "暂停突",
    PauseRaidTTDesc       = "如果领导者决定暂停计时器，则这会暂停突袭计时器",
    PauseRaidTTWarn       = "可以通过单击“ 继续突袭 ”恢复",
    IncrementInvalidWarn  = "增量是无效数字",
    Interval              = "间",
    AwardInterval         = "奖励间隔",
    AwardIntervalTTDesc   = "您希望将DKP授予整个团队的时间间隔（以分钟为单位）。",
    AwardIntervalTTWarn   = "例如。输入60会每小时每小时在“奖励”字段中奖励突击队（以及待命状态，如果需要，请在下面进行检查）。",
    AwardBonus            = "奖励奖金",
    AwardBonusTTDesc      = "每次满足以下间隔时，要给团队提供的DKP数量。",
    GiveOnTimeBonus       = "准时奖金",
    GiveOnTimeTTDesc      = "选择此选项将在您初始化团队时向团队中的每个人（和待机状态，如果在下面选择）都授予“按时”奖励。",
    GiveEndBonus          = "给予结束奖金",
    GiveEndBonusTTDesc    = "选择此选项将在您结束团队副本时向团队副本中的每个人（和待机状态，如果在下面选择）奖励“团队完成”奖励。",
    IncludeStandby        = "包括待机",
    IncludeStandbyTTDesc  = "选择此选项将在所有自动DKP分发中包括“待机”列表。",
    IncludeStandbyTTWarn  = "通过选择DKP表上不在团队中的播放器来创建备用列表，右键单击>管理备用列表>将选定的播放器添加到备用列表。",
    EndCurRaidConfirm     = "您确定要结束当前的袭击吗？",
    RaidTimerConclude     = "突袭计时器已结束",
    InitRaid              = "初始化突袭",
    InitRaidTTDesc        = "启动raid计时器，根据您在上面给出的时间增量来奖励DKP。可以由突袭中的任何人员进行初始化，但是只有突袭首领会在满足检查条件的情况下向DKP奖励。",
    InitRaidTTWarn        = "广播给所有突袭人员。每个军官都有一个计时器，但只有团队领导者才可以授予奖励。如果发生事件（脱机，重载等），导致队长失去计时器，则将突袭队长交给另一个仍在运行其计时器的军官，以防干扰。",
    TimerWarning          = "警告：请确保正确设置了DKP Bonus参数。可以在上面的“时间间隔”和“奖金”框中设置这些值，也可以在下面的“选项”选项卡中设置所有“默认DKP奖励值”。建议您设置这些值，并在使用前通过“ DKP模式”窗口（可通过“ / dkp模式”或“选项”选项卡中的按钮访问）广播给所有人员。",
    NotInRaid             = "您没有被袭击。",
    EntrySelected         = "所选条目",
    EntriesSelected       = "所选条目",
    AreYouSure            = "您确定要给吗",
    DKPToFollowing        = "DKP以下玩家",
    ConfirmDecay          = "您确定要衰败吗",
    DKPEntriesBy          = "DKP条目",
    RaidTimer             = "突袭计时器",
    TimeElapsed           = "时间流逝",
    BonusAwarded          = "获得奖金",
    ContinueRaid          = "继续突袭",
    TimeIntervalBonus     = "时间间隔奖励",
    RaidEnded             = "突袭结束",
    RaidPaused            = "突袭暂停",
    TotalDKPAward         = "DKP获奖总数",
    EndRaid               = "结束突袭",
    LootHistInst1         = "Shift+单击以链接项目\nAlt+单击以链接行",
    LootHistInst2         = "右键单击以编辑条目",
    LootHistInst3         = "右键单击以删除条目",
    OODLogSync            = "广播了过期的“战利品历史记录表”。这可能会对您的“战利品历史记录”表造成不可挽回的损害。你想接受吗？",
    OODDKPHistoryEntry    = "已广播过时的DKP历史记录表中的条目。这可能会对您的DKP历史记录表造成不可挽回的损害。你想接受吗？",
    OODDKPHistoryTable    = "已广播了过时的DKP历史记录表。这可能会对您的DKP历史记录表造成不可挽回的损害。你想接受吗？",
    OODLootHistoryDelete  = "已从过时的“战利品历史记录”表中删除了一项。这可能会导致删除表格中的错误项目。你想接受吗？",
    OODLootTableItem      = "试图从过期的“战利品表”中更新项目。这可能会对您的DKP表造成不可挽回的损害。你想接受吗？",
    OODDKPHistoryDelete   = "已尝试从过时的DKP历史记录表中删除项目。这可能会对您的DKP表造成不可挽回的损害。你想接受吗？",
    OODDKPTableBroadcast  = "广播了一个过时的DKP表。这可能会对您的DKP表造成不可挽回的损害。你想接受吗？",

    InPartyRaid           = "在派对/团队中",
    PositionReset         = "窗口位置重置",
    NotInGuild            = "不在公会",
    NoGuild               = "无公会",
    NoteTooLong           = "公会领导人的公开说明过长。注释截断以适合DKP表时间戳。 （最多31个字符）",
    InvalidTimer          = "无效的计时器",
    InvalidTargetPlayer   = "无法奖励物品。无效的目标玩家",
    InvalidItemCost       = "无法奖励物品。无效的商品费用",
    InvalidItemLink       = "无法奖励物品。无效的项目链接",
    ConfirmAward          = "您确定要授予",
    To                    = "至",
    For                   = "对于",
    DKP                   = "DKP",
    NoPermission          = "您无权访问该功能。",
    SlashCommandList      = "斜杠命令列表",
    DKPLaunch             = "启动DKP窗口",
    HelpInfo              = "显示帮助信息",
    DKPResetPos           = "重置DKP窗口位置/大小",
    DKPLockout            = "显示每个团队大小的下一次重置（3天，5天和7天锁定）",
    CreateRaidTimer       = "创建Raid计时器（仅限官员）（例如/ dkp计时器120 Pizza Break！）",
    OpenBidWindowHelp     = "打开出价窗口（仅限官员）（例如/ dkp出价[项目链接]）",
    PlayerCost            = "玩家费用[项目链接]",
    DKPAwardHelp          = "手动奖励项目（仅限官员）（例如/ dkp奖励roeshambo 100 [项目链接]）",
    DKPModesHelp          = "打开“ DKP模式”窗口（仅限官员）",
    DKPExportHelp         = "打开窗口，将所有DKP信息导出为HTML，CSV或XML。 （更多的导出实现方式将会出现）",
    WhisperCmdsHelp       = "耳语命令（致指定人员）",
    Value                 = "值",
    BidHelp               = "打开竞标时对当前项目的竞标。",
    PlayerName            = "选手姓名",
    DKPCmdHelp            = "返回当前的DKP（或<玩家名称>的DKP）",
    Version               = "版",
    CreatedMaintain       = "由...创建和维护",
    Loaded                = "已加载",
    PlayerRecords         = "球员记录",
    LootHistRecords       = "战利品历史记录和",
    DKPHistRecords        = "dkp历史记录",
    Use                   = "采用",
    SubmitBugs            = "寻求帮助并提交任何错误",
    Days                  = "天",
    Day                   = "天",
    Hours                 = "小时",
    Hour                  = "小时",
    Minutes               = "分钟",
    Minute                = "分钟",
    ResetsIn              = "重设",
    RecentHistoryFor      = "最近的历史",
    LifetimeEarned        = "终身获得",
    LifetimeSpent         = "花费的生命",
    NoPlayerInStandby     = "备用组中没有玩家。",
    NoPartyOrRaid         = "您没有参加聚会或突袭。",
    NoCoreRaidTeam        = "您的核心团队中没有玩家。",
    MultipleSelect        = "多项选择",
    InviteSelected        = "邀请参加突袭",
    SelectAll             = "全选",
    Views                 = "观看次数",
    TableViews            = "表格检视",
    ViewRaid              = "查看团队",
    ViewStandby           = "查看待机列表",
    ViewRaidStandby       = "查看突袭和待机",
    ViewCoreRaid          = "查看核心攻略",
    ViewAll               = "查看全部",
    ClassFilter           = "类过滤器",
    ManageLists           = "管理清单",
    ManageStandby         = "管理备用清单",
    AddToStandby          = "将选定的玩家添加到待机列表",
    RemoveFromStandby     = "从待机列表中删除选定的玩家",
    ClearStandby          = "清除备用清单",
    ManageCoreList        = "管理核心攻略列表",
    Invite                = "邀请",
    ToRaid                = "突袭",
    Remove                = "去掉",
    FromStandbyList       = "从待机列表",
    Add                   = "加",
    ToStandbyList         = "到待机列表",
    Close                 = "关",
    DKPStatus             = "DKP状态",
    AllTables             = "您所有的表格目前都在",
    UpToDate              = "最新",
    OutOfDate             = "过时的",
    OneTableOOD           = "您的一个或多个表当前",
    RequestTablesOfficer  = "向官员索要更新的表格。",
    CurrNotInGuild        = "您目前不在行会中。 DKP状态无法查询。",
    SelectBoss            = "选择老板",
    SelectAllVisible      = "选择所有可见",
    Selected              = "已选",
    All                   = "所有",
    Bonus                 = "奖金",
    RollNotAccepted       = "您的申请不被接受。你只有",
    OnlyOneRollWarn       = "只能接受一卷！",
    ErrorProcessing       = "错误处理命令",
    BidCancelled          = "您的出价已被取消。",
    NotSubmittedBid       = "您尚未提交投标。",
    InvalidPlayer         = "无效的播放器。 DKP表中未列出您。",
    YourBidOf             = "您的出价",
    DKPWasAccepted        = "DKP被接受",
    BidWasAccepted        = "您的出价已被接受。",
    BidDeniedMinBid       = "竞标被拒绝！低于最低出价",
    BidDeniedNegative     = "竞标被拒绝！您的DKP处于负面状态",
    BidDeniedOnlyHave     = "竞标被拒绝！你只有",
    BidDeniedNoValue      = "竞标被拒绝！没有给出出价的价值。",
    BidDeniedExceedMax    = "竞标被拒绝！您的出价超出了最高出价",
    BidDeniedInvalid      = "竞标被拒绝！收到无效的出价。",
    NoBidInProgress       = "尚无投标",
    CurrentlyHas          = "目前有",
    DKPAvailable          = "提供DKP",
    PlayerNotFound        = "找不到该玩家。",
    Use                   = "采用",
    ToBid                 = "投标",
    YouCurrentlyHave      = "您目前有",
    BidDeniedFilter       = "竞标被拒绝！",
    BidAcceptedFilter     = "您的出价已被接受。",
    OR                    = "要么",
    With                  = "与",
    TakingBidsOn          = "竞标",
    DKPMinBid             = "DKP最低竞标价格",
    ToBidUse              = "竞标使用",
    ToSend                = "发送",
    ToWithdrawBid         = "撤回出价。",
    RollFor               = "争取",
    ToBidRollRange        = "出价使用/ random。您的预期范围可以在DKP表上看到，也可以通过使用",
    NoMinBidOrItem        = "没有最低出价和/或要竞标的商品！",
    NoItemOrItemCost      = "没有项目费用和/或项目可以竞标！",
    EndBidding            = "结束竞标",
    StartBidding          = "开始竞标",
    InvalidBossName       = "老板名称无效",
    Error                 = "错误",
    AwardItemTo           = "奖励项目",
    On                    = "上",
    Congrats              = "恭喜",
    TenSecondsToBid       = "还剩10秒竞标！",
    BiddingClosed         = "招标截止！",
    RemoveEntry           = "删除条目",
    ClosedBidInProgress   = "投标窗口已关闭，正在进行投标！输入/ dkp bid以重新打开当前的出价会话。",
    Item                  = "项目",
    MinimumBid            = "最低竞标价格",
    MinBidTTDesc          = "可接受的最低出价。",
    MinBidTTWarn          = "可以在“选项”选项卡中设置默认值。",
    MinBidTTExt           = "如果输入的值不是“选项”中设置的值，则将为该特定项目存储该自定义值。",
    Custom                = "自订",
    CustomMinBid          = "自定义最低出价",
    CustomMinBidTTDesc    = "您已为此项目设置了自定义最低出价。取消选中此框可使用此项目类型的标准出价（在“选项”标签中设置）。",
    CustomMinBidTTWarn    = "在未选中此选项的情况下开始出价会从数据库中删除自定义的最低出价值。",
    BidTimer              = "出价计时器",
    BidTimerTTDesc        = "此项目的竞标时间将持续几秒钟。",
    BidTimerTTWarn        = "可以在“选项”选项卡中设置默认值。",
    Seconds               = "秒",
    StartBiddingTTDesc    = "开始为当前项目出价。仅在运行时接受投标。",
    StartBiddingTTWarn    = "竞标持续时间可以在“竞标计时器”框中设置。为项目启动第二次投标会话不会清除先前的投标（如果有人最后一秒截标，则可以使用）。",
    ClearBidWindow        = "清除视窗",
    ClearBidWindowTTDesc  = "从窗口清除所有项目信息和已提交的投标。",
    Bid                   = "出价",
    PlayerRoll            = "玩家名册",
    ExpectedRoll          = "预期滚动",
    ItemCost              = "物品成本",
    ItemCostTTDesc        = "DKP向玩家收取物品费用。",
    LootHistoryUpdateComp = "战利品历史记录更新已完成。",
    DKPHistoryUpdateComp  = "DKP历史记录更新已完成。",
    MinBidValuesReceived  = "收到的最低出价",
    ReloadUIForSettings   = "已更新DKP定义。您是否希望重新加载UI以反映这些更改？",
    DKPDataUpdatedBy      = "DKP数据库更新者",
    LootHistCastComp      = "战利品历史广播完成",
    DKPHistCastComp       = "DKP历史广播已完成",
    UnauthUpdate1         = "尝试广播修改过的表格。他不是您列入白名单的人员的一部分。",
    UnauthUpdate2         = "尝试广播修改过的表格。他不是您公会的指定官员。",
    DKPBroadcasted        = "广播的DKP数据库",
    BCastLootHist         = "广播战利品历史",
    BCastDKPHist          = "广播DKP历史记录",
    Load                  = "加载",
    More                  = "更多",
    ConfirmDeleteEntry1   = "您确定要删除该条目吗",
    DeleteEntryRefundConf = "受此条目影响的任何DKP都将从列出的每个播放器中退款/删除。",
    DeleteDKPEntry        = "删除DKP条目",
    MinBidDescription     = "通过“最小出价值”，为所有广告位（或单个项目）分配了一个最小值。\n\nEx：|cffa335ee|Hitem:16865::::::::120:577::::::|h[Breastplate of Might]|h|r下降，且最低出价为50 DKP。每个想要的玩家都通过一个打开的通道（在下面选择）发送“！bid 50”（或更高），而不超过其可用的DKP（除非激活了低于零的DKP）。出价最高的玩家将获胜，并被收取最低DKP值或第二高出价者提交的值。阅读工具提示以获取更多信息。",
    StaticDescription     = "使用静态项目值时，所有插槽（或单个项目）都分配有静态值。每个需要该项目的玩家（带有！bid）都将提交一个出价，并且具有最高可用DKP的玩家获胜。成本值选项为\"整数\"或\"百分 \"。\n\nEx：|cffa335ee|Hitem:19143::::::::120:577::::::|h[Flameguard Gauntlets]|h|r下降，静态值为50 DKP。每个想要的玩家都通过一个打开的通道（在下面选择）使用\"！bid \"。具有最高可用DKP的播放器获胜，并收取该静态值。阅读工具提示以获取更多信息。",
    RollDescription       = "使用基于滚动的出价，您可以使用多个参数选项。您可以在下面选择计划使用的卷筒类型。您设置的选项将不会成为接受或拒绝滚动的参数。而是会在出价窗口中显示预期的滚动值以供审核。您可以右键单击其滚动条，如果滚动条不符合正确的参数，则将其删除。",
    ZeroSumDescription    = "使用零和DKP，项目可以具有静态值，也可以被投标。当玩家赢得某物品的竞标价格或成本时，该DKP将从其中扣除，并在团队中平均分配。建议通过“ DKP取整”选项使用小数位，因为取整的整数可能会导致通货膨胀或DKP丢失。这样会比成本高出9点。\n\nEx：|cffa335ee|Hitem:18824::::::::120:577::::::|h[Magma Tempered Boots]|h|r掉落并的静态费用为30 DKP。玩家A通过拥有最多的DKP（或由平局领导酌情分配（如果平局）分配）来赢得竞标，并且其DKP减少30。然后每个突袭成员获得0.75 DKP。",
    MinBidValuesHead      = "最低竞标价格",
    StaticItemValuesHead  = "静态项目值",
    RollBiddingHead       = "基于卷的出价",
    ZeroSumHead           = "零和",
    DKPModes              = "DKP模式",
    DKPModesTTDesc        = "在出价窗口中选择要使用的DKP模式。选择时，模式说明将显示在上方。选择模式后重新加载。",
    Static                = "静态的",
    ZeroSumItemCost       = "零和项目成本",
    ZeroSumItemCostTTDesc = "选择您要使用的物料成本类型。静态为物料指定了成本。最低出价允许玩家在设置最低出价阈值时提交定义成本的出价。",
    BidMethod             = "竞价方式",
    DKPRounding           = "DKP舍入",
    DKPRoundingTTDesc     = "设置您希望在DKP系统中使用的小数位数。零将表示整数（无小数点）",
    OpenChannels          = "公开频道",
    Whisper               = "耳语",
    Raid                  = "袭击",
    Guild                 = "公会",
    CommandChannels       = "命令通道",
    CommandChannelsTTDesc = "选择要打开的通道，以接收！bid和！dkp命令。您可以选择三个的任意组合打开。无论通道是什么，所有收到的命令都会以低声回应。",
    FirstBidder           = "第一投标人",
    SecondBidder          = "第二投标人",
    CostAutoUpdate        = "费用自动更新",
    CostAutoUpdateTTDesc  = "选择您希望在投标过程中将物料成本自动更新为的价格。\n\n|CFFFF0000第一投标人|r：这会将投标窗口底部的物料成本更新为最高投标人。\n\n|CFFFF0000第二投标人|r：这会将投标窗口底部的项目成本更新为第二高的投标人，或者如果只有一个投标人，则将最低投标值更新。\n\n费用总是可以随时编辑。",
    CostAutoUpdateValue   = "费用自动更新值",
    ArtificialInflation   = "人工通胀",
    ArtInflatTTDesc       = "分配给每个玩家的DKP的TOP积分，在各个玩家之间分配。银行价值除后，此值将添加到他们的收入DKP中。",
    Inflation             = "通货膨胀",
    Integer               = "整数",
    Percent               = "百分",
    ItemCostTypes         = "物料成本类型",
    ItemCostTypesTTDesc   = "选择用于物料成本的值的类型（玩家为物料支付的价格）；整数或百分比。这些值在\"选件\"选项卡中设置。\n\n|CFFFF0000整数|r：项目成本为整数（小数点以下四舍五入为“ DKP舍入\"指示的小数位）。例如：100 DKP。\n\n|CFFFF0000百分|r：物品成本是获胜玩家总DKP的百分比。例如：玩家有1000 DKP，物品费用为20％。因此，该玩家的物品费用为200 DKP。",
    MaximumBid            = "最高出价",
    MaximumBidTTDesc      = "这是允许的最高出价。如果玩家试图出价高于此值，则其出价将被拒绝。如果您不希望有最大值，则设置为0。",
    SubZeroBidding        = "零以下出价",
    SubZeroBiddingTTDesc  = "如果玩家没有足够的DKP或出价高于可用的DKP（取决于模式设置），则允许其出价。\n\n|cffff0000最低出价值|r：允许玩家出价高于他们的dkp，最高\n\n|cffff0000其他|r：允许最高出价（设置如下）。\n\n|cffff0000其他|r：即使项目费用超出了其可用的DKP，也允许玩家提交出价。",
    Enabled               = "已启用",
    Disabled              = "残障人士",
    AllowNegativeBidders  = "允许负竞价者",
    AllowNegativeBidTTDesc= "如果玩家的DKP当前为负数，则允许其出价。",
    RollSettings          = "纸卷设置",
    MinimumRoll           = "最小滚动",
    MinimumRollTTDesc     = "设置要使用的最小卷纸。",
    Min                   = "敏",
    Max                   = "最高",
    MaximumRoll           = "最大滚动",
    MaximumRollTTDesc     = "设置要使用的最大卷数。保留空白可使用玩家最大DKP作为最大掷骰数。",
    MaximumRollTTWarn     = "如果未选中“使用百分比”，则最大DKP仅保留空白。如果选中，请使用100％。",
    UsePercForRolls       = "使用滚动百分比",
    UsePercRollsTTDesc    = "将上述掷骰范围转换为玩家DKP的百分比。 IE：拥有1000 dkp的玩家，且将以上设置为70％-100％将会使用\n/随机700-1000",
    UsePercRollsTTWarn    = "如果选中此选项，请仅使用0到100之间的数字。",
    AddToMaxRoll          = "添加到最大卷",
    AddToMaxRollTTDesc    = "将预定值添加到最大滚动。",
    AddToMaxRollTTWarn    = "例如：如果您希望玩家的最大掷骰数是他们的最大DKP + 500（上面设置了1-MaxDKP的范围），那么拥有80 DKP的玩家将期望/随机1-580。",
    InvalidRollRange      = "您设置了无效的滚动范围。请修改您的设置。",
    AreYouSureBroadcast   = "您确定要广播DKP模式设置吗？",
    DKPModeSentConf       = "已发送DKP模式设置",
    BroadcastSettings     = "广播设置",
    BroadcastSetTTDesc    = "广播所有与DKP相关的设置，包括上述DKP模式参数以及项目值和奖励值（在选项中设置）。",
    DKPModesFooter        = "如果对此窗口进行了任何更改，将重新加载您的UI | cffff0000MUST | r。如果重新加载未完成，您将收到错误消息。系统将提示您执行so when the window closes.",
    InvalidRollParam      = "您设置了无效的滚动参数。请修改您的设置。",
    ReloadUIConfirm       = "为了使这些设置生效，我们需要重新加载您的UI。您现在要这样做吗？",
    AlreadyAssigned       = "该项目已经分配给该玩家。",
    AreYouSureReassign    = "您确定要重新分配吗",
    ThisWillRefund        = "这将退还",
    AndChargeItTo         = "并充电到",
    Won                   = "韩元",
    ReassignSelected      = "重新分配给选定的球员",
    TooManyPlayersSelect  = "选择的玩家过多。",
    NoPlayersSelected     = "未选择任何玩家转移战利品。",
    WonBy                 = "赢了",
    In                    = "在",
    Off                   = "关",
    Load50More            = "加载50更多...",
    Added                 = "添加",
    Players               = "玩家",
    NotAnOfficer          = "不是官员。您只能在行会设置中添加具有“编辑主管注意”权限的等级。",
    WhiteListBroadcasted  = "白名单广播",
    AddRaidMembers        = "添加团队成员",
    AddRaidMembersTTDesc  = "将公会中的所有团队成员添加到DKP表中。",
    AddRaidMembersConfirm = "您确定要向DKP表添加缺少的RAID成员吗？",
    AddRemDKPTableEntries = "添加/删除DKP表条目",
    RemoveSelectedEntries = "删除所选条目",
    RemSelEntriesTTDesc   = "从DKP表中删除选定的播放器。该玩家的所有引用将保留（DKP历史记录和战利品历史记录），但其名称将显示为灰色。",
    RemSelEntriesTTWarn   = "警告：此操作是永久性的。",
    ConfirmRemoveSelect   = "您确定要删除吗",
    NoEntriesSelected     = "未选择任何条目。",
    ResetPrevDKP          = "重设上一个DKP",
    ResetPrevDKPTTDesc    = "将先前的DKP计数器重置为其当前DKP（每个播放器当前DKP旁边的灰色小+/-数字）。这不会以任何方式影响功能。只是自上次重置以来每个玩家的收入/花费的参考。",
    ResetPrevDKPTTWarn    = "建议定期重设（每周，每月等）。这是QOL功能，不会影响功能。",
    ResetPrevConfirm      = "您确定要重置以前的DKP吗？",
    RankList              = "排名表",
    RankListTTDesc        = "选择一个等级，然后单击\"添加公会成员\"以将所选等级的所有公会成员添加到DKP表中。",
    SelectRank            = "选择等级",
    AddGuildDKPTable      = "将公会添加到DKP表",
    AddGuildDKPTableTT    = "添加所选等级的所有公会成员，但这些公会成员尚未包含在DKP表中。",
    AddGuildConfirm       = "您确定要添加所有行列成员吗？",
    OrAbove               = "或以上？",
    NoRankSelected        = "未选择等级。",
    AddTargetToDKPTable   = "将目标添加到DKP表",
    AddTargetTTDesc       = "将您当前的目标（如果有玩家）添加到DKP表中。与所有其他选项不同，这不需要将目标包含在行会中。",
    ConfirmAddTarget      = "您确定要添加吗",
    ToDKPList             = "到DKP列表？",
    NoPlayerTargeted      = "没有玩家目标。",
    WhiteListHeader       = "白名单设置|CFF444444（仅领导人）（A)|r\n\n强烈建议您仅在希望限制哪些警官需要权限的情况下才使用此白名单设置。如果您希望所有人员都具有权限，请完全忽略此设置功能。请谨慎使用。 （如果应用这些设置会导致问题，请使用文本编辑器打开\\WTF\\Accounts\\ACCOUNT_NAME\\SavedVariables\\MonolithDKP.lua文件，然后删除底部附近的MonDKP_Whitelist表。）",
    SetWhitelist          = "Set Whitelist",
    SetWhitelistTTDesc1   = "将DKP表中的选定人员添加到白名单中。白名单用于|cffff0000限制|r有权修改DKP值的人员。",
    SetWhitelistTTDesc2   = "在未选择任何玩家的情况下使用此选项将清除您的白名单。",
    SetWhitelistTTWarn    = "只有军官才能被列入白名单。此选项专门用于限制在此插件中哪些军官具有军官权限。如果您希望所有官员都获得许可，请将白名单留空。",
    ConfirmWhitelist      = "您确定要将选定的球员添加到白名单中吗？",
    ConfirmWhitelistClear = "您确定要清除白名单吗？",
    ViewWhitelistBtn      = "查看白名单",
    ViewWhitelistTTDesc   = "在您的DKP列表中选择所有列入白名单的人员。",
    WhitelistEmpty        = "您的白名单是空的。",
    SendWhitelist         = "发送白名单",
    SendWhitelistTTDesc   = "向所有人员广播您的白名单。",
    SendWhitelistTTWarn   = "建议您在所有人员都在线时执行此操作。如果某位官员没有收到此白名单，则他们将具有全部官员权限。但是，他们将无法将其信息广播给其他人员。如果他们尝试，您将收到通知。如果您收到该通知，则发送白名单及其权限将被删除。",
    BroadcastDKPTableConf = "您确定要广播DKP表吗？",
    BcastLootTableConf    = "您确定要广播“战利品历史记录”表吗？",
    LootHistUpdateProg    = "战利品历史记录更新中",
    DKPHistUPdateProg     = "DKP历史记录更新正在进行中",
    BcastDKPHistConf      = "您确定要广播DKP历史记录表吗？",
    BroadcastHeader       = "如果DKP历史记录或战利品历史记录表大于100个条目，由于暴雪实施了防洪措施，将需要一些时间来广播它们。 2500个条目最多可能需要3-5分钟。广播之间请间隔1-2秒，以允许同时更新。 “广播DKP表”应该相对即时。所有广播都是GUILD范围的（出价/突击计时器例外，仅限RAID）。",
    BCastDKPTableBtn      = "广播DKP表",
    BcastLootHistBtn      = "广播战利品历史",
    BcastDKPHistBtn       = "广播DKP历史记录",
    DefaultDKPAwardValues = "默认DKP奖励值",
    DKPModesTTDesc2       = "配置将使用的DKP系统类型。每种模式下的高度可变性。",
    DKPModesTTWarn        = "如果更改任何设置，则必须重新加载您的界面。关闭时，系统会提示您这样做。否则会导致错误。",
    OnTimeBonusTTDesc     = "奖金，因为准时出席。",
    BossKillBonusTTDesc   = "杀死老板可获得的奖金。",
    RaidCompleteBonusTT   = "奖励给参加完工团队的每个人。",
    NewBossKillTTDesc     = "升级突袭期间首次上司杀死的奖励。",
    UnexcusedTTDesc       = "对突袭无故缺席的处罚。",
    UnexcusedTTWarn       = "应为负数。",
    DecayPercentage       = "衰减百分比",
    DecayPercentageTTDesc = "减少所有DKP值以进行常规衰减的百分比。",
    DecayPercentageTTWarn = "不是负数。",
    DecayAmount           = "衰减量",
    DefaultMinBidValues   = "默认最低出价",
    DefaultItemCosts      = "默认物料成本",
    DKPPrice              = "DKP价格",
    PercentCost           = "成本百分比",
    Head                  = "头",
    Neck                  = "颈部",
    Shoulders             = "护肩",
    Cloak                 = "披风",
    Chest                 = "胸部",
    Bracers               = "护腕",
    Hands                 = "手",
    Belt                  = "带",
    Legs                  = "腿部",
    Boots                 = "靴子",
    Rings                 = "戒指",
    Trinket               = "饰品",
    Range                 = "范围",
    Other                 = "其他",
    OneHanded             = "一只手",
    OneHandedWeapons      = "单手武器",
    TwoHanded             = "双手的",
    TwoHandedWeapons      = "双手武器",
    OffHand               = "副手",
    OffHandItems          = "副手物品",
    ForHeadSlot           = "用于头部插槽项目。",
    ForNeckSlot           = "用于颈项。",
    ForShoulderSlot       = "用于肩槽物品。",
    ForBackSlot           = "用于后插槽项目。",
    ForChestSlot          = "用于胸口物品。",
    ForWristSlot          = "用于腕槽物品。",
    ForHandSlot           = "用于手动插槽项目。",
    ForWaistSlot          = "用于腰围物品。",
    ForLegSlot            = "用于腿槽物品。",
    ForFeetSlot           = "用于脚槽物品。",
    ForFingerSlot         = "用于手指插槽项目。",
    ForTrinketSlot        = "用于饰品插槽项目。",
    ForOneHandSlot        = "单手武器。",
    ForTwoHandSlot        = "双手武器。",
    ForOffHandSlot        = "用于副手物品（盾牌，施法者副手）。",
    ForRangeSlot          = "用于范围插槽物品（弓，枪，魔杖，遗物）。",
    ForOtherSlot          = "对于不属于上述类别的所有其他物品（头部，心脏，猎人之叶等）",
    MinBidValuesSent      = "最低出价已发送",
    BcastMinBidConfirm    = "您确定要向所有人员广播最低出价设置吗？",
    BcastValues           = "广播值",
    BcastValuesTTDesc     = "将高于最低出价的价格广播给所有人员。这还将在出价窗口中广播为特定项目设置的所有自定义值。",
    BcastValuesTTWarn     = "当前值不会被覆盖。接收此广播将更新已设置的值或添加不存在的值。他们可能具有的任何未发送的值将保持不变。",
    BidTimerDefaultTTDesc = "出价计时器的默认时间（以秒为单位）。",
    TTHistoryCount        = "工具提示历史记录计数",
    TTHistoryCountTTDesc  = "工具提示中列出的战利品/ dkp历史记录条目数。",
    LootHistoryLimit      = "战利品历史限制",
    LootHistLimitTTDesc   = "存储的最大战利品历史记录条目。",
    LootHistLimitTTWarn   = "警告：如果将其减少到当前存储的条目数以下，则最早的将被删除以达到限制。",
    DKPHistoryLimit       = "DKP历史记录限制",
    DKPHistLimitTTDesc    = "存储的最大DKP历史记录条目。",
    DKPHistLimitTTWarn    = "警告：如果将其减少到当前存储的条目数以下，则最早的将被删除以达到限制。",
    TimerSize             = "计时器大小",
    TimerSizeTTDesc       = "投标/突击计时器的规模。",
    TimerSizeTTWarn       = "可以通过单击\"Move Bid Timer\"并将其拖动到所需位置来调整位置。",
    MonDKPScaleSize       = "整体式DKP秤尺寸",
    MonDKPScaleSizeTTDesc = "Monolith DKP窗口的比例。单击\"保存设置\"以将大小更改为设置值。",
    MonDKPScaleSizeTTWarn = "如果使用另一个修改UI比例的插件（例如TukUI，ElvUI等），则保存后可能需要/ reload。",
    MainGUISize           = "主GUI大小",
    SuppressNotifications = "Supress插件通知",
    SuppressNotifyTTDesc  = "隐藏所有附加消息，使其不会显示在聊天框中。",
    SuppressNotifyTTWarn  = "广播更新仍将被接收。",
    NotificationsLikeThis = "这样的通知现在",
    Hidden                = "隐",
    Visible               = "可见",
    SuppressBidWhisp      = "Supress竞价耳语",
    SupressBidWhispTTDesc = "在进行投标时，抑制与投标有关的传入和传出耳语。",
    SupressBidWhispTTWarn = "所有其他与非出价相关的耳语仍将显示。",
    BidWhispAreNow        = "竞价耳语现在",
    InvalidMinBidEntry    = "的最低出价无效",
    InvalidOptionEntry    = "在无效的选项输入",
    PleaseUseNums         = "请使用数字。",
    DefaultSetSaved       = "默认设置已保存。",
    MoveBidTimer          = "移动出价计时器",
    MoveMe                = "感动我！",
    HideBidTimer          = "隐藏出价计时器",
    Among                 = "其中",
    PlayersForReason      = "玩家原因",
    NotInRaidParty        = "您没有参加团队聚会。",
    ZeroSumBank           = "零和银行",
    Boss                  = "老板",
    ZeroSumBalance        = "零和余额",
    ZeroSumBalanceTTDesc  = "购买战利品后，自动累积所有由突击队花费的DKP，以进行分发。",
    Balance               = "平衡",
    DistributeDKP         = "分发DKP",
    DistributeAllDKPConf  = "将DKP分发给团队中的所有玩家？",
    NoPointsToDistribute  = "没有要分发的点。",
    DistrubuteBanked      = "在当前老板的抢劫完成后，将银行化DKP平均分配给所有团队成员。",
    IncludeStandbyList    = "包括备用清单",
    IncStandbyListTTDesc  = "在分发中的待机列表中包括播放器。",
    IncStandbyListTTWarn  = "这将给团队中的玩家带来较小的价值。",
    LootBanked            = "战利品银行",
    AllClasses            = "所有课程",
    RemoveEntries         = "删除条目",
    ResetPrevious         = "重设上一个",
    AddGuildMembers       = "添加公会成员",
    AddTarget             = "添加目标",
    NotInRaidFilter       = "不突袭",
    Online                = "线上",
    OnlyPartyRaid         = "只有派對或突襲",
    ManuallyDenied        = "已被拒絕。",
  }
end