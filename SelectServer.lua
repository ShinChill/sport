-------------------------------------------------------------------------------------------------------------
--
-- 全局变量
--
local g_LastServer = -1;
local g_LastArea   = -1;
local g_LastServerState = -1;
local g_LastServerName = "";
local g_LastServerPrizeLevel = 0;--上次登录�?i的获奖级别added by lichengjie
local CriticalSpeed1 =250
local CriticalSpeed2 =500
local CriticalSpeed3 =1000

local CriticalSpeed =200;
local CurPage = 0
local NetSpeed ={"#e010101T痗 鸬: #c4CFA4CT痶","#e010101T痗 鸬: #c4CFA4CB r祅","#e010101T痗 鸬: Ch遖 bi猼", "#e010101T痗 鸬 m課g: #cff0000T ngh╪" }
local PageSize = 24

-- 区域按钮的个数
local LOGIN_SERVER_AREA_COUNT = 20;
--目前有效的区域按钮个数，由于界面改动太大，怕以后有人又反悔，加这个变量，主要是不想去掉翻页代码。
local EFFECT_LOGIN_SERVER_AREA_COUNT = 20;
-- C鬾g tr区域按钮的个数
local LOGIN_SERVER_TESTAREA_COUNT = 20;
-- 区域按钮
local g_BnArea = {};

-- C鬾g tr区域按钮
local g_BntestArea = {};

-- 当前选择的区域
local g_iCurSelArea = 0;
-- login server 客户端索引
local g_AreaIndex ={};
-- login server 名字
local g_AreaName = {};
-- login server 名字
local g_AreaDis = {};
-- testlogin server 客户端索引
local g_testAreaIndex ={};
-- login server 名字
local g_testAreaName = {};
-- login server 名字
local g_testAreaDis = {};
-- 当前选择的区域名字
local g_iCurSelAreaName;
-- 当前选择的�?i名字
local g_iCurSelLoginServerName;

--区域tips
local g_AreaTip = {};
local g_testAreaTip = {};

-- 选择的网络接入商

--记载默认网络接入商。
local default_iNetProvide	=	1;

local g_idBackSound = -1;

-- 选择代理	tongxi ,注释掉
--local g_UseProxy = 0;
-- 记载推荐�?i的个数
local indexForCommendable = 1;
------------------------------------------------------------------------------
--
-- login server 信息
--

-- login server 的个数
--local LOGIN_SERVER_COUNT = 55;    -- modify by zchw 45-->55
local LOGIN_SERVER_COUNT = 85;    -- modify by zchw 45-->55

local COMMENDABLE_LOGIN_SERVER_COUNT = 12;

-- login server 按钮
local g_BnLoginServer = {};
local g_BnLoginServerAnimate = {};--�?i动画按钮 added by lichengjie
-- login server 状态
local g_LoginServerStatus = {};
-- login server 名字
local g_LoginServerName = {};
-- login server 推荐等级
local g_LoginServerCommendableLevel = {};
-- login server 是否新开
local g_LoginServerIsNew = {};
--added by lichengjie --�?i奖励等级 0 1 2 3
--0 代表Kh鬾g奖励；1代表一等奖；2代表2等级 3代表三等奖，其他数值被处理为0
local g_LoginServerPrizeLevel = {}


local g_ThreePrizeTip =--获奖提示
{
	"#{WJZH_100910_20}",--这个地方将字典WJZH_100910_19改为新的WJZH_100910_20
	"#{WJZH_100910_18}",
	"#{WJZH_100910_17}",
	"#{CLCZ_101207_03}",
	"#{CLCZ_101207_02}",
	"#{CLCZ_101207_01}",
	"#{KFZB_110628_205}", --全国争霸赛总决赛第一名所在�?i！全服授予1.2倍经验奖励，持续2周。7
	"#{KFZB_110628_206}", --全国争霸赛总决赛第二名所在�?i！全服授予1.2倍经验奖励，持续1周。8
	"#{KFZB_110628_207}", --全国争霸赛总决赛第三名所在�?i！全服授予1.2倍经验奖励，持续1周。9
	"#{KFZB_110628_208}", --全国争霸赛大区赛前三名所在�?i！全服授予1.1倍经验奖励，持续1周。10
	"#{KFZB_110628_251}", --全国争霸赛总决赛32强所在�?i！全服授予1.2倍经验奖励，持续3天。。11
}
local g_ThreePrizeAnimate=--获奖动画特效资源
{
	"Server_3",
	"Server_2",
	"Server_1",
	"Server_3",
	"Server_2",
	"Server_1",
	"Server_3", --7
	"Server_2", --8中间两种情况特效应该一致才对
	"Server_2", --9
	"Server_1", --10
	"Server_1", --11
}
local g_ThreeCommendablePrizeAnimate = --推荐�?i列表特效资源
{
	"Subarea_3",
	"Subarea_2",
	"Subarea_1",
	"Subarea_3",
	"Subarea_2",
	"Subarea_1",
	"Subarea_3", --7
	"Subarea_2", --8
	"Subarea_2", --9
	"Subarea_1", --10
	"Subarea_1", --11
}
local g_LastServerPrizeAnimate = --上次登录�?i特效资源
{
	"Server_Last_3",
	"Server_Last_2",
	"Server_Last_1",
	"Server_Last_3",
	"Server_Last_2",
	"Server_Last_1",
	"Server_Last_3", --7
	"Server_Last_2", --8
	"Server_Last_2", --9
	"Server_Last_1", --10
	"Server_Last_1", --11
}
--end lichengjie

-- 推荐�?i按钮
local g_CommendableBnLoginServer = {};
-- 推荐�?i名字
local g_CommendableLoginServerName = {};
-- 推荐�?iIndex
local g_CommendableLoginServerServerIndex = {};
-- 推荐�?i区域Index
local g_CommendableLoginServerAreaIndex = {};
-- 推荐�?i推荐等级
local g_CommendableLoginServerCommendableLevel = {};
-- 推荐�?i是否新服
local g_CommendableLoginServerIsNew = {};
-- 推荐�?i 状态
local g_CommendableLoginServerStatus = {};
-- added by lichengjie 推荐�?i特效按钮数组
local g_CommendableBnLoginServerAnimate = {};
-- added by lichengjie 推荐�?i 获奖情况数组
local g_CommendableLoginServerPrizeLevel = {};

local g_SelectServer_Str = {
														"#{DLJM_XML_46}",   --电信
														"#{DLJM_XML_48}",   --M課g internet
														"#{DLJM_XML_50}",   --教育网
														"#{DDFWQ_XML_01}",  --Li阯 th鬾g 2 (Th鬾g m課g)
														"#{DLJM_XML_47}",   --Vi璶 th鬾g#G(ti猲 c�)
														"#{DLJM_XML_49}",   --Li阯 th鬾g (M課g l呔i th鬾g tin)1#G(ti猲 c�)
														"#{DLJM_XML_51}",   --M課g gi醥 d鴆#G(ti猲 c�)
														"#{DDFWQ_XML_03}",  --Li阯 th鬾g 2 (Th鬾g m課g)#G(Ti猲)
														"#{DLJM_XML_36}",	--T鄆 kH鯽n 衖畁 T韓 xin nh t鵼 ch鱪 n鄖 瓞 c� th� ch絠 game su鬾 s� h絥
														"#{DLJM_XML_37}",	--T鄆 kH鯽n V鮪g Th鬾g xin nh t鵼 ch鱪 n鄖 瓞 c� th� ch絠 game su鬾 s�
														"#{DLJM_XML_38}",	--T鄆 kH鯽n Gi醥 D鴆 V鮪g xin nh t鵼 ch鱪 n鄖 瓞 c� th� ch絠 game su鬾 s� h絥
														"#{DDFWQ_XML_02}",  --li阯 th鬾g t鄆 kho鋘 (Th鬾g m課g), n猽 sever m鴆 ti陁 k猼 n痠 c鹡g l� sever li阯 th鬾g (Th鬾g m課g) th� n阯 d鵱g ph呓ng th裞 li阯 ti猵.
														"#{DLJM_XML_52}",   --H� th痭g ph醫 hi畁 疬㧟 c醕 h� c� th� l� ng叨i s� d鴑g 餴畁 t韓, ti猲 c� c醕 h� s� d鴑g 餴畁 t韓 server 鹫i l� 瓞 tr鋓 nghi甿 game 疬㧟 t痶 h絥.
														"#{DLJM_XML_53}",   --H� th痭g ph醫 hi畁 疬㧟 c醕 h� c� th� l� ng叨i s� d鴑g li阯 th鬾g (m課g l呔i th鬾g tin), ti猲 c� c醕 h� s� d鴑g li阯 th鬾g (m課g l呔i th鬾g tin) server 鹫i l� 瓞 tr鋓 nghi甿 game 疬㧟 t痶 h絥.
														"#{DLJM_XML_54}",   --H� th痭g ph醫 hi畁 疬㧟 c醕 h� c� th� l� ng叨i s� d鴑g m課g gi醥 d鴆, ti猲 c� c醕 h� d鵱g m課g gi醥 d鴆 server 鹫i l� 瓞 tr鋓 nghi甿 game 疬㧟 t痶 h絥.
														"#{DLJM_XML_53}",   --H� th痭g ph醫 hi畁 疬㧟 c醕 h� c� th� l� ng叨i s� d鴑g li阯 th鬾g (m課g l呔i th鬾g tin), ti猲 c� c醕 h� s� d鴑g li阯 th鬾g (m課g l呔i th鬾g tin) server 鹫i l� 瓞 tr鋓 nghi甿 game 疬㧟 t痶 h絥.

														}
-------------------------------------------------------------------------------
--
-- 其他信息
--

-- 当前选择的login server
local g_iCurSelLoginServer = -1;
-- 当前选择的推荐login server index
local g_iCurComSelLoginServer = -1;

-- 区域的个数
local g_iCurAreaCount = 0;
--C鬾g tr区域个数
local g_iCurTestAreaCount = 0;

local g_FirstLogin = 1;

--�?i处于维护状态
local StateStop = 4;
--不显示状态
local StatMax = 10;

local RECOMMEND_AREA_COUNT = 5;
--记载电信推荐大区数量
local indexForRecommendArea = 0;
--推荐电信大区按钮
local g_RecommendAreaBtn = {};
--推荐电信大区名字
local g_RecommendAreaName = {};
--推荐电信大区推荐等级
local g_RecommendAreaRecommendLevel = {};

local RECOMMENDCNC_AREA_COUNT = 5;
--记载M課g internet推荐大区数量
local indexForRecommendCNCArea = 0;
--推荐M課g internet大区按钮
local g_RecommendCNCAreaBtn = {};
--推荐M課g internet大区名字
local g_RecommendCNCAreaName = {};
--推荐M課g internet大区推荐等级
local g_RecommendCNCAreaRecommendLevel = {};


-- 搜索列表�?iIndex
local g_SearchServerIndex = {};
-- 搜索列表�?i大区Index
local g_SearchServerAreaIndex = {};
-- 搜索列表�?i名称
local g_SearchServerName = {};
-- 搜索列表�?i是否新服
local g_SearchServerIsNew = {};
-- 搜索列表�?i状态
local g_SearchServerStatus = {};
-- 是否显示搜索页面
local g_bSearch = 0;
local g_SearchServerPrizeLevel = {};--搜索的�?i获奖等级 added by lichengjie
local g_SearchServerAnimate = {};--搜索的�?i获奖特效 added by lichengjie

-- 客户端和�?i都在M課g internet内时，随即推荐其中一个(0为M課g internet青岛代理，1为默认)
local Sel_TuiJian = 0;

local g_iNetProvide = -1;		-- 0 : 电信
								-- 1 : M課g internet
								-- 2 : 其他
								-- 3：默认
								-- 4：M課g internet青岛

local g_AllNetProvide = {0,1,4,2,3}
-------------------------------------------------------------------------------------------------------------
--
-- 函数区.
--
--

-- 注册onLoad事件
function LoginSelectServer_PreLoad()
	-- 打开选择�?i界面
	this:RegisterEvent("GAMELOGIN_OPEN_SELECT_SERVER");

	-- 选择区域
	this:RegisterEvent("GAMELOGIN_CLOSE_SELECT_SERVER");

	-- 打开选择�?i界面
	this:RegisterEvent("GAMELOGIN_SELECT_AREA");

	-- 选择login
	this:RegisterEvent("GAMELOGIN_SELECT_LOGINSERVER");

	-- 选择是否使用代理
	this:RegisterEvent("GAMELOGIN_SELECT_USEPROXY");

	-- 注册选择一个login server事件
	this:RegisterEvent("GAMELOGIN_SELECT_LOGIN_SERVER");

	-- 玩家进入场景
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--ping结果
	this:RegisterEvent("PING_RESAULT");
	--上次登录的�?i
	this:RegisterEvent("GAMELOGIN_LASTSELECT_AREA_AND_SERVER");

	--进入账号输入界面
	this:RegisterEvent("GAMELOGIN_SERVER_SHOW_COUNTINPUT");

	--返回�?i选择Sub1
	this:RegisterEvent("GAMELOGIN_SERVER_SHOW_SUB");

	--更新�?i列表信息
	this:RegisterEvent("GAMELOGIN_UPDATE_SERVERINFO");

end

function LoginSelectServer_OnLoad()

	-- 得到区域按钮
	g_BnArea[1] = SelectServer_Subarea1;
	g_BnArea[2] = SelectServer_Subarea2;
	g_BnArea[3] = SelectServer_Subarea3;
	g_BnArea[4] = SelectServer_Subarea4;
	g_BnArea[5] = SelectServer_Subarea5;
	g_BnArea[6] = SelectServer_Subarea6;
	g_BnArea[7] = SelectServer_Subarea7;
	g_BnArea[8] = SelectServer_Subarea8;
	g_BnArea[9] = SelectServer_Subarea9;
	g_BnArea[10] = SelectServer_Subarea10;
	g_BnArea[11] = SelectServer_Subarea11;
	g_BnArea[12] = SelectServer_Subarea12;

	g_BnArea[13] = SelectServer_Subarea13;
	g_BnArea[14] = SelectServer_Subarea14;
	g_BnArea[15] = SelectServer_Subarea15;
	g_BnArea[16] = SelectServer_Subarea16;
	g_BnArea[17] = SelectServer_Subarea17;
	g_BnArea[18] = SelectServer_Subarea18;
	g_BnArea[19] = SelectServer_Subarea19;
	g_BnArea[20] = SelectServer_Subarea20;

	g_BntestArea[1] = SelectServer2_Subarea1;
	g_BntestArea[2] = SelectServer2_Subarea2;
	g_BntestArea[3] = SelectServer2_Subarea3;
	g_BntestArea[4] = SelectServer2_Subarea4;
	g_BntestArea[5] = SelectServer2_Subarea5;
	g_BntestArea[6] = SelectServer2_Subarea6;
	g_BntestArea[7] = SelectServer2_Subarea7;
	g_BntestArea[8] = SelectServer2_Subarea8;
	g_BntestArea[9] = SelectServer2_Subarea9;
	g_BntestArea[10] = SelectServer2_Subarea10;
	g_BntestArea[11] = SelectServer2_Subarea11;
	g_BntestArea[12] = SelectServer2_Subarea12;
	g_BntestArea[13] = SelectServer2_Subarea13;
	g_BntestArea[14] = SelectServer2_Subarea14;
	g_BntestArea[15] = SelectServer2_Subarea15;
	g_BntestArea[16] = SelectServer2_Subarea16;
	g_BntestArea[17] = SelectServer2_Subarea17;
	g_BntestArea[18] = SelectServer2_Subarea18;
	g_BntestArea[19] = SelectServer2_Subarea19;
	g_BntestArea[20] = SelectServer2_Subarea20;

	--得到推荐�?i列表
	g_CommendableBnLoginServer[1] = SelectServer_Commendable_Subarea1;
	g_CommendableBnLoginServer[2] = SelectServer_Commendable_Subarea2;
	g_CommendableBnLoginServer[3] = SelectServer_Commendable_Subarea3;
	g_CommendableBnLoginServer[4] = SelectServer_Commendable_Subarea4;
	g_CommendableBnLoginServer[5] = SelectServer_Commendable_Subarea5;
	g_CommendableBnLoginServer[6] = SelectServer_Commendable_Subarea6;
	g_CommendableBnLoginServer[7] = SelectServer_Commendable_Subarea7;
	g_CommendableBnLoginServer[8] = SelectServer_Commendable_Subarea8;
	g_CommendableBnLoginServer[9] = SelectServer_Commendable_Subarea9;
	g_CommendableBnLoginServer[10] = SelectServer_Commendable_Subarea10;
	g_CommendableBnLoginServer[11] = SelectServer_Commendable_Subarea11;
	g_CommendableBnLoginServer[12] = SelectServer_Commendable_Subarea12;

	--得到推荐�?i特效按钮列表 added by lichengjie
	g_CommendableBnLoginServerAnimate[1] = SelectServer_Commendable_Subarea1_Animate;
	g_CommendableBnLoginServerAnimate[2] = SelectServer_Commendable_Subarea2_Animate;
	g_CommendableBnLoginServerAnimate[3] = SelectServer_Commendable_Subarea3_Animate;
	g_CommendableBnLoginServerAnimate[4] = SelectServer_Commendable_Subarea4_Animate;
	g_CommendableBnLoginServerAnimate[5] = SelectServer_Commendable_Subarea5_Animate;
	g_CommendableBnLoginServerAnimate[6] = SelectServer_Commendable_Subarea6_Animate;
	g_CommendableBnLoginServerAnimate[7] = SelectServer_Commendable_Subarea7_Animate;
	g_CommendableBnLoginServerAnimate[8] = SelectServer_Commendable_Subarea8_Animate;
	g_CommendableBnLoginServerAnimate[9] = SelectServer_Commendable_Subarea9_Animate;
	g_CommendableBnLoginServerAnimate[10] = SelectServer_Commendable_Subarea10_Animate;
	g_CommendableBnLoginServerAnimate[11] = SelectServer_Commendable_Subarea11_Animate;
	g_CommendableBnLoginServerAnimate[12] = SelectServer_Commendable_Subarea12_Animate;
	--得到推荐�?i特效按钮列表 add by lichengjie
	--得到推荐大区列表
	g_RecommendAreaBtn[1] = SelectServer_Tuijian_Area1;
	g_RecommendAreaBtn[2] = SelectServer_Tuijian_Area2;
	g_RecommendAreaBtn[3] = SelectServer_Tuijian_Area3;
	g_RecommendAreaBtn[4] = SelectServer_Tuijian_Area4;
	g_RecommendAreaBtn[5] = SelectServer_Tuijian_Area5;
	g_RecommendCNCAreaBtn[1] = SelectServer_Tuijian_Area6;
	g_RecommendCNCAreaBtn[2] = SelectServer_Tuijian_Area7;
	g_RecommendCNCAreaBtn[3] = SelectServer_Tuijian_Area8;
	g_RecommendCNCAreaBtn[4] = SelectServer_Tuijian_Area9;
	g_RecommendCNCAreaBtn[5] = SelectServer_Tuijian_Area10;

	local i;
	for i = 1, LOGIN_SERVER_AREA_COUNT do

	 	g_BnArea[i]:SetProperty("CheckMode", "1");

		g_AreaName[i] = "";
		g_AreaDis[i] = "";
		g_AreaTip[i] = "";
		g_testAreaTip[i] = "";
	end

	for i = 1,COMMENDABLE_LOGIN_SERVER_COUNT do
	 	-- Login server 按钮

	 	g_CommendableBnLoginServer[i]:SetProperty("CheckMode", "1");
		-- login server 名字
		g_CommendableLoginServerName[i] = "";
		--login server index
		g_CommendableLoginServerIndex[i]=-1;
		--added by lichengjie 2010-9-16
		g_CommendableLoginServerPrizeLevel[i] = 0;--初始化的时候表示都Kh鬾g奖励
		--end lichengjie
	end
	-- 得到�?i按钮
	g_BnLoginServer[1] = SelectServer_Server1;
	g_BnLoginServer[2] = SelectServer_Server2;
	g_BnLoginServer[3] = SelectServer_Server3;
	g_BnLoginServer[4] = SelectServer_Server4;
	g_BnLoginServer[5] = SelectServer_Server5;
	g_BnLoginServer[6] = SelectServer_Server6;
	g_BnLoginServer[7] = SelectServer_Server7;
	g_BnLoginServer[8] = SelectServer_Server8;
	g_BnLoginServer[9] = SelectServer_Server9;
	g_BnLoginServer[10] = SelectServer_Server10;

	g_BnLoginServer[11] = SelectServer_Server11;
	g_BnLoginServer[12] = SelectServer_Server12;
	g_BnLoginServer[13] = SelectServer_Server13;
	g_BnLoginServer[14] = SelectServer_Server14;
	g_BnLoginServer[15] = SelectServer_Server15;
	g_BnLoginServer[16] = SelectServer_Server16;
	g_BnLoginServer[17] = SelectServer_Server17;
	g_BnLoginServer[18] = SelectServer_Server18;
	g_BnLoginServer[19] = SelectServer_Server19;
	g_BnLoginServer[20] = SelectServer_Server20;

	g_BnLoginServer[21] = SelectServer_Server21;
	g_BnLoginServer[22] = SelectServer_Server22;
	g_BnLoginServer[23] = SelectServer_Server23;
	g_BnLoginServer[24] = SelectServer_Server24;
	g_BnLoginServer[25] = SelectServer_Server25;
	g_BnLoginServer[26] = SelectServer_Server26;
	g_BnLoginServer[27] = SelectServer_Server27;
	g_BnLoginServer[28] = SelectServer_Server28;
	g_BnLoginServer[29] = SelectServer_Server29;
	g_BnLoginServer[30] = SelectServer_Server30;

	g_BnLoginServer[31] = SelectServer_Server31;
	g_BnLoginServer[32] = SelectServer_Server32;
	g_BnLoginServer[33] = SelectServer_Server33;
	g_BnLoginServer[34] = SelectServer_Server34;
	g_BnLoginServer[35] = SelectServer_Server35;
	g_BnLoginServer[36] = SelectServer_Server36;
	g_BnLoginServer[37] = SelectServer_Server37;
	g_BnLoginServer[38] = SelectServer_Server38;
	g_BnLoginServer[39] = SelectServer_Server39;
	g_BnLoginServer[40] = SelectServer_Server40;

	g_BnLoginServer[41] = SelectServer_Server41;
	g_BnLoginServer[42] = SelectServer_Server42;
	g_BnLoginServer[43] = SelectServer_Server43;
	g_BnLoginServer[44] = SelectServer_Server44;
	g_BnLoginServer[45] = SelectServer_Server45;
	g_BnLoginServer[46] = SelectServer_Server46;
	g_BnLoginServer[47] = SelectServer_Server47;
	g_BnLoginServer[48] = SelectServer_Server48;
	g_BnLoginServer[49] = SelectServer_Server49;
	g_BnLoginServer[50] = SelectServer_Server50;

	g_BnLoginServer[51] = SelectServer_Server51;
	g_BnLoginServer[52] = SelectServer_Server52;
	g_BnLoginServer[53] = SelectServer_Server53;
	g_BnLoginServer[54] = SelectServer_Server54;
	g_BnLoginServer[55] = SelectServer_Server55;
	g_BnLoginServer[56] = SelectServer_Server56;
	g_BnLoginServer[57] = SelectServer_Server57;
	g_BnLoginServer[58] = SelectServer_Server58;
	g_BnLoginServer[59] = SelectServer_Server59;
	g_BnLoginServer[60] = SelectServer_Server60;

	g_BnLoginServer[61] = SelectServer_Server61;
	g_BnLoginServer[62] = SelectServer_Server62;
	g_BnLoginServer[63] = SelectServer_Server63;
	g_BnLoginServer[64] = SelectServer_Server64;
	g_BnLoginServer[65] = SelectServer_Server65;
	g_BnLoginServer[66] = SelectServer_Server66;
	g_BnLoginServer[67] = SelectServer_Server67;
	g_BnLoginServer[68] = SelectServer_Server68;
	g_BnLoginServer[69] = SelectServer_Server69;
	g_BnLoginServer[70] = SelectServer_Server70;

	g_BnLoginServer[71] = SelectServer_Server71;
	g_BnLoginServer[72] = SelectServer_Server72;
	g_BnLoginServer[73] = SelectServer_Server73;
	g_BnLoginServer[74] = SelectServer_Server74;
	g_BnLoginServer[75] = SelectServer_Server75;
	g_BnLoginServer[76] = SelectServer_Server76;
	g_BnLoginServer[77] = SelectServer_Server77;
	g_BnLoginServer[78] = SelectServer_Server78;
	g_BnLoginServer[79] = SelectServer_Server79;
	g_BnLoginServer[80] = SelectServer_Server80;

	g_BnLoginServer[81] = SelectServer_Server81;
	g_BnLoginServer[82] = SelectServer_Server82;
	g_BnLoginServer[83] = SelectServer_Server83;
	g_BnLoginServer[84] = SelectServer_Server84;
	g_BnLoginServer[85] = SelectServer_Server85;


	for i = 1, LOGIN_SERVER_COUNT do
	 	-- Login server 按钮
	 	g_BnLoginServer[i]:SetProperty("CheckMode", "1");

		-- login server 状态
		g_LoginServerStatus[i] = 0;

		-- login server 名字
		g_LoginServerName[i] = "";

		g_LoginServerCommendableLevel[i]="";
		--added by lichengjie 2010-9-16
		g_LoginServerPrizeLevel[i] = 0;--初始化的时候表示都Kh鬾g奖励
		--end lichengjie
	end
	-- 隐藏所有推荐�?i
	HideAllCommendableBn();
	--先隐藏推荐大区按钮
	HideRecommendAreaBn();
	HideRecommendCNCAreaBn();
	-- 得到�?i信息
	LoginSelectServer_GetServerInfo();

	local strNormalColor = "#cFFF263";
	SelectServer_Help_Text1:SetText(	strNormalColor.."#e010101#cff0000婿: 啸y#cffffff" );
	SelectServer_Help_Text2:SetText(	strNormalColor.."#e010101#cECE58DNh誸: T痶#cffffff" );
	SelectServer_Help_Text3:SetText(	strNormalColor.."#e010101#c959595X醡: B鋙 d咿ng#cffffff" );
	SelectServer_Help_Text4:SetText(	strNormalColor.."#e010101#cff8a00V鄋g cam: S 馥y#cffffff" );
	SelectServer_Help_Text5:SetText(	strNormalColor.."#e010101#c4CFA4CM鄒 xanh: C馽 t痶#cffffff" );


	--如果M課g internet连M課g internet则一半的几率推荐默认，一半的几率推荐M課g internet二
	local Num_Rand = math.random(1,10000);
	if(Num_Rand <= 5000) then
		Sel_TuiJian = 0;
	else
		Sel_TuiJian = 1;
	end

	--特效按钮数组lichengjie
	-- 得到特效�?i按钮
	g_BnLoginServerAnimate[1] = SelectServer_Server1_Animate;
	g_BnLoginServerAnimate[2] = SelectServer_Server2_Animate;
	g_BnLoginServerAnimate[3] = SelectServer_Server3_Animate;
	g_BnLoginServerAnimate[4] = SelectServer_Server4_Animate;
	g_BnLoginServerAnimate[5] = SelectServer_Server5_Animate;
	g_BnLoginServerAnimate[6] = SelectServer_Server6_Animate;
	g_BnLoginServerAnimate[7] = SelectServer_Server7_Animate;
	g_BnLoginServerAnimate[8] = SelectServer_Server8_Animate;
	g_BnLoginServerAnimate[9] = SelectServer_Server9_Animate;
	g_BnLoginServerAnimate[10] = SelectServer_Server10_Animate;
	g_BnLoginServerAnimate[11] = SelectServer_Server11_Animate;
	g_BnLoginServerAnimate[12] = SelectServer_Server12_Animate;
	g_BnLoginServerAnimate[13] = SelectServer_Server13_Animate;
	g_BnLoginServerAnimate[14] = SelectServer_Server14_Animate;
	g_BnLoginServerAnimate[15] = SelectServer_Server15_Animate;
	g_BnLoginServerAnimate[16] = SelectServer_Server16_Animate;
	g_BnLoginServerAnimate[17] = SelectServer_Server17_Animate;
	g_BnLoginServerAnimate[18] = SelectServer_Server18_Animate;
	g_BnLoginServerAnimate[19] = SelectServer_Server19_Animate;
	g_BnLoginServerAnimate[20] = SelectServer_Server20_Animate;

	g_BnLoginServerAnimate[21] = SelectServer_Server21_Animate;
	g_BnLoginServerAnimate[22] = SelectServer_Server22_Animate;
	g_BnLoginServerAnimate[23] = SelectServer_Server23_Animate;
	g_BnLoginServerAnimate[24] = SelectServer_Server24_Animate;
	g_BnLoginServerAnimate[25] = SelectServer_Server25_Animate;
	g_BnLoginServerAnimate[26] = SelectServer_Server26_Animate;
	g_BnLoginServerAnimate[27] = SelectServer_Server27_Animate;
	g_BnLoginServerAnimate[28] = SelectServer_Server28_Animate;
	g_BnLoginServerAnimate[29] = SelectServer_Server29_Animate;
	g_BnLoginServerAnimate[30] = SelectServer_Server30_Animate;

	g_BnLoginServerAnimate[31] = SelectServer_Server31_Animate;
	g_BnLoginServerAnimate[32] = SelectServer_Server32_Animate;
	g_BnLoginServerAnimate[33] = SelectServer_Server33_Animate;
	g_BnLoginServerAnimate[34] = SelectServer_Server34_Animate;
	g_BnLoginServerAnimate[35] = SelectServer_Server35_Animate;
	g_BnLoginServerAnimate[36] = SelectServer_Server36_Animate;
	g_BnLoginServerAnimate[37] = SelectServer_Server37_Animate;
	g_BnLoginServerAnimate[38] = SelectServer_Server38_Animate;
	g_BnLoginServerAnimate[39] = SelectServer_Server39_Animate;
	g_BnLoginServerAnimate[40] = SelectServer_Server40_Animate;

	g_BnLoginServerAnimate[41] = SelectServer_Server41_Animate;
	g_BnLoginServerAnimate[42] = SelectServer_Server42_Animate;
	g_BnLoginServerAnimate[43] = SelectServer_Server43_Animate;
	g_BnLoginServerAnimate[44] = SelectServer_Server44_Animate;
	g_BnLoginServerAnimate[45] = SelectServer_Server45_Animate;
	g_BnLoginServerAnimate[46] = SelectServer_Server46_Animate;
	g_BnLoginServerAnimate[47] = SelectServer_Server47_Animate;
	g_BnLoginServerAnimate[48] = SelectServer_Server48_Animate;
	g_BnLoginServerAnimate[49] = SelectServer_Server49_Animate;
	g_BnLoginServerAnimate[50] = SelectServer_Server50_Animate;

	g_BnLoginServerAnimate[51] = SelectServer_Server51_Animate;
	g_BnLoginServerAnimate[52] = SelectServer_Server52_Animate;
	g_BnLoginServerAnimate[53] = SelectServer_Server53_Animate;
	g_BnLoginServerAnimate[54] = SelectServer_Server54_Animate;
	g_BnLoginServerAnimate[55] = SelectServer_Server55_Animate;
	g_BnLoginServerAnimate[56] = SelectServer_Server56_Animate;
	g_BnLoginServerAnimate[57] = SelectServer_Server57_Animate;
	g_BnLoginServerAnimate[58] = SelectServer_Server58_Animate;
	g_BnLoginServerAnimate[59] = SelectServer_Server59_Animate;
	g_BnLoginServerAnimate[60] = SelectServer_Server60_Animate;

	g_BnLoginServerAnimate[61] = SelectServer_Server61_Animate;
	g_BnLoginServerAnimate[62] = SelectServer_Server62_Animate;
	g_BnLoginServerAnimate[63] = SelectServer_Server63_Animate;
	g_BnLoginServerAnimate[64] = SelectServer_Server64_Animate;
	g_BnLoginServerAnimate[65] = SelectServer_Server65_Animate;
	g_BnLoginServerAnimate[66] = SelectServer_Server66_Animate;
	g_BnLoginServerAnimate[67] = SelectServer_Server67_Animate;
	g_BnLoginServerAnimate[68] = SelectServer_Server68_Animate;
	g_BnLoginServerAnimate[69] = SelectServer_Server69_Animate;
	g_BnLoginServerAnimate[70] = SelectServer_Server70_Animate;

	g_BnLoginServerAnimate[71] = SelectServer_Server71_Animate;
	g_BnLoginServerAnimate[72] = SelectServer_Server72_Animate;
	g_BnLoginServerAnimate[73] = SelectServer_Server73_Animate;
	g_BnLoginServerAnimate[74] = SelectServer_Server74_Animate;
	g_BnLoginServerAnimate[75] = SelectServer_Server75_Animate;
	g_BnLoginServerAnimate[76] = SelectServer_Server76_Animate;
	g_BnLoginServerAnimate[77] = SelectServer_Server77_Animate;
	g_BnLoginServerAnimate[78] = SelectServer_Server78_Animate;
	g_BnLoginServerAnimate[79] = SelectServer_Server79_Animate;
	g_BnLoginServerAnimate[80] = SelectServer_Server80_Animate;

	g_BnLoginServerAnimate[81] = SelectServer_Server81_Animate;
	g_BnLoginServerAnimate[82] = SelectServer_Server82_Animate;
	g_BnLoginServerAnimate[83] = SelectServer_Server83_Animate;
	g_BnLoginServerAnimate[84] = SelectServer_Server84_Animate;
	g_BnLoginServerAnimate[85] = SelectServer_Server85_Animate;

	SelectServer_Server_Last_Animate:SetProperty("Animate", "");
	SelectServer_Server_Last_Animate:SetProperty("Visible", "False");
	--lichengjie

	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_46}" ,1)	--电信      0
	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_48}" ,2)	--M課g internet1		1
	SelectServer_LineSelect:AddTextItem("#{DDFWQ_XML_01}" ,3)	--M課g internet2		4
	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_50}" ,4)	--M課g gi醥 d鴆	2
	SelectServer_LineSelect:AddTextItem("M 鸶nh" ,5)				--默认		3

	SelectServer_LineSelect:SetCurrentSelect(4)

	-- 打开界面
	SelectServer_Frame:SetProperty("AlwaysOnTop", "True");

	-- 先隐藏所有按钮。
	HideAreaBn();
	-- 先隐藏所有按钮。
	HideTestAreaBn();

end

function HideAllCommendableBn()
	for i = 1,COMMENDABLE_LOGIN_SERVER_COUNT do
		g_CommendableBnLoginServer[i]:Hide();
		--lichengjie 不但要隐藏，而且要将获奖置为0，Tip置为“”，动画置为Kh鬾g
		g_CommendableBnLoginServer[i]:SetToolTip("");
		g_CommendableBnLoginServerAnimate[i]:SetProperty("Animate","");
		g_CommendableBnLoginServerAnimate[i]:SetProperty("Visible","False");
		g_CommendableLoginServerPrizeLevel[i] = 0;
		--lichengjie
	end;
end
--是否自动把选择的�?i序号变成0，防止.txt文件有大的变动
local autoZero = 0;
-- OnEvent
function LoginSelectServer_OnEvent(event)

	if( event == "GAMELOGIN_OPEN_SELECT_SERVER" ) then
		this:Show();
		SelectServer_Server_SearchName:SetText("");
		-- 显示存在的区域按钮。
		--ShowAreaBn();
		--ShowTestAreaBn();
		--显示上下翻页
		UpdateUpAddDownButton();
		ShowServerSelectSub1();

		-- 播放背景音乐
		if(g_idBackSound == -1) then
			g_idBackSound = Sound:PlaySound(2110, true);
		end

		for i = 1,indexForCommendable do
			if(g_CommendableLoginServerAreaIndex[i] == g_LastArea and g_CommendableLoginServerName[i] == g_LastServerName)then
				g_CommendableBnLoginServer[i]:SetCheck(1);
				NotFlashAreaBtnAll();
 				if(g_CommendableLoginServerAreaIndex[i] <= g_iCurAreaCount) then
					g_BnArea[g_CommendableLoginServerAreaIndex[i]+1]:SetCheck(1);
					g_BnArea[g_CommendableLoginServerAreaIndex[i]+1]:FlashMe(1);
				else
					local testAreaindex = g_CommendableLoginServerAreaIndex[i]+1-g_iCurAreaCount;
					if(testAreaindex > 0) then
						g_BntestArea[testAreaindex]:SetCheck(1);
						g_BntestArea[testAreaindex]:FlashMe(1);
					end
 				end
				Commendable_ShowServerInfo(i);
				return;
			end
		end
		for i = 1,indexForCommendable do
			g_CommendableBnLoginServer[i]:SetCheck(0)
		end
		ClearServerTextInfo();
		--if( 1 == g_FirstLogin ) then
           -- GameProduceLogin:ShowMessageBox( "    目前只开放了一台M課g internet�?i用于测试，如果您是电信的用户，请在�?i选择界面的右边选择“电信”进行登录，这样才能使用互联互通功能以保证您的连接速度。", "OK", "1" );
		    --g_FirstLogin = 0
		--end

		return;
	end


	-- 关闭界面
	if( event == "GAMELOGIN_CLOSE_SELECT_SERVER") then
		NotFlashAreaBtnAll();
		this:Hide();
		return;
	end

	-- 选择一个login server
	if( event == "GAMELOGIN_SELECT_LOGIN_SERVER") then
		local num = tonumber(arg0);
		for aindex = 1,g_iCurAreaCount do
			if(num == g_AreaIndex[aindex]) then
				CurPage = math.floor((aindex-1)/PageSize);
				ShowPage();
				SelectServer_SelectAreaServer(aindex - CurPage*PageSize -1);
				SelectServer_SelectLoginServer(tonumber(arg1),1);
			return;
			end
		end
		for bindex = 1,g_iCurTestAreaCount do
			if(num == g_testAreaIndex[bindex]) then
				SelectServer_SelectTestAreaServer(bindex-1);
				SelectServer_SelectLoginServer(tonumber(arg1),1);
				return;
			end
		end
		return;
	end

	-- 选择区域
	if( event == "GAMELOGIN_SELECT_AREA") then
		--如果从账号输入界面返回大区界面
		if( g_iCurComSelLoginServer ~= -1) then
			return;
		end
		autoZero = 0;
		local num = tonumber(arg0);
		for aindex = 1,g_iCurAreaCount do
			if(num == g_AreaIndex[aindex]) then
				CurPage = math.floor((aindex-1)/PageSize);
				ShowPage();
				SelectServer_SelectAreaServer(aindex - CurPage*PageSize -1);
				return;
			end
		end
		for bindex = 1,g_iCurTestAreaCount do
			if(num == g_testAreaIndex[bindex]) then
				SelectServer_SelectTestAreaServer(bindex-1);
				return;
			end
		end
		--完全没有找到，说明文件有了大的变化
		CurPage = 0;
		autoZero = 1;
		SelectServer_SelectAreaServer(1 - CurPage*PageSize -1);
		return;
	end;

	-- 选择login
	if( event == "GAMELOGIN_SELECT_LOGINSERVER") then
		--如果从账号输入界面返回大区界面
		if( g_iCurComSelLoginServer ~= -1) then
			for i = 1,indexForCommendable do
				if( g_iCurSelArea == g_CommendableLoginServerAreaIndex[i] and g_CommendableLoginServerName[i] == g_iCurSelLoginServerName) then
					g_CommendableBnLoginServer[i]:SetCheck(1);
					NotFlashAreaBtnAll();
					if(g_iCurSelArea < g_iCurAreaCount) then
						g_BnArea[g_iCurSelArea+1]:SetCheck(1);
						g_BnArea[g_iCurSelArea+1]:FlashMe(1);
					else
						local testAreaindex = g_iCurSelArea+1-g_iCurAreaCount;
						if(testAreaindex > 0) then
							g_BntestArea[testAreaindex]:SetCheck(1);
							g_BntestArea[testAreaindex]:FlashMe(1);
						end
 					end
					Commendable_ShowServerInfo(i);
				end
			end
			return;
		end
		if ( g_BnLoginServer[tonumber(arg0)+1]:GetProperty("Disabled")=="False") then
			if(autoZero == 0 )then
				SelectServer_SelectLoginServer(tonumber(arg0),0);
			else
				SelectServer_SelectLoginServer(0,0);
				autoZero = 0;
			end
		end;
		return;
	end;

	-- 使用代理
	if( event == "GAMELOGIN_SELECT_USEPROXY" ) then
		if tonumber(arg0) == 0 then
			g_iNetProvide = 0
			SelectServer_LineSelect:SetCurrentSelect(0)
		elseif tonumber(arg0) == 1 then
			g_iNetProvide = 1
			SelectServer_LineSelect:SetCurrentSelect(1)
		elseif tonumber(arg0) == 2 then
			g_iNetProvide = 2
			SelectServer_LineSelect:SetCurrentSelect(3)
		elseif tonumber(arg0) == 3 then
			g_iNetProvide = 3
			SelectServer_LineSelect:SetCurrentSelect(4)
		elseif tonumber(arg0) == 4 then
			g_iNetProvide = 4
			SelectServer_LineSelect:SetCurrentSelect(2)
		end
		return;
	end;

	-- 进入场景，停止背景音乐
	if( event == "PLAYER_ENTERING_WORLD") then
		if(g_idBackSound ~= -1) then
			Sound:StopSound(g_idBackSound);
			g_idBackSound = -1;
		end
	end
	--ping结果
	if(event == "PING_RESAULT")then
		local num = tonumber(arg0)
		if(num ~=nil)then
			if(num>=0)then
				if(num<=CriticalSpeed)then
					SelectServer_Text2:SetText(NetSpeed[1]);
				elseif( num<=CriticalSpeed2 ) then
				    SelectServer_Text2:SetText(NetSpeed[2]);
				elseif( num<=CriticalSpeed3 ) then
				    SelectServer_Text2:SetText(NetSpeed[4]);
				else
				    SelectServer_Text2:SetText(NetSpeed[3]);
				--else
				--	SelectServer_Text2:SetText(NetSpeed[2]);
				end
				SelectServer_Text2:SetToolTip("K閛 d鄆 th秈 gian m課g:"..num);
			else
				SelectServer_Text2:SetText(NetSpeed[3]);
				SelectServer_Text2:SetToolTip("K閛 d鄆 th秈 gian m課g:ch遖 bi猼");
			end
		end
	end

	--上次登录�?i
	if( event == "GAMELOGIN_LASTSELECT_AREA_AND_SERVER") then
		local numArea =-1;
		local numServer = -1;
		if(arg0~=nil)then
			numArea = tonumber(arg0);
			g_LastArea = numArea;
		end
		if(arg1~=nil)then
			numServer = tonumber(arg1);
			g_LastServer = numServer;
		end
		if(numArea ~= -1 and numServer~=-1)then
			local have = 0;
			for aindex = 1,g_iCurAreaCount do
				if(numArea == g_AreaIndex[aindex]) then
					have = 1;
					break;
				end
			end
			for bindex = 1,g_iCurTestAreaCount do
				if(numArea == g_testAreaIndex[bindex]) then
					have = 1;
					break;
				end
			end
			if(have == 1)then
				g_LastServerName, g_LastServerState,_,_,_, g_LastServerPrizeLevel = GameProduceLogin:GetAreaLoginServerInfo(numArea, numServer);
				SelectServer_Server_Last:SetText(g_LastServerName);
				--判断上次登录�?i是否处于维护状态 tt69698
				if (g_LastServerState == StateStop) then
					SelectServer_Server_Last:SetCheck(0);
					SelectServer_Server_Last:Disable();
				else
					SelectServer_Server_Last:Enable();
					--if(g_iCurSelArea == g_LastArea and g_LastServer ==g_iCurSelLoginServer)then
						SelectServer_Server_Last:SetCheck(1);
					--end
				end
				---lichengjie 判断上次获得奖励，如果上次处于维护状态是否还显示特效？，现在是显示
				g_LastServerPrizeLevel = 0--Custom**
				if( g_LastServerPrizeLevel > 0 ) then
					SelectServer_Server_Last_Animate:SetProperty("Animate", g_LastServerPrizeAnimate[g_LastServerPrizeLevel]);
					SelectServer_Server_Last_Animate:SetProperty("Visible", "True");
				else
					SelectServer_Server_Last_Animate:SetProperty("Animate", "");
					SelectServer_Server_Last_Animate:SetProperty("Visible", "False");
				end
				---lichengjie
				--获取选择大区
				SelectServer_Server_AreaNameShow:SetText(g_iCurSelAreaName);
				if g_iCurSelAreaName ~= "" then
					SelectServer_Server_Lastarea:SetText(g_iCurSelAreaName);
				else
					SelectServer_Server_Lastarea:SetText("Kh鬾g");
				end
				SelectServer_Server_Lastarea:Enable();
			else
				SelectServer_Server_Last:SetText("Kh鬾g");
				SelectServer_Server_Last:SetCheck(0);
				SelectServer_Server_Last:Disable();
			end
		else
			SelectServer_Server_Last:SetText("Kh鬾g");
			SelectServer_Server_Last:SetCheck(0);
			SelectServer_Server_Last:Disable();
			---added by lichengjie
			g_LastServerPrizeLevel = 0;
			SelectServer_Server_Last_Animate:SetProperty("Animate", "");
			SelectServer_Server_Last_Animate:SetProperty("Visible", "False");
			---lichengjie
		end
		return;
	end;

	if( event == "GAMELOGIN_SERVER_SHOW_COUNTINPUT") then
		SelectServer_SelectOk();
	end

	if( event == "GAMELOGIN_SERVER_SHOW_SUB") then
		SelectServer_ReturnAreaSelect_click();
	end

	if( event == "GAMELOGIN_UPDATE_SERVERINFO") then
		-- 隐藏所有推荐�?i
		HideAllCommendableBn();
		--先隐藏推荐大区按钮
		HideRecommendAreaBn();
		HideRecommendCNCAreaBn();
		-- 得到�?i信息
		LoginSelectServer_GetServerInfo();
			-- 先隐藏所有按钮。
		HideAreaBn();
		-- 先隐藏所有按钮。
		HideTestAreaBn();
	end
end

function SelectServer_SelectLastServer()
	if(g_LastArea ~=-1 and g_LastServer ~= -1)then
		for aindex = 1,g_iCurAreaCount do
			if(g_LastArea == g_AreaIndex[aindex]) then
				CurPage = math.floor((aindex-1)/PageSize);
				ShowPage();
				SelectServer_SelectAreaServer(aindex - CurPage*PageSize -1);
				SelectServer_SelectLoginServer(g_LastServer,1);
				return;
			end
		end
		for bindex = 1,g_iCurTestAreaCount do
			if(g_LastArea == g_testAreaIndex[bindex]) then
				SelectServer_SelectTestAreaServer(bindex-1);
				SelectServer_SelectLoginServer(g_LastServer,1);
				return;
			end
		end

	end
end

function SelectServer_CurSelectArea()
	--SelectServer_Server_Lastarea:SetCheck(0);
end

--------------------------------------------------------------------------------------------------------------
--
-- 得到�?i信息
--

function LoginSelectServer_GetServerInfo()

	 	local iCurAreaCount = GameProduceLogin:GetServerAreaCount();
	 	local strAreaName = "Kh鬾g c� m醳 ch� ph鴆 v�";
		local iLoginServerCount = -1;
		local ServerName;
		local ServerStatus;
		--推荐等级
		local RecommendLevel;
		local IsNew;
		--lichengjie
		local ServerPrizeLevel=0;
		--lichengjie
		indexForCommendable = 0;
		indexForRecommendArea = 0;
		indexForRecommendCNCArea = 0;
		local testindex = 0;
		local nomalindex =0;
		local tuijian=0;
	 	for index = 0, iCurAreaCount - 1 do
			tuijian =0;
			if(testindex>=LOGIN_SERVER_TESTAREA_COUNT and nomalindex>=EFFECT_LOGIN_SERVER_AREA_COUNT) then
				break;
			end
			local areaname = GameProduceLogin:GetServerAreaName(index);
	 		-- 得到区域名字.
			local i = string.find(areaname,"-");
			if(i~=nil and i<string.len(areaname)) then
				if(string.sub(areaname,1,i-1)=="M課g internet" and testindex<LOGIN_SERVER_TESTAREA_COUNT)then
					testindex = testindex +1;
					g_testAreaName[testindex] = string.sub(areaname,i+1);
					g_testAreaDis[testindex] = GameProduceLogin:GetServerAreaDis(index);
					g_testAreaIndex[testindex] = index;
					tuijian = 1;
					g_testAreaTip[testindex] = GameProduceLogin:GetServerAreaDis(index);
				elseif(string.sub(areaname,1,i-1)=="C鬾g tr" and nomalindex< EFFECT_LOGIN_SERVER_AREA_COUNT) then
					nomalindex = nomalindex +1;
	 				g_AreaName[nomalindex] = string.sub(areaname,i+1);
					g_AreaDis[nomalindex] = GameProduceLogin:GetServerAreaDis(index);
					g_AreaIndex[nomalindex] = index;
					tuijian = 1;
					g_AreaTip[nomalindex] = GameProduceLogin:GetServerAreaDis(index);
				end
			elseif(nomalindex< EFFECT_LOGIN_SERVER_AREA_COUNT) then
				nomalindex = nomalindex +1;
	 			g_AreaName[nomalindex] = GameProduceLogin:GetServerAreaName(index);
				g_AreaDis[nomalindex] = GameProduceLogin:GetServerAreaDis(index);
				g_AreaIndex[nomalindex] = index;
				tuijian = 1;
				g_AreaTip[nomalindex] = GameProduceLogin:GetServerAreaDis(index);
			end;
	 		-- 设置名字.
			iLoginServerCount = GameProduceLogin:GetAreaLoginServerCount(index);
			if(iLoginServerCount > LOGIN_SERVER_COUNT) then
				iLoginServerCount=LOGIN_SERVER_COUNT;
			end
			--得到推荐大区列表
			--local areaRecommendLevel = GameProduceLogin:GetServerAreaRecommendLevel(index);--Custom**
			local areaRecommendLevel = 0
			if(areaRecommendLevel > 0)  then
				if(i~=nil and i<string.len(areaname)) then
					if(string.sub(areaname,1,i-1)=="M課g internet" and indexForRecommendCNCArea<RECOMMEND_AREA_COUNT) then
						indexForRecommendCNCArea = indexForRecommendCNCArea+1;
						g_RecommendCNCAreaRecommendLevel[indexForRecommendCNCArea] = areaRecommendLevel;
						g_RecommendCNCAreaName[indexForRecommendCNCArea] = string.sub(areaname,i+1);
					elseif(string.sub(areaname,1,i-1)=="C鬾g tr" and indexForRecommendArea< RECOMMEND_AREA_COUNT) then
						indexForRecommendArea = indexForRecommendArea+1;
						g_RecommendAreaRecommendLevel[indexForRecommendArea] = areaRecommendLevel;
						g_RecommendAreaName[indexForRecommendArea] = string.sub(areaname,i+1);
					end
				elseif( indexForRecommendArea < RECOMMEND_AREA_COUNT) then
					indexForRecommendArea = indexForRecommendArea+1;
					g_RecommendAreaRecommendLevel[indexForRecommendArea] = areaRecommendLevel;
					g_RecommendAreaName[indexForRecommendArea] = areaname
				end
			end

			--得到推荐�?i列表
			if(tuijian==1)then
				for i=0,iLoginServerCount-1 do

					ServerPrizeLevel= 0; --licehngjie赋值之后设为0

					if(indexForCommendable>=COMMENDABLE_LOGIN_SERVER_COUNT) then
							break;
					end;
					ServerName,
					ServerStatus,
					--ServerID,
					--AreaID,
					RecommendLevel,
					IsNew
					--lichengjie
					,_,
					ServerPrizeLevel
					--lichengjie
						= GameProduceLogin:GetAreaLoginServerInfo(index, i);
						-- 推荐�?iid
					if(RecommendLevel>0 and indexForCommendable <COMMENDABLE_LOGIN_SERVER_COUNT and ServerStatus ~= StatMax) then
						indexForCommendable = indexForCommendable + 1;
						g_CommendableLoginServerName[indexForCommendable] = ServerName;
						g_CommendableLoginServerServerIndex[indexForCommendable] = i;
						g_CommendableLoginServerAreaIndex[indexForCommendable] = index;
						g_CommendableLoginServerCommendableLevel[indexForCommendable] = RecommendLevel;
						g_CommendableLoginServerIsNew[indexForCommendable] = IsNew;
						g_CommendableLoginServerStatus[indexForCommendable] = ServerStatus;
						--added by lichengjie 如果在此处用全局变量赋值的话，提示错误。客户端Kh鬾g法启动。
						--g_CommendableLoginServerPrizeLevel[indexForCommendable] = ServerPrizeLevel;
						SetValueForComLSPrizeLevel(indexForCommendable,ServerPrizeLevel)

						--end added by lichengjie

					end;


				end
			end;
	 	end
		--按序显示推荐大区
		if(indexForRecommendArea>=1)then
			SortRecommendArea();
			for i = 1,indexForRecommendArea do
				g_RecommendAreaBtn[i]:Show();
				g_RecommendAreaBtn[i]:SetText( g_RecommendAreaName[i]);
				g_RecommendAreaBtn[i]:SetCheck(0);
			end
		end
		if(indexForRecommendCNCArea>=1)then
			SortRecommendCNCArea();
			for i = 1,indexForRecommendCNCArea do
				g_RecommendCNCAreaBtn[i]:Show();
				g_RecommendCNCAreaBtn[i]:SetText( g_RecommendCNCAreaName[i]);
				g_RecommendCNCAreaBtn[i]:SetCheck(0);
			end
		end
		--按序显示推荐�?i
		if(indexForCommendable>=1)then
			SortCommendableLoginServer();

			local strName="";
			for i = 1,indexForCommendable do
				g_CommendableBnLoginServer[i]:Show();
				local tmpAreaName = GameProduceLogin:GetServerAreaName(g_CommendableLoginServerAreaIndex[i]);
				local _i = string.find(tmpAreaName,"-");
				if(_i~=nil and _i<string.len(tmpAreaName)) then
					if(string.sub(tmpAreaName,1,_i-1)=="C鬾g tr" or string.sub(tmpAreaName,1,_i-1)=="M課g internet")then
						tmpAreaName = string.sub(tmpAreaName,_i+1);
					end
				end
				strName =tmpAreaName.."-"..g_CommendableLoginServerName[i];
				if(g_CommendableLoginServerIsNew[i]~=0)then
					strName =strName.."(M緄)";
				end
				if(0 == g_CommendableLoginServerStatus[i]) then
					--TT76745
					g_CommendableBnLoginServer[i]:Enable();
					strName = "#cff0000#e010101"..strName.."#cffffff";
				elseif(1 == g_CommendableLoginServerStatus[i]) then
					--TT76745
					g_CommendableBnLoginServer[i]:Enable();
					strName = "#cff8a00#e010101"..strName.."#cffffff";
				elseif(2 == g_CommendableLoginServerStatus[i]) then
					--TT76745
					g_CommendableBnLoginServer[i]:Enable();
					strName = "#cECE58D#e010101"..strName.."#cffffff";
				elseif(3 == g_CommendableLoginServerStatus[i]) then
					--TT76745
					g_CommendableBnLoginServer[i]:Enable();
					strName = "#c4CFA4C#e010101"..strName.."#cffffff";
				else

					strName = "#c959595#e010101"..strName.."#cffffff";
					g_CommendableBnLoginServer[i]:Disable();
				end

				g_CommendableBnLoginServer[i]:SetText(strName);
				g_CommendableBnLoginServer[i]:SetCheck(0);
				--added by lichengjie
				SetValueForShowComLSPrizeLeve(i);
				--if( g_CommendableLoginServerPrizeLevel[i] > 0) then
				--	g_CommendableBnLoginServer[i]:SetToolTip(g_ThreePrizeTip[g_CommendableLoginServerPrizeLevel[i]]);
				--	g_CommendableBnLoginServerAnimate[i]:SetProperty("Animate",g_ThreeCommendablePrizeAnimate[g_CommendableLoginServerPrizeLevel[i]]);
				--	g_CommendableBnLoginServerAnimate[i]:SetProperty("Visible","True");
				--end
				--end added by lichengjie
			end;
		end;
		g_iCurAreaCount =nomalindex ;
		g_iCurTestAreaCount = testindex;
end
--------------------------------------------------------------------------------------
--每个函数里面的全局变量引用次数达到33个时候，会提示UpValues错误
--所以，将给推荐�?i赋奖励等级的时候，单独提取出一个函数
--这说明了一个问题，SelectServer已经足够复杂了，需要重构一下，拆分出一些小函数
--另外，每个函数里面local的个数也有限制。这都是编译器自身的设定，所以要注意一下。特此声明
--------------------------------------------------------------------------------------
--added by lichengjie
function SetValueForComLSPrizeLevel(indexForCommendable, prizelevel) --单独为赋值
	g_CommendableLoginServerPrizeLevel[indexForCommendable] = prizelevel;

end
--------------------------------------------------------------------------------------
--每个函数里面的全局变量引用次数达到33个时候，会提示UpValues错误
--所以，将给推荐�?i赋奖励等级的时候，单独提取出一个函数
--这说明了一个问题，SelectServer已经足够复杂了，需要重构一下，拆分出一些小函数
--另外，每个函数里面local的个数也有限制。这都是编译器自身的设定，所以要注意一下。特此声明
--------------------------------------------------------------------------------------
--added by lichengjie
--Custom**
function SetValueForShowComLSPrizeLeve(indexForCommendable) --显示为赋值

	--if( g_CommendableLoginServerPrizeLevel[indexForCommendable] > 0) then
	--	g_CommendableBnLoginServer[indexForCommendable]:SetToolTip(g_ThreePrizeTip[g_CommendableLoginServerPrizeLevel[indexForCommendable]]);
	--	g_CommendableBnLoginServerAnimate[indexForCommendable]:SetProperty("Animate",g_ThreeCommendablePrizeAnimate[g_CommendableLoginServerPrizeLevel[indexForCommendable]]);
	--	g_CommendableBnLoginServerAnimate[indexForCommendable]:SetProperty("Visible","True");
	--end
end

--排序推荐大区，从小到大
function SortRecommendArea()
	local TotalCount = indexForRecommendArea;
	if (2 > TotalCount) then
		return;
	end
	local tmp ;
	for j = 1, TotalCount -1 do
		for i = 1, TotalCount -j do
			if(g_RecommendAreaRecommendLevel[i]>g_RecommendAreaRecommendLevel[i+1]) then
				tmp = g_RecommendAreaRecommendLevel[i];
				g_RecommendAreaRecommendLevel[i] = g_RecommendAreaRecommendLevel[i+1];
				g_RecommendAreaRecommendLevel[i+1] = tmp;

				tmp = g_RecommendAreaName[i];
				g_RecommendAreaName[i] = g_RecommendAreaName[i+1];
				g_RecommendAreaName[i+1] = tmp;
			end
		end
	end
end

function SortRecommendCNCArea()
	local TotalCount = indexForRecommendCNCArea;
	if (2 > TotalCount) then
		return;
	end
	local tmp ;
	for j = 1, TotalCount -1 do
		for i = 1, TotalCount -j do
			if(g_RecommendCNCAreaRecommendLevel[i]>g_RecommendCNCAreaRecommendLevel[i+1]) then
				tmp = g_RecommendCNCAreaRecommendLevel[i];
				g_RecommendCNCAreaRecommendLevel[i] = g_RecommendCNCAreaRecommendLevel[i+1];
				g_RecommendCNCAreaRecommendLevel[i+1] = tmp;

				tmp = g_RecommendCNCAreaName[i];
				g_RecommendCNCAreaName[i] = g_RecommendCNCAreaName[i+1];
				g_RecommendCNCAreaName[i+1] = tmp;
			end
		end
	end
end

--排序列，从小到大
function SortCommendableLoginServer()

	local TotalCount = indexForCommendable;
	local tmp ;
	local p=0;
	for j = 1 , TotalCount -1 do
		for i=1, TotalCount-j do
			if(g_CommendableLoginServerCommendableLevel[i]>g_CommendableLoginServerCommendableLevel[i+1]) then
				tmp = g_CommendableLoginServerCommendableLevel[i];
				g_CommendableLoginServerCommendableLevel[i] = g_CommendableLoginServerCommendableLevel[i+1];
				g_CommendableLoginServerCommendableLevel[i+1] = tmp;

				tmp = g_CommendableLoginServerName[i];
				g_CommendableLoginServerName[i] = g_CommendableLoginServerName[i+1];
				g_CommendableLoginServerName[i+1] = tmp;

				tmp = g_CommendableLoginServerServerIndex[i];
				g_CommendableLoginServerServerIndex[i] = g_CommendableLoginServerServerIndex[i+1];
				g_CommendableLoginServerServerIndex[i+1] = tmp;

				tmp = g_CommendableLoginServerAreaIndex[i];
				g_CommendableLoginServerAreaIndex[i] = g_CommendableLoginServerAreaIndex[i+1];
				g_CommendableLoginServerAreaIndex[i+1] = tmp;

				tmp = g_CommendableLoginServerIsNew[i];
				g_CommendableLoginServerIsNew[i] = g_CommendableLoginServerIsNew[i+1];
				g_CommendableLoginServerIsNew[i+1] = tmp;

				tmp = g_CommendableLoginServerStatus[i];
				g_CommendableLoginServerStatus[i] = g_CommendableLoginServerStatus[i+1];
				g_CommendableLoginServerStatus[i+1] = tmp;

				tmp = g_CommendableLoginServerPrizeLevel[i];--------lichengjie --added
				g_CommendableLoginServerPrizeLevel[i] = g_CommendableLoginServerPrizeLevel[i+1];
				g_CommendableLoginServerPrizeLevel[i+1] = tmp;
			end
		end;
	end;
end;
--------------------------------------------------------------------------------------------------------------
--
-- 选择一个C鬾g tr区域
--
function SelectServer_SelectTestAreaServer(index)
	-- 记录当前选择的区域索引.
	g_iCurSelArea = g_testAreaIndex[index+1];

	-- 设置选择的名字
	g_iCurSelAreaName = g_testAreaName[index+1];

	-- 设置按钮选中状态.
	g_BntestArea[index+1]:SetCheck(1);

	-- 隐藏区域按钮.
	SelectServer_HideLoginServerBn();

	-- 得到login server的信息
	local iLoginServerCount = GameProduceLogin:GetAreaLoginServerCount(g_iCurSelArea);

	if(iLoginServerCount > LOGIN_SERVER_COUNT) then
		iLoginServerCount=LOGIN_SERVER_COUNT;
	end
	for indexLoginServer = 0, iLoginServerCount - 1 do
		SelectServer_GetAndShowLoginServer(indexLoginServer);
	end
	for iArea = 1, g_iCurAreaCount do
		g_BnArea[iArea]:SetCheck(0);
	end
	DisableSelect();
end
--------------------------------------------------------------------------------------------------------------
--
-- 选择一个区域
--
function SelectServer_SelectAreaServer(index)

	-- 记录当前选择的区域索引.
	g_iCurSelArea = g_AreaIndex[index+CurPage*PageSize+1];

	-- 设置选择的名字
	g_iCurSelAreaName = g_AreaName[index+CurPage*PageSize+1];

	-- 设置按钮选中状态.
	g_BnArea[index+1]:SetCheck(1);

	-- 隐藏区域按钮.
	SelectServer_HideLoginServerBn();

	-- 得到login server的信息
	local iLoginServerCount = GameProduceLogin:GetAreaLoginServerCount(g_iCurSelArea);

	if(iLoginServerCount > LOGIN_SERVER_COUNT) then
		iLoginServerCount=LOGIN_SERVER_COUNT;
	end
	for indexLoginServer = 0, iLoginServerCount - 1 do
		SelectServer_GetAndShowLoginServer(indexLoginServer);
	end
	for itestArea = 1, g_iCurTestAreaCount do
		g_BntestArea[itestArea]:SetCheck(0);
	end
	DisableSelect();
end

function DisableSelect()
		g_iCurSelLoginServer =-1;
		g_iCurComSelLoginServer = -1;
		for i = 1,indexForCommendable do
				g_CommendableBnLoginServer[i]:SetCheck(0)
		end;
		NotFlashAll();
		NotFlashAreaBtnAll();
		ClearServerTextInfo();
		--SelectServer_Accept:Disable();
end
--function EnableSelect()
--		SelectServer_Accept:Enable();
--end
--------------------------------------------------------------------------------------------------------------
--
-- 从推荐列表里选择一个login server
--
--------------------------------------------------------------------------------------------------------------
function Commendable_SelectLoginServer(index)
	-- 设置按钮选中状态.
	if(g_CommendableBnLoginServer[index]:GetProperty("Disabled")=="True") then
		return;
	end

	g_iCurComSelLoginServer = index;

	g_CommendableBnLoginServer[index]:SetCheck(1);

	--Modify by ChengJianCai 2010/03/04
	g_iCurSelArea = g_CommendableLoginServerAreaIndex[index];
	g_iCurSelLoginServer = g_CommendableLoginServerServerIndex[index];
	g_iCurSelLoginServerName = GameProduceLogin:GetAreaLoginServerInfo(g_iCurSelArea, g_iCurSelLoginServer);
	--大区按钮闪烁效果
	NotFlashAreaBtnAll();

 	if(g_iCurSelArea < g_iCurAreaCount) then
		g_BnArea[g_iCurSelArea+1]:SetCheck(1);
		g_BnArea[g_iCurSelArea+1]:FlashMe(1);
	else
		local testAreaindex = g_iCurSelArea+1-g_iCurAreaCount;
		if(testAreaindex > 0) then
			g_BntestArea[testAreaindex]:SetCheck(1);
			g_BntestArea[testAreaindex]:FlashMe(1);
		end
 	end;
	Commendable_ShowServerInfo(index);

--	i = g_CommendableLoginServerAreaIndex[index]
--	SelectServer_ShowServerInfo(g_AreaName[i+1].."  "..g_CommendableLoginServerName[index], "", strLoginServerStatus);
	--同时更新下面的�?i和server
--	g_iCurSelArea = g_CommendableLoginServerAreaIndex[index];
--	for aindex = 1,g_iCurAreaCount do
--		if(g_iCurSelArea == g_AreaIndex[aindex]) then
--			AxTrace(0,2,"5" )
--			CurPage = math.floor((aindex-1)/PageSize);
--			ShowPage();
--			SelectServer_SelectAreaServer(aindex - CurPage*PageSize -1);
--			SelectServer_SelectLoginServer(g_CommendableLoginServerServerIndex[index],1);
--			return;
--		end
--	end
--	for bindex = 1,g_iCurTestAreaCount do
--		if(g_iCurSelArea == g_testAreaIndex[bindex]) then
--			SelectServer_SelectTestAreaServer(bindex-1);
--			SelectServer_SelectLoginServer(g_CommendableLoginServerServerIndex[index],1);
--			return;
--		end
--	end
end;

function Commendable_ShowServerInfo(index)
	--得到推荐�?i大区名字
	local tmpAreaName = GameProduceLogin:GetServerAreaName(g_CommendableLoginServerAreaIndex[index]);
	local _i = string.find(tmpAreaName,"-");
	if(_i~=nil and _i<string.len(tmpAreaName)) then
		if(string.sub(tmpAreaName,1,_i-1)=="C鬾g tr" or string.sub(tmpAreaName,1,_i-1)=="M課g internet")then
			tmpAreaName = string.sub(tmpAreaName,_i+1);
		end
	end
	g_iCurSelAreaName = tmpAreaName;

	GameProduceLogin:SetPingServer(g_CommendableLoginServerAreaIndex[index],g_CommendableLoginServerServerIndex[index]);
	local strLoginServerStatus = "???";

	if(0 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cff0000啸y#cffffff";
	elseif(1 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cff8a00S 馥y#cffffff";
	elseif(2 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cECE58DT痶#cffffff";
	elseif(3 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#c4CFA4CC馽 t痶#cffffff";
	else

		strLoginServerStatus = "#e010101#c959595B鋙 d咿ng#cffffff";
	end

	-- 设置信息
	SelectServer_Text2:Show();
	SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_CommendableLoginServerName[index], "", strLoginServerStatus);
end


-- 选择一个login server
--
function SelectServer_SelectLoginServer(index,flash)
	if(g_BnLoginServer[index+1]:GetProperty("Disabled")=="True") then
		return;
	end
	--如果处于搜索显示页面
	if(g_bSearch == 1) then
		g_iCurSelArea = g_SearchServerAreaIndex[index+1];
		g_iCurSelLoginServer = 	g_SearchServerIndex[index+1];
		g_BnLoginServer[index+1]:SetCheck(1);

		GameProduceLogin:SetPingServer(g_iCurSelArea,g_iCurSelLoginServer);
		local strSearchServerStatus = "???";

		if(0 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#cff0000啸y#cffffff";
		elseif(1 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#c9E5705S 馥y#cffffff";
		elseif(2 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#cECE58DT痶#cffffff";
		elseif(3 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#c4CFA4CC馽 t痶#cffffff";
		else

			strSearchServerStatus = "#e010101#c959595B鋙 d咿ng#cffffff";
		end

		local tmpAreaName = GameProduceLogin:GetServerAreaName(g_iCurSelArea);
		local _i = string.find(tmpAreaName,"-");
		if(_i~=nil and _i<string.len(tmpAreaName)) then
			if(string.sub(tmpAreaName,1,_i-1)=="C鬾g tr" or string.sub(tmpAreaName,1,_i-1)=="M課g internet")then
				tmpAreaName = string.sub(tmpAreaName,_i+1);
			end
		end
		g_iCurSelAreaName = tmpAreaName;

		SelectServer_Server_Lastarea:SetText(g_iCurSelAreaName);
		-- 设置信息
		SelectServer_Text2:Show();
		SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_SearchServerName[index+1], "", strSearchServerStatus);
				--推荐选择代理�?i
		LoginSelectServer_RecommendNetProvider();
		return;
	end

	GameProduceLogin:SetPingServer(g_iCurSelArea,index);

	--EnableSelect();
	-- 记录当前选择的login server
	g_iCurSelLoginServer = index;


	if(g_LastServer == g_iCurSelLoginServer and g_LastArea == g_iCurSelArea)then
		SelectServer_Server_Last:SetCheck(1);
	else
		SelectServer_Server_Last:SetCheck(0);
	end

	if(flash==1)then
		g_BnLoginServer[index+1]:FlashMe(1);
	else
		NotFlashAll();
	end
		--推荐选择代理�?i
    LoginSelectServer_RecommendNetProvider();

	-- 设置按钮选中状态.
	g_BnLoginServer[index+1]:SetCheck(1);
	local strLoginServerStatus = "???";

	if(0 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#cff0000啸y#cffffff";
	elseif(1 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#c9E5705S 馥y#cffffff";
	elseif(2 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#cECE58DT痶#cffffff";
	elseif(3 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#c4CFA4CC馽 t痶#cffffff";
	else

		strLoginServerStatus = "#e010101#c959595B鋙 d咿ng#cffffff";
	end

	-- 设置信息
	SelectServer_Text2:Show();
	SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_LoginServerName[index+1], "", strLoginServerStatus);

	--更新推荐�?i
--	local tmpNum = 0
	--if(g_LoginServerCommendableLevel[index+1]>0) then
--		for i = 1,indexForCommendable do
--			if(g_CommendableLoginServerAreaIndex[i] == g_iCurSelArea and g_CommendableLoginServerServerIndex[i] == g_iCurSelLoginServer)then
--				g_iCurComSelLoginServer = i;
--				g_CommendableBnLoginServer[i]:SetCheck(1)
--			else
--				tmpNum = tmpNum+1;
--				g_CommendableBnLoginServer[i]:SetCheck(0)
--			end;
--		end;
--		if tmpNum>=indexForCommendable then
--			g_iCurComSelLoginServer = -1
--		end;
	--else
	--	g_iCurComSelLoginServer = -1;
	--end;

end

function NotFlashAll()
	for i=1,LOGIN_SERVER_COUNT do
		g_BnLoginServer[i]:FlashMe(0);
		g_BnLoginServer[i]:SetCheck(0);
	end
end

function NotFlashAreaBtnAll()
	for i=1,LOGIN_SERVER_AREA_COUNT do
		g_BnArea[i]:FlashMe(0);
		g_BnArea[i]:SetCheck(0);
	end
	for i=1,LOGIN_SERVER_TESTAREA_COUNT do
		g_BntestArea[i]:FlashMe(0);
		g_BntestArea[i]:SetCheck(0);
	end
end

--------------------------------------------------------------------------------------------------------------
--
-- 得到一个login server信息并显示
--
function SelectServer_GetAndShowLoginServer(index)

	g_LoginServerName[index+1]
	,g_LoginServerStatus[index+1]
	,g_LoginServerCommendableLevel[index+1]
	,g_LoginServerIsNew[index+1]
	--added by lichengjie
	,_
	,g_LoginServerPrizeLevel[index+1]
	--end added by lichengjie
	= GameProduceLogin:GetAreaLoginServerInfo(g_iCurSelArea, index);

	ShowServerSelectSub2();
	g_BnLoginServer[index+1]:Enable();
	g_BnLoginServer[index+1]:Show();
	if(g_LoginServerStatus[index+1] == StatMax) then
		g_BnLoginServer[index+1]:Hide();
		return;
	end
	local strName = g_LoginServerName[index+1];

	if(g_LoginServerIsNew[index+1]==1)then
		strName = strName.."(M緄)";
	end;

	if(0 == g_LoginServerStatus[index+1]) then

		strName = "#cff0000#e010101"..strName.."#cffffff";
	elseif(1 == g_LoginServerStatus[index+1]) then

		strName = "#cff8a00#e010101"..strName.."#cffffff";
	elseif(2 == g_LoginServerStatus[index+1]) then

		strName = "#cECE58D#e010101"..strName.."#cffffff";
	elseif(3 == g_LoginServerStatus[index+1]) then

		strName = "#c4CFA4C#e010101"..strName.."#cffffff";
	else

		strName = "#c959595#e010101"..strName.."#cffffff";
		g_BnLoginServer[index+1]:Disable();
	end

	g_BnLoginServer[index+1]:SetText(strName);


---这个地方控制具体的按钮显不显示以及TIPS lichengjie
	--if(g_LoginServerPrizeLevel[index+1]>0) then
	--   g_BnLoginServer[index+1]:SetToolTip(g_ThreePrizeTip[g_LoginServerPrizeLevel[index+1]]);
	--   g_BnLoginServerAnimate[index+1]:SetProperty("Animate", g_ThreePrizeAnimate[g_LoginServerPrizeLevel[index+1]]);--从3个特效里面选择对应的一个，特效数组怎么写？
	--   g_BnLoginServerAnimate[index+1]:SetProperty("Visible", "True");--将特效设为显示
   	--end
--Custom**

end

--------------------------------------------------------------------------------------------------------------
--
-- 隐藏login server 按钮
--
function SelectServer_HideLoginServerBn()

	local index;
	for index = 1, LOGIN_SERVER_COUNT  do
 		g_BnLoginServer[index]:Hide();
		--added by lichengjie 不但要隐藏，而且要将获奖置为0，Tip置为“”，动画置为Kh鬾g
		g_BnLoginServer[index]:SetToolTip("");
		g_BnLoginServerAnimate[index]:SetProperty("Animate","");
		g_BnLoginServerAnimate[index]:SetProperty("Visible","False");
		g_LoginServerPrizeLevel[index] = 0;
		--lichengjie
 	end

end

--------------------------------------------------------------------------------------------------------------
--
-- 隐藏login server 按钮
--
function SelectServer_ShowServerInfo(ServerName, NetStatus, ServerStatus)
	SelectServer_Text2:SetToolTip("");
	SelectServer_Text1:SetText("#e010101M醳 ch�:#cFFFF00"..ServerName);
	SelectServer_Text2:SetText(NetStatus);
	SelectServer_Text3:SetText("#e010101Tr課g th醝:"..ServerStatus);

end

---------------------------------------------------------------------------------------------------------------
--
--  确定选择一个�?i
--
function SelectServer_SelectOk()

	-- 连接到login server
	--童喜，不使用代理,传入�?i供应商

	--选择Last�?i Modify by ChengJiancai 2010/03/10
	if(g_iCurSelArea == -1 or g_iCurSelLoginServer == -1) and g_LastServerState ~= StateStop then
		GameProduceLogin:SelectLoginServer(g_LastArea, g_LastServer, g_iNetProvide);
	else
		GameProduceLogin:SelectLoginServer(g_iCurSelArea, g_iCurSelLoginServer, g_iNetProvide);
	end
	return;
end

---------------------------------------------------------------------------------------------------------------
--
--   自动选择一个�?i
--
function SelectServer_SelectAuto()
	GameProduceLogin:AutoSelLoginServer(g_iNetProvide);
end

---------------------------------------------------------------------------------------------------------------
--
--   退出游戏
--
function SelectServer_Exit()
	QuitApplication("quit");
end

---------------------------------------------------------------------------------------------------------------
-- 鼠标进入推荐�?i
function Commendable_LoginServer_MouseEnter(index)
	--modified by lichengjie
	--if(g_CommendableLoginServerPrizeLevel[index] > 0) then
	--	SelectServer_Info:SetText(g_ThreePrizeTip[g_CommendableLoginServerPrizeLevel[index]]);
	--else
		SelectServer_Info:SetText(g_CommendableLoginServerName[index]..tostring("M醳 ch� ph鴆 v�"));
	--end
	--lichengjie
end

---------------------------------------------------------------------------------------------------------------
--
-- 鼠标进入区域按钮
--
function SelectServer_LoginServer_MouseEnter(index)
	if (g_bSearch == 1 ) then
	--lichengjie 在显示的时候加点判断 如果是获奖�?i，现实3个Tips之一，如果不是还是现实某某�?i
		--if (g_SearchServerPrizeLevel[index+1] > 0) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_SearchServerPrizeLevel[index+1]]);
		--else
			SelectServer_Info:SetText(g_SearchServerName[index+1]..tostring("M醳 ch� ph鴆 v�"));
		--end
	--lichengjie 在显示的时候加点判断
	else
		--lichengjie 在显示的时候加点判断 如果是获奖�?i，现实3个Tips之一，如果不是还是现实某某�?i
		--if (g_LoginServerPrizeLevel[index+1] > 0) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_LoginServerPrizeLevel[index+1]]);
		--else
			SelectServer_Info:SetText(g_LoginServerName[index+1]..tostring("M醳 ch� ph鴆 v�"));
		--end
		--lichengjie 在显示的时候加点判断
	end
end

---------------------------------------------------------------------------------------------------------------
--
-- 鼠标进入区域按钮
--
function SelectServer_LastServer_MouseEnter()
	if(g_LastServerName~="") then
		--SelectServer_Info:SetText(g_LastServerName..tostring("M醳 ch� ph鴆 v�"));
		--added by lichengjie 判断上次获得奖励
		--if( g_LastServerPrizeLevel > 0 ) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_LastServerPrizeLevel]);
		--else
			SelectServer_Info:SetText(g_LastServerName..tostring("M醳 ch� ph鴆 v�"));
		--end
	else
		SelectServer_Info:SetText("");
	end
end
---------------------------------------------------------------------------------------------------------------
--
-- 鼠标离开区域按钮
--
function SelectServer_LastServer_MouseLeave()

	SelectServer_Info:SetText("");
end
---------------------------------------------------------------------------------------------------------------
--
-- 鼠标离开区域按钮
--
function SelectServer_LoginServer_MouseLeave(index)

	SelectServer_Info:SetText("");
end
---------------------------------------------------------------------------------------------------------------
--
-- 鼠标C鬾g tr区域 按钮
--
function SelectServer_TestArea_MouseEnter(index)

	SelectServer_Info:SetText(g_testAreaDis[index+1]);
end


---------------------------------------------------------------------------------------------------------------
--
-- 鼠标离开C鬾g tr区域 按钮
--
function SelectServer_TestArea_MouseLeave(index)

	SelectServer_Info:SetText("");
end;


---------------------------------------------------------------------------------------------------------------
--
-- 鼠标进入login server 按钮
--
function SelectServer_Area_MouseEnter(index)

	SelectServer_Info:SetText(g_AreaDis[index+1]);
end


---------------------------------------------------------------------------------------------------------------
--
-- 鼠标离开login server 按钮
--
function SelectServer_Area_MouseLeave(index)

	SelectServer_Info:SetText("");
end;


function SelectServer_Accept_MouseEnter()

	SelectServer_Info:SetText("Nh v鄌 giao di畁 ch鱪 server 疱ng nh");
end;

function SelectServer_MouseLeave()

	SelectServer_Info:SetText("");
end;

function SelectServer_Automatic_MouseEnter()

	SelectServer_Info:SetText("Gi鷓 c醕 h� ch鱪 server t痶 nh");
end;


function SelectServer_Cancel_MouseEnter()

	SelectServer_Info:SetText("Tho醫 kh鰅 Thi阯 Long B醫 B�");
end;



function SelectServer_MouseEnter_Line(index)

	if(1 == index) then

		SelectServer_Info:SetText("#{DLJM_XML_8}");
		return;
	end

	if(2 == index) then

		SelectServer_Info:SetText("#{DLJM_XML_10}");
		return;
	end

	if(3 == index) then

		SelectServer_Info:SetText("#{DLJM_XML_12}");
		return;
	end

	if(4 == index) then
		SelectServer_Info:SetText("#{DLJM_XML_14}");
		return;
	end

	if(5 == index) then
		SelectServer_Info:SetText("#{DLJM_XML_10}");
		return;
	end
end


function HideTestAreaBn()
	local index;
	--SelectServer2_Commendable_Text:Hide();
	for index = 1, LOGIN_SERVER_TESTAREA_COUNT  do
 		g_BntestArea[index]:Hide();
 	end
end
function HideAreaBn()
	local index;
	for index = 1, LOGIN_SERVER_AREA_COUNT  do
 		g_BnArea[index]:Hide();
 	end
end

--隐藏推荐大区按钮
function HideRecommendAreaBn()
	local index;
	for index = 1, RECOMMEND_AREA_COUNT  do
 		g_RecommendAreaBtn[index]:Hide();
 	end
end

function HideRecommendCNCAreaBn()
	local index;
	for index = 1, RECOMMENDCNC_AREA_COUNT  do
 		g_RecommendCNCAreaBtn[index]:Hide();
 	end
end

function ShowTestAreaBn()
	local index;
	local index1 = 1;
	if g_iCurTestAreaCount<=0 then return; end
	--SelectServer2_Commendable_Text:Show();
	for index = 1,LOGIN_SERVER_TESTAREA_COUNT  do
 		if(index <= g_iCurTestAreaCount) then
			g_BntestArea[index1]:SetText(g_testAreaName[index]);
			g_BntestArea[index1]:SetToolTip(g_testAreaTip[index]);
			g_BntestArea[index1]:Show();
 		end;
		index1 = index1+1
 	end

	--调整M課g internet大区位置
	--local vertCount = math.ceil(g_iCurAreaCount/4);
	--local strPos = string.format("{%f,%f}", 0.0, 335 - vertCount*24);
	--SelectServer2_Subarea_Frame:SetProperty("UnifiedYPosition", strPos);
end

function ShowAreaBn()
	local index;
	local index1 = 1;
	for index = CurPage*PageSize+1, (CurPage+1)*PageSize do

 		if(index <= g_iCurAreaCount) then
			g_BnArea[index1]:SetText(g_AreaName[index]);
			g_BnArea[index1]:SetToolTip(g_AreaTip[index]);
			g_BnArea[index1]:Show();
 		end;
		index1 = index1+1
 	end
end

--显示推荐大区按钮
function ShowRecommendAreaBn()
	local index;
	local index1 = 1;

	for index = 1,RECOMMEND_AREA_COUNT  do
 		if(index <= indexForRecommendArea) then
			g_RecommendAreaBtn[index1]:SetText(g_RecommendAreaName[index]);
			--g_RecommendAreaBtn[index1]:SetToolTip(g_testAreaTip[index]);
			g_RecommendAreaBtn[index1]:Show();
 		end;
		index1 = index1+1
 	end
end
function ShowRecommendCNCAreaBn()
	local index;
	local index1 = 1;

	for index = 1,RECOMMENDCNC_AREA_COUNT  do
 		if(index <= indexForRecommendCNCArea) then
			g_RecommendCNCAreaBtn[index1]:SetText(g_RecommendCNCAreaName[index]);
			--g_RecommendCNCAreaBtn[index1]:SetToolTip(g_testAreaTip[index]);
			g_RecommendCNCAreaBtn[index1]:Show();
 		end;
		index1 = index1+1
 	end
end


-- 双击选择一个�?i。
function SelectServer_ConfirmSelectLine(index)
	-- 选中一个login server
	SelectServer_SelectLoginServer(index,0);

	-- 确认选择一个�?i
	SelectServer_SelectOk();

end;
-- 双击选择一个�?i。
function SelectServer_LastConfirmSelectLine()

	-- 选中一个login server
	SelectServer_SelectLastServer();

	-- 确认选择一个�?i
	SelectServer_SelectOk();

end;
-- 双击选择一个�?i。
function Commendable_ConfirmSelectLine(index)
	-- 选中一个login server
	Commendable_SelectLoginServer(index);

	-- 确认选择一个�?i
	SelectServer_SelectOk();

end;

function SelectServer_PageUp()
	CurPage = CurPage - 1
	ShowPage()
	SelectServer_SelectAreaServer(0);

end

function SelectServer_PageDown()
	CurPage = CurPage + 1
	ShowPage()
	SelectServer_SelectAreaServer(0);
end;

function ShowPage()
	--更新翻页按钮
	--UpdateUpAddDownButton();
	--hide all
	--HideAreaBn();
	--show
	--ShowAreaBn();
end;
function UpdateUpAddDownButton()
	--SelectServer_Subarea_PageUp:Hide();
	--SelectServer_Subarea_PageDown:Hide();
	--if(g_iCurAreaCount-CurPage*PageSize>PageSize)then
	--	SelectServer_Subarea_PageDown:Show()
	--end
	--if(CurPage>0)then
	--	SelectServer_Subarea_PageUp:Show()
	--end
end;

--申请帐号
function SelectServer_AccountReg()
    GameProduceLogin:StartAccountReg()
end

--帐号充值
function SelectServer_AccountChongZhi()
	if(Variable:GetVariable("System_CodePage") == "1258") then
  GameProduceLogin:OpenURL( "http://tlsohu.com" )
  	else
    GameProduceLogin:OpenURL(GetWeblink("WEB_LOGON_MAIN"))
  end
end

function SelectServer_shangyibu_click()
	GameProduceLogin:GoToCampaignDlg();
end

function SelectServer_ReturnAreaSelect_click()
	ShowServerSelectSub1();
	if(g_iCurSelArea ~= -1)then
		if(g_iCurSelArea < g_iCurAreaCount) then
			g_BnArea[g_iCurSelArea+1]:SetCheck(1);
		else
			local testAreaindex = g_iCurSelArea+1-g_iCurAreaCount;
			if(testAreaindex > 0) then
				g_BntestArea[testAreaindex]:SetCheck(1);
			end
		end
	end
	if(indexForRecommendCNCArea>=1)then
		for i = 1,indexForRecommendCNCArea do
			g_RecommendCNCAreaBtn[i]:SetCheck(0);
		end
	end
	ClearServerTextInfo();
end

function ShowServerSelectSub1()
	g_bSearch = 0;
	SelectServer_Frame2_Sub2:Hide();
	SelectServer_Frame2_Sub1:Show();
	SelectServer_fanhuidaqu:Hide();
	SelectServer_shangyibu:Show();
	ShowAreaBn();
	ShowTestAreaBn();
	--ShowRecommendAreaBn();
	--ShowRecommendCNCAreaBn();
	g_iCurSelLoginServer =-1;
	g_iCurSelAreaName = "";
	SelectServer_Server_Lastarea:SetText("Kh鬾g");
	SelectServer_Server_Lastarea:SetCheck(0);
	--GameProduceLogin:SetCurrentServerPage(1);--Custom**
	--SelectServer_Frame2_Sub1:StartFade(0,1);
end

function ShowServerSelectSub2()
	g_bSearch = 0;
	SelectServer_Frame2_Sub1:Hide();
	SelectServer_Frame2_Sub2:Show();
	SelectServer_shangyibu:Hide();
	SelectServer_fanhuidaqu:Show();
	SelectServer_Server_AreaNameShow:SetText(g_iCurSelAreaName);
	SelectServer_Server_Lastarea:SetText(g_iCurSelAreaName);
	SelectServer_Server_Lastarea:SetCheck(1);
	--GameProduceLogin:SetCurrentServerPage(2);--Custom
	--SelectServer_Frame2_Sub2:StartFade(0,1);
end


function SelectServer_CurSelectArea_MouseEnter()
	if(g_iCurSelAreaName~="") then
		SelectServer_Info:SetText(g_iCurSelAreaName);
	else
		SelectServer_Info:SetText("");
	end
end

function SelectServer_Payment_MouseEnter()
	SelectServer_Info:SetText("N誴 cash v鄌 t鄆 kho鋘 c黙 c醕 h�");
end

function SelectServer_RequisitionID_MouseEnter()
	SelectServer_Info:SetText("绣ng k� t鄆 kho鋘 m緄");
end

function SelectServer_ReturnAreaSelect_MouseEnter()
	SelectServer_Info:SetText("Tr� v� giao di畁 ch鱪 khu");
end

function SelectServer_shangyibu_MouseEnter()
	SelectServer_Info:SetText("Tr� v� giao di畁 l竎h tr靚h ho誸 鸬ng");
end

--选择推荐大区
function SelectServer_RecommendArea(index)
	if(index > indexForRecommendArea) then
		return;
	end
	--如果推荐大区名字与普通大区相同
	for i = 1,g_iCurAreaCount do
		if(g_AreaName[i] == g_RecommendAreaName[index]) then
			SelectServer_SelectAreaServer(i-1);
		end
	end
end

function SelectServer_RecommendCNCArea(index)
	if(index > indexForRecommendCNCArea) then
		return;
	end
	--如果推荐大区名字与普通大区相同
	for i = 1,g_iCurTestAreaCount do
		if(g_testAreaName[i] == g_RecommendCNCAreaName[index]) then
			SelectServer_SelectTestAreaServer(i-1);
		end
	end
end

--鼠标进入推荐大区按钮
function SelectServer_RecommendArea_MouseEnter(index)
	for i = 1,g_iCurAreaCount do
		if(g_AreaName[i] == g_RecommendAreaName[index]) then
			SelectServer_Info:SetText(g_AreaDis[i]);
		end
	end
end

function SelectServer_RecommendCNCArea_MouseEnter(index)
	for i = 1,g_iCurTestAreaCount do
		if(g_testAreaName[i] == g_RecommendCNCAreaName[index]) then
			SelectServer_Info:SetText(g_testAreaDis[i]);
		end
	end
end

--搜索按钮
function SelectServer_Search_OK()
	local szSearchName = SelectServer_Server_SearchName:GetText();
	--去除字符串首尾的空格
	szSearchName = string.gsub(szSearchName, "^%s*(.-)%s*$", "%1");
	SelectServer_Server_SearchName:SetText(szSearchName)
	if (szSearchName == "") then
		return;
	end
	local serverCount = GameProduceLogin:SetLoginServerKeyword(szSearchName);
	if (serverCount > LOGIN_SERVER_COUNT) then
		serverCount = LOGIN_SERVER_COUNT;
	end

	SelectServer_Frame2_Sub1:Hide();
	SelectServer_Frame2_Sub2:Show();
	SelectServer_shangyibu:Hide();
	SelectServer_fanhuidaqu:Show();
	SelectServer_Server_Lastarea:SetText("Kh鬾g");
	SelectServer_Server_Lastarea:SetCheck(1);
	GameProduceLogin:SetCurrentServerPage(2);
	--SelectServer_Frame2_Sub2:StartFade(0,1);
	g_bSearch = 1;

	if ( serverCount == 0) then
		SelectServer_Server_AreaNameShow:SetText("Ch遖 t靘 疬㧟 k猼 qu� t呓ng 裯g");
	else
		SelectServer_Server_AreaNameShow:SetText("T靘 k猼 qu�");
	end

	--隐藏所有�?i按钮
	SelectServer_HideLoginServerBn();

	for i = 1,indexForCommendable do
			g_CommendableBnLoginServer[i]:SetCheck(0)
	end;
	NotFlashAll();
	NotFlashAreaBtnAll();

	--显示之前将当前选择全部清空
	g_iCurSelArea = -1;
	g_iCurSelLoginServer = -1;
	g_iCurComSelLoginServer = -1;
	ClearServerTextInfo();

	for i = 1,serverCount do
		g_SearchServerName[i],
		g_SearchServerStatus[i],
		_,
		g_SearchServerIsNew[i],
		_,
		g_SearchServerAreaIndex[i],
		_,
		g_SearchServerIndex[i]
		---lichengjie 搜索得到的�?i获奖等级
		,g_SearchServerPrizeLevel[i]
		---lichengjie
		 = GameProduceLogin:GetKeywordLoginServerInfo(i-1);

		g_BnLoginServer[i]:SetCheck(0);
		g_BnLoginServer[i]:Enable();
		g_BnLoginServer[i]:Show();

		--�?i处于未开放状态
		if(g_SearchServerStatus[i] == StatMax) then
			g_BnLoginServer[i]:Hide();
		end

		local strName = g_SearchServerName[i];
		if(g_SearchServerIsNew[i]==1)then
			strName = strName.."(M緄)";
		end;

		if(0 == g_SearchServerStatus[i]) then
			strName = "#cff0000#e010101"..strName.."#cffffff";
		elseif(1 == g_SearchServerStatus[i]) then
			strName = "#cff8a00#e010101"..strName.."#cffffff";
		elseif(2 == g_SearchServerStatus[i]) then
			strName = "#cECE58D#e010101"..strName.."#cffffff";
		elseif(3 == g_SearchServerStatus[i]) then
			strName = "#c4CFA4C#e010101"..strName.."#cffffff";
		else
			strName = "#c959595#e010101"..strName.."#cffffff";
			g_BnLoginServer[i]:Disable();
		end

		g_BnLoginServer[i]:SetText(strName);

		---这个地方控制具体的按钮显不显示以及TIPS lichengjie
		if(g_SearchServerPrizeLevel[i] > 0) then
		g_BnLoginServer[i]:SetToolTip(g_ThreePrizeTip[g_SearchServerPrizeLevel[i]]);
		g_BnLoginServerAnimate[i]:SetProperty("Animate", g_ThreePrizeAnimate[g_SearchServerPrizeLevel[i]]);--从3个特效里面选择对应的一个，特效数组怎么写？
		g_BnLoginServerAnimate[i]:SetProperty("Visible", "True");--将特效设为显示
		end
		--
	end
end

--清除下方选择�?i信息
function ClearServerTextInfo()
	SelectServer_Text2:SetToolTip("");
	SelectServer_Text1:SetText("");
	SelectServer_Text2:SetText("");
	SelectServer_Text3:SetText("");
	SelectServer_Text2:Hide();
end

--刷新按钮
function SelectServer_FreshPage()
	GameProduceLogin:LoadLaunch();
end

function LoginSelectServer_RecommendNetProvider()
	local loginServerNetProvider;
	--得到当前loginServer的NetProvider
	if(g_iCurSelArea == -1 or g_iCurSelLoginServer == -1) and g_LastServerState ~= StateStop then
		_,_,_,_,loginServerNetProvider = GameProduceLogin:GetAreaLoginServerInfo(g_LastArea, g_LastServer);
	else
		_,_,_,_,loginServerNetProvider = GameProduceLogin:GetAreaLoginServerInfo(g_iCurSelArea, g_iCurSelLoginServer);
	end
end

function SelectServer_LineChanged()
	local str , nIndex = SelectServer_LineSelect:GetCurrentSelect()
	if g_AllNetProvide[nIndex] ~= nil then
		g_iNetProvide = g_AllNetProvide[nIndex]
	end
end