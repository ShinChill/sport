-------------------------------------------------------------------------------------------------------------
--
-- È«¾Ö±äÁ¿
--
local g_LastServer = -1;
local g_LastArea   = -1;
local g_LastServerState = -1;
local g_LastServerName = "";
local g_LastServerPrizeLevel = 0;--ÉÏ´ÎµÇÂ¼Ğ?iµÄ»ñ½±¼¶±ğadded by lichengjie
local CriticalSpeed1 =250
local CriticalSpeed2 =500
local CriticalSpeed3 =1000

local CriticalSpeed =200;
local CurPage = 0
local NetSpeed ={"#e010101T¯c ğµ: #c4CFA4CT¯t","#e010101T¯c ğµ: #c4CFA4CB§n rµn","#e010101T¯c ğµ: Chßa biªt", "#e010101T¯c ğµ mÕng: #cff0000T¡c ngh¨n" }
local PageSize = 24

-- ÇøÓò°´Å¥µÄ¸öÊı
local LOGIN_SERVER_AREA_COUNT = 20;
--Ä¿Ç°ÓĞĞ§µÄÇøÓò°´Å¥¸öÊı£¬ÓÉÓÚ½çÃæ¸Ä¶¯Ì«´ó£¬ÅÂÒÔºóÓĞÈËÓÖ·´»Ú£¬¼ÓÕâ¸ö±äÁ¿£¬Ö÷ÒªÊÇ²»ÏëÈ¥µô·­Ò³´úÂë¡£
local EFFECT_LOGIN_SERVER_AREA_COUNT = 20;
-- Công tr¡cÇøÓò°´Å¥µÄ¸öÊı
local LOGIN_SERVER_TESTAREA_COUNT = 20;
-- ÇøÓò°´Å¥
local g_BnArea = {};

-- Công tr¡cÇøÓò°´Å¥
local g_BntestArea = {};

-- µ±Ç°Ñ¡ÔñµÄÇøÓò
local g_iCurSelArea = 0;
-- login server ¿Í»§¶ËË÷Òı
local g_AreaIndex ={};
-- login server Ãû×Ö
local g_AreaName = {};
-- login server Ãû×Ö
local g_AreaDis = {};
-- testlogin server ¿Í»§¶ËË÷Òı
local g_testAreaIndex ={};
-- login server Ãû×Ö
local g_testAreaName = {};
-- login server Ãû×Ö
local g_testAreaDis = {};
-- µ±Ç°Ñ¡ÔñµÄÇøÓòÃû×Ö
local g_iCurSelAreaName;
-- µ±Ç°Ñ¡ÔñµÄĞ?iÃû×Ö
local g_iCurSelLoginServerName;

--ÇøÓòtips
local g_AreaTip = {};
local g_testAreaTip = {};

-- Ñ¡ÔñµÄÍøÂç½ÓÈëÉÌ

--¼ÇÔØÄ¬ÈÏÍøÂç½ÓÈëÉÌ¡£
local default_iNetProvide	=	1;

local g_idBackSound = -1;

-- Ñ¡Ôñ´úÀí	tongxi ,×¢ÊÍµô
--local g_UseProxy = 0;
-- ¼ÇÔØÍÆ¼öĞ?iµÄ¸öÊı
local indexForCommendable = 1;
------------------------------------------------------------------------------
--
-- login server ĞÅÏ¢
--

-- login server µÄ¸öÊı
--local LOGIN_SERVER_COUNT = 55;    -- modify by zchw 45-->55
local LOGIN_SERVER_COUNT = 85;    -- modify by zchw 45-->55

local COMMENDABLE_LOGIN_SERVER_COUNT = 12;

-- login server °´Å¥
local g_BnLoginServer = {};
local g_BnLoginServerAnimate = {};--Ğ?i¶¯»­°´Å¥ added by lichengjie
-- login server ×´Ì¬
local g_LoginServerStatus = {};
-- login server Ãû×Ö
local g_LoginServerName = {};
-- login server ÍÆ¼öµÈ¼¶
local g_LoginServerCommendableLevel = {};
-- login server ÊÇ·ñĞÂ¿ª
local g_LoginServerIsNew = {};
--added by lichengjie --Ğ?i½±ÀøµÈ¼¶ 0 1 2 3
--0 ´ú±íKhông½±Àø£»1´ú±íÒ»µÈ½±£»2´ú±í2µÈ¼¶ 3´ú±íÈıµÈ½±£¬ÆäËûÊıÖµ±»´¦ÀíÎª0
local g_LoginServerPrizeLevel = {}


local g_ThreePrizeTip =--»ñ½±ÌáÊ¾
{
	"#{WJZH_100910_20}",--Õâ¸öµØ·½½«×ÖµäWJZH_100910_19¸ÄÎªĞÂµÄWJZH_100910_20
	"#{WJZH_100910_18}",
	"#{WJZH_100910_17}",
	"#{CLCZ_101207_03}",
	"#{CLCZ_101207_02}",
	"#{CLCZ_101207_01}",
	"#{KFZB_110628_205}", --È«¹úÕù°ÔÈü×Ü¾öÈüµÚÒ»ÃûËùÔÚĞ?i£¡È«·şÊÚÓè1.2±¶¾­Ñé½±Àø£¬³ÖĞø2ÖÜ¡£7
	"#{KFZB_110628_206}", --È«¹úÕù°ÔÈü×Ü¾öÈüµÚ¶şÃûËùÔÚĞ?i£¡È«·şÊÚÓè1.2±¶¾­Ñé½±Àø£¬³ÖĞø1ÖÜ¡£8
	"#{KFZB_110628_207}", --È«¹úÕù°ÔÈü×Ü¾öÈüµÚÈıÃûËùÔÚĞ?i£¡È«·şÊÚÓè1.2±¶¾­Ñé½±Àø£¬³ÖĞø1ÖÜ¡£9
	"#{KFZB_110628_208}", --È«¹úÕù°ÔÈü´óÇøÈüÇ°ÈıÃûËùÔÚĞ?i£¡È«·şÊÚÓè1.1±¶¾­Ñé½±Àø£¬³ÖĞø1ÖÜ¡£10
	"#{KFZB_110628_251}", --È«¹úÕù°ÔÈü×Ü¾öÈü32Ç¿ËùÔÚĞ?i£¡È«·şÊÚÓè1.2±¶¾­Ñé½±Àø£¬³ÖĞø3Ìì¡£¡£11
}
local g_ThreePrizeAnimate=--»ñ½±¶¯»­ÌØĞ§×ÊÔ´
{
	"Server_3",
	"Server_2",
	"Server_1",
	"Server_3",
	"Server_2",
	"Server_1",
	"Server_3", --7
	"Server_2", --8ÖĞ¼äÁ½ÖÖÇé¿öÌØĞ§Ó¦¸ÃÒ»ÖÂ²Å¶Ô
	"Server_2", --9
	"Server_1", --10
	"Server_1", --11
}
local g_ThreeCommendablePrizeAnimate = --ÍÆ¼öĞ?iÁĞ±íÌØĞ§×ÊÔ´
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
local g_LastServerPrizeAnimate = --ÉÏ´ÎµÇÂ¼Ğ?iÌØĞ§×ÊÔ´
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

-- ÍÆ¼öĞ?i°´Å¥
local g_CommendableBnLoginServer = {};
-- ÍÆ¼öĞ?iÃû×Ö
local g_CommendableLoginServerName = {};
-- ÍÆ¼öĞ?iIndex
local g_CommendableLoginServerServerIndex = {};
-- ÍÆ¼öĞ?iÇøÓòIndex
local g_CommendableLoginServerAreaIndex = {};
-- ÍÆ¼öĞ?iÍÆ¼öµÈ¼¶
local g_CommendableLoginServerCommendableLevel = {};
-- ÍÆ¼öĞ?iÊÇ·ñĞÂ·ş
local g_CommendableLoginServerIsNew = {};
-- ÍÆ¼öĞ?i ×´Ì¬
local g_CommendableLoginServerStatus = {};
-- added by lichengjie ÍÆ¼öĞ?iÌØĞ§°´Å¥Êı×é
local g_CommendableBnLoginServerAnimate = {};
-- added by lichengjie ÍÆ¼öĞ?i »ñ½±Çé¿öÊı×é
local g_CommendableLoginServerPrizeLevel = {};

local g_SelectServer_Str = {
														"#{DLJM_XML_46}",   --µçĞÅ
														"#{DLJM_XML_48}",   --MÕng internet
														"#{DLJM_XML_50}",   --½ÌÓıÍø
														"#{DDFWQ_XML_01}",  --Liên thông 2 (Thông mÕng)
														"#{DLJM_XML_47}",   --Vi­n thông#G(tiªn cØ)
														"#{DLJM_XML_49}",   --Liên thông (MÕng lß¾i thông tin)1#G(tiªn cØ)
														"#{DLJM_XML_51}",   --MÕng giáo døc#G(tiªn cØ)
														"#{DDFWQ_XML_03}",  --Liên thông 2 (Thông mÕng)#G(Tiªn)
														"#{DLJM_XML_36}",	--Tài kHöan Ği®n Tín xin nh¤n tùy ch÷n này ğ¬ có th¬ ch½i game suôn së h½n
														"#{DLJM_XML_37}",	--Tài kHöan Võng Thông xin nh¤n tùy ch÷n này ğ¬ có th¬ ch½i game suôn së
														"#{DLJM_XML_38}",	--Tài kHöan Giáo Døc Võng xin nh¤n tùy ch÷n này ğ¬ có th¬ ch½i game suôn së h½n
														"#{DDFWQ_XML_02}",  --liên thông tài khoän (Thông mÕng), nªu sever møc tiêu kªt n¯i cûng là sever liên thông (Thông mÕng) thì nên dùng phß½ng thÑc liên tiªp.
														"#{DLJM_XML_52}",   --H® th¯ng phát hi®n ğßşc các hÕ có th¬ là ngß¶i sØ døng ği®n tín, tiªn cØ các hÕ sØ døng ği®n tín server ğÕi lı ğ¬ träi nghi®m game ğßşc t¯t h½n.
														"#{DLJM_XML_53}",   --H® th¯ng phát hi®n ğßşc các hÕ có th¬ là ngß¶i sØ døng liên thông (mÕng lß¾i thông tin), tiªn cØ các hÕ sØ døng liên thông (mÕng lß¾i thông tin) server ğÕi lı ğ¬ träi nghi®m game ğßşc t¯t h½n.
														"#{DLJM_XML_54}",   --H® th¯ng phát hi®n ğßşc các hÕ có th¬ là ngß¶i sØ døng mÕng giáo døc, tiªn cØ các hÕ dùng mÕng giáo døc server ğÕi lı ğ¬ träi nghi®m game ğßşc t¯t h½n.
														"#{DLJM_XML_53}",   --H® th¯ng phát hi®n ğßşc các hÕ có th¬ là ngß¶i sØ døng liên thông (mÕng lß¾i thông tin), tiªn cØ các hÕ sØ døng liên thông (mÕng lß¾i thông tin) server ğÕi lı ğ¬ träi nghi®m game ğßşc t¯t h½n.

														}
-------------------------------------------------------------------------------
--
-- ÆäËûĞÅÏ¢
--

-- µ±Ç°Ñ¡ÔñµÄlogin server
local g_iCurSelLoginServer = -1;
-- µ±Ç°Ñ¡ÔñµÄÍÆ¼ölogin server index
local g_iCurComSelLoginServer = -1;

-- ÇøÓòµÄ¸öÊı
local g_iCurAreaCount = 0;
--Công tr¡cÇøÓò¸öÊı
local g_iCurTestAreaCount = 0;

local g_FirstLogin = 1;

--Ğ?i´¦ÓÚÎ¬»¤×´Ì¬
local StateStop = 4;
--²»ÏÔÊ¾×´Ì¬
local StatMax = 10;

local RECOMMEND_AREA_COUNT = 5;
--¼ÇÔØµçĞÅÍÆ¼ö´óÇøÊıÁ¿
local indexForRecommendArea = 0;
--ÍÆ¼öµçĞÅ´óÇø°´Å¥
local g_RecommendAreaBtn = {};
--ÍÆ¼öµçĞÅ´óÇøÃû×Ö
local g_RecommendAreaName = {};
--ÍÆ¼öµçĞÅ´óÇøÍÆ¼öµÈ¼¶
local g_RecommendAreaRecommendLevel = {};

local RECOMMENDCNC_AREA_COUNT = 5;
--¼ÇÔØMÕng internetÍÆ¼ö´óÇøÊıÁ¿
local indexForRecommendCNCArea = 0;
--ÍÆ¼öMÕng internet´óÇø°´Å¥
local g_RecommendCNCAreaBtn = {};
--ÍÆ¼öMÕng internet´óÇøÃû×Ö
local g_RecommendCNCAreaName = {};
--ÍÆ¼öMÕng internet´óÇøÍÆ¼öµÈ¼¶
local g_RecommendCNCAreaRecommendLevel = {};


-- ËÑË÷ÁĞ±íĞ?iIndex
local g_SearchServerIndex = {};
-- ËÑË÷ÁĞ±íĞ?i´óÇøIndex
local g_SearchServerAreaIndex = {};
-- ËÑË÷ÁĞ±íĞ?iÃû³Æ
local g_SearchServerName = {};
-- ËÑË÷ÁĞ±íĞ?iÊÇ·ñĞÂ·ş
local g_SearchServerIsNew = {};
-- ËÑË÷ÁĞ±íĞ?i×´Ì¬
local g_SearchServerStatus = {};
-- ÊÇ·ñÏÔÊ¾ËÑË÷Ò³Ãæ
local g_bSearch = 0;
local g_SearchServerPrizeLevel = {};--ËÑË÷µÄĞ?i»ñ½±µÈ¼¶ added by lichengjie
local g_SearchServerAnimate = {};--ËÑË÷µÄĞ?i»ñ½±ÌØĞ§ added by lichengjie

-- ¿Í»§¶ËºÍĞ?i¶¼ÔÚMÕng internetÄÚÊ±£¬Ëæ¼´ÍÆ¼öÆäÖĞÒ»¸ö(0ÎªMÕng internetÇàµº´úÀí£¬1ÎªÄ¬ÈÏ)
local Sel_TuiJian = 0;

local g_iNetProvide = -1;		-- 0 : µçĞÅ
								-- 1 : MÕng internet
								-- 2 : ÆäËû
								-- 3£ºÄ¬ÈÏ
								-- 4£ºMÕng internetÇàµº

local g_AllNetProvide = {0,1,4,2,3}
-------------------------------------------------------------------------------------------------------------
--
-- º¯ÊıÇø.
--
--

-- ×¢²áonLoadÊÂ¼ş
function LoginSelectServer_PreLoad()
	-- ´ò¿ªÑ¡ÔñĞ?i½çÃæ
	this:RegisterEvent("GAMELOGIN_OPEN_SELECT_SERVER");

	-- Ñ¡ÔñÇøÓò
	this:RegisterEvent("GAMELOGIN_CLOSE_SELECT_SERVER");

	-- ´ò¿ªÑ¡ÔñĞ?i½çÃæ
	this:RegisterEvent("GAMELOGIN_SELECT_AREA");

	-- Ñ¡Ôñlogin
	this:RegisterEvent("GAMELOGIN_SELECT_LOGINSERVER");

	-- Ñ¡ÔñÊÇ·ñÊ¹ÓÃ´úÀí
	this:RegisterEvent("GAMELOGIN_SELECT_USEPROXY");

	-- ×¢²áÑ¡ÔñÒ»¸ölogin serverÊÂ¼ş
	this:RegisterEvent("GAMELOGIN_SELECT_LOGIN_SERVER");

	-- Íæ¼Ò½øÈë³¡¾°
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--ping½á¹û
	this:RegisterEvent("PING_RESAULT");
	--ÉÏ´ÎµÇÂ¼µÄĞ?i
	this:RegisterEvent("GAMELOGIN_LASTSELECT_AREA_AND_SERVER");

	--½øÈëÕËºÅÊäÈë½çÃæ
	this:RegisterEvent("GAMELOGIN_SERVER_SHOW_COUNTINPUT");

	--·µ»ØĞ?iÑ¡ÔñSub1
	this:RegisterEvent("GAMELOGIN_SERVER_SHOW_SUB");

	--¸üĞÂĞ?iÁĞ±íĞÅÏ¢
	this:RegisterEvent("GAMELOGIN_UPDATE_SERVERINFO");

end

function LoginSelectServer_OnLoad()

	-- µÃµ½ÇøÓò°´Å¥
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

	--µÃµ½ÍÆ¼öĞ?iÁĞ±í
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

	--µÃµ½ÍÆ¼öĞ?iÌØĞ§°´Å¥ÁĞ±í added by lichengjie
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
	--µÃµ½ÍÆ¼öĞ?iÌØĞ§°´Å¥ÁĞ±í add by lichengjie
	--µÃµ½ÍÆ¼ö´óÇøÁĞ±í
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
	 	-- Login server °´Å¥

	 	g_CommendableBnLoginServer[i]:SetProperty("CheckMode", "1");
		-- login server Ãû×Ö
		g_CommendableLoginServerName[i] = "";
		--login server index
		g_CommendableLoginServerIndex[i]=-1;
		--added by lichengjie 2010-9-16
		g_CommendableLoginServerPrizeLevel[i] = 0;--³õÊ¼»¯µÄÊ±ºò±íÊ¾¶¼Không½±Àø
		--end lichengjie
	end
	-- µÃµ½Ğ?i°´Å¥
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
	 	-- Login server °´Å¥
	 	g_BnLoginServer[i]:SetProperty("CheckMode", "1");

		-- login server ×´Ì¬
		g_LoginServerStatus[i] = 0;

		-- login server Ãû×Ö
		g_LoginServerName[i] = "";

		g_LoginServerCommendableLevel[i]="";
		--added by lichengjie 2010-9-16
		g_LoginServerPrizeLevel[i] = 0;--³õÊ¼»¯µÄÊ±ºò±íÊ¾¶¼Không½±Àø
		--end lichengjie
	end
	-- Òş²ØËùÓĞÍÆ¼öĞ?i
	HideAllCommendableBn();
	--ÏÈÒş²ØÍÆ¼ö´óÇø°´Å¥
	HideRecommendAreaBn();
	HideRecommendCNCAreaBn();
	-- µÃµ½Ğ?iĞÅÏ¢
	LoginSelectServer_GetServerInfo();

	local strNormalColor = "#cFFF263";
	SelectServer_Help_Text1:SetText(	strNormalColor.."#e010101#cff0000Ğö: Ğ¥y#cffffff" );
	SelectServer_Help_Text2:SetText(	strNormalColor.."#e010101#cECE58DNhÕt: T¯t#cffffff" );
	SelectServer_Help_Text3:SetText(	strNormalColor.."#e010101#c959595Xám: Bäo dßŞng#cffffff" );
	SelectServer_Help_Text4:SetText(	strNormalColor.."#e010101#cff8a00Vàng cam: S¡p ğ¥y#cffffff" );
	SelectServer_Help_Text5:SetText(	strNormalColor.."#e010101#c4CFA4CMàu xanh: Cñc t¯t#cffffff" );


	--Èç¹ûMÕng internetÁ¬MÕng internetÔòÒ»°ëµÄ¼¸ÂÊÍÆ¼öÄ¬ÈÏ£¬Ò»°ëµÄ¼¸ÂÊÍÆ¼öMÕng internet¶ş
	local Num_Rand = math.random(1,10000);
	if(Num_Rand <= 5000) then
		Sel_TuiJian = 0;
	else
		Sel_TuiJian = 1;
	end

	--ÌØĞ§°´Å¥Êı×élichengjie
	-- µÃµ½ÌØĞ§Ğ?i°´Å¥
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

	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_46}" ,1)	--µçĞÅ      0
	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_48}" ,2)	--MÕng internet1		1
	SelectServer_LineSelect:AddTextItem("#{DDFWQ_XML_01}" ,3)	--MÕng internet2		4
	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_50}" ,4)	--MÕng giáo døc	2
	SelectServer_LineSelect:AddTextItem("M£c ğ¸nh" ,5)				--Ä¬ÈÏ		3

	SelectServer_LineSelect:SetCurrentSelect(4)

	-- ´ò¿ª½çÃæ
	SelectServer_Frame:SetProperty("AlwaysOnTop", "True");

	-- ÏÈÒş²ØËùÓĞ°´Å¥¡£
	HideAreaBn();
	-- ÏÈÒş²ØËùÓĞ°´Å¥¡£
	HideTestAreaBn();

end

function HideAllCommendableBn()
	for i = 1,COMMENDABLE_LOGIN_SERVER_COUNT do
		g_CommendableBnLoginServer[i]:Hide();
		--lichengjie ²»µ«ÒªÒş²Ø£¬¶øÇÒÒª½«»ñ½±ÖÃÎª0£¬TipÖÃÎª¡°¡±£¬¶¯»­ÖÃÎªKhông
		g_CommendableBnLoginServer[i]:SetToolTip("");
		g_CommendableBnLoginServerAnimate[i]:SetProperty("Animate","");
		g_CommendableBnLoginServerAnimate[i]:SetProperty("Visible","False");
		g_CommendableLoginServerPrizeLevel[i] = 0;
		--lichengjie
	end;
end
--ÊÇ·ñ×Ô¶¯°ÑÑ¡ÔñµÄĞ?iĞòºÅ±ä³É0£¬·ÀÖ¹.txtÎÄ¼şÓĞ´óµÄ±ä¶¯
local autoZero = 0;
-- OnEvent
function LoginSelectServer_OnEvent(event)

	if( event == "GAMELOGIN_OPEN_SELECT_SERVER" ) then
		this:Show();
		SelectServer_Server_SearchName:SetText("");
		-- ÏÔÊ¾´æÔÚµÄÇøÓò°´Å¥¡£
		--ShowAreaBn();
		--ShowTestAreaBn();
		--ÏÔÊ¾ÉÏÏÂ·­Ò³
		UpdateUpAddDownButton();
		ShowServerSelectSub1();

		-- ²¥·Å±³¾°ÒôÀÖ
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
           -- GameProduceLogin:ShowMessageBox( "    Ä¿Ç°Ö»¿ª·ÅÁËÒ»Ì¨MÕng internetĞ?iÓÃÓÚ²âÊÔ£¬Èç¹ûÄúÊÇµçĞÅµÄÓÃ»§£¬ÇëÔÚĞ?iÑ¡Ôñ½çÃæµÄÓÒ±ßÑ¡Ôñ¡°µçĞÅ¡±½øĞĞµÇÂ¼£¬ÕâÑù²ÅÄÜÊ¹ÓÃ»¥Áª»¥Í¨¹¦ÄÜÒÔ±£Ö¤ÄúµÄÁ¬½ÓËÙ¶È¡£", "OK", "1" );
		    --g_FirstLogin = 0
		--end

		return;
	end


	-- ¹Ø±Õ½çÃæ
	if( event == "GAMELOGIN_CLOSE_SELECT_SERVER") then
		NotFlashAreaBtnAll();
		this:Hide();
		return;
	end

	-- Ñ¡ÔñÒ»¸ölogin server
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

	-- Ñ¡ÔñÇøÓò
	if( event == "GAMELOGIN_SELECT_AREA") then
		--Èç¹û´ÓÕËºÅÊäÈë½çÃæ·µ»Ø´óÇø½çÃæ
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
		--ÍêÈ«Ã»ÓĞÕÒµ½£¬ËµÃ÷ÎÄ¼şÓĞÁË´óµÄ±ä»¯
		CurPage = 0;
		autoZero = 1;
		SelectServer_SelectAreaServer(1 - CurPage*PageSize -1);
		return;
	end;

	-- Ñ¡Ôñlogin
	if( event == "GAMELOGIN_SELECT_LOGINSERVER") then
		--Èç¹û´ÓÕËºÅÊäÈë½çÃæ·µ»Ø´óÇø½çÃæ
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

	-- Ê¹ÓÃ´úÀí
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

	-- ½øÈë³¡¾°£¬Í£Ö¹±³¾°ÒôÀÖ
	if( event == "PLAYER_ENTERING_WORLD") then
		if(g_idBackSound ~= -1) then
			Sound:StopSound(g_idBackSound);
			g_idBackSound = -1;
		end
	end
	--ping½á¹û
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
				SelectServer_Text2:SetToolTip("Kéo dài th¶i gian mÕng:"..num);
			else
				SelectServer_Text2:SetText(NetSpeed[3]);
				SelectServer_Text2:SetToolTip("Kéo dài th¶i gian mÕng:chßa biªt");
			end
		end
	end

	--ÉÏ´ÎµÇÂ¼Ğ?i
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
				--ÅĞ¶ÏÉÏ´ÎµÇÂ¼Ğ?iÊÇ·ñ´¦ÓÚÎ¬»¤×´Ì¬ tt69698
				if (g_LastServerState == StateStop) then
					SelectServer_Server_Last:SetCheck(0);
					SelectServer_Server_Last:Disable();
				else
					SelectServer_Server_Last:Enable();
					--if(g_iCurSelArea == g_LastArea and g_LastServer ==g_iCurSelLoginServer)then
						SelectServer_Server_Last:SetCheck(1);
					--end
				end
				---lichengjie ÅĞ¶ÏÉÏ´Î»ñµÃ½±Àø£¬Èç¹ûÉÏ´Î´¦ÓÚÎ¬»¤×´Ì¬ÊÇ·ñ»¹ÏÔÊ¾ÌØĞ§£¿£¬ÏÖÔÚÊÇÏÔÊ¾
				g_LastServerPrizeLevel = 0--Custom**
				if( g_LastServerPrizeLevel > 0 ) then
					SelectServer_Server_Last_Animate:SetProperty("Animate", g_LastServerPrizeAnimate[g_LastServerPrizeLevel]);
					SelectServer_Server_Last_Animate:SetProperty("Visible", "True");
				else
					SelectServer_Server_Last_Animate:SetProperty("Animate", "");
					SelectServer_Server_Last_Animate:SetProperty("Visible", "False");
				end
				---lichengjie
				--»ñÈ¡Ñ¡Ôñ´óÇø
				SelectServer_Server_AreaNameShow:SetText(g_iCurSelAreaName);
				if g_iCurSelAreaName ~= "" then
					SelectServer_Server_Lastarea:SetText(g_iCurSelAreaName);
				else
					SelectServer_Server_Lastarea:SetText("Không");
				end
				SelectServer_Server_Lastarea:Enable();
			else
				SelectServer_Server_Last:SetText("Không");
				SelectServer_Server_Last:SetCheck(0);
				SelectServer_Server_Last:Disable();
			end
		else
			SelectServer_Server_Last:SetText("Không");
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
		-- Òş²ØËùÓĞÍÆ¼öĞ?i
		HideAllCommendableBn();
		--ÏÈÒş²ØÍÆ¼ö´óÇø°´Å¥
		HideRecommendAreaBn();
		HideRecommendCNCAreaBn();
		-- µÃµ½Ğ?iĞÅÏ¢
		LoginSelectServer_GetServerInfo();
			-- ÏÈÒş²ØËùÓĞ°´Å¥¡£
		HideAreaBn();
		-- ÏÈÒş²ØËùÓĞ°´Å¥¡£
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
-- µÃµ½Ğ?iĞÅÏ¢
--

function LoginSelectServer_GetServerInfo()

	 	local iCurAreaCount = GameProduceLogin:GetServerAreaCount();
	 	local strAreaName = "Không có máy chü phøc vø";
		local iLoginServerCount = -1;
		local ServerName;
		local ServerStatus;
		--ÍÆ¼öµÈ¼¶
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
	 		-- µÃµ½ÇøÓòÃû×Ö.
			local i = string.find(areaname,"-");
			if(i~=nil and i<string.len(areaname)) then
				if(string.sub(areaname,1,i-1)=="MÕng internet" and testindex<LOGIN_SERVER_TESTAREA_COUNT)then
					testindex = testindex +1;
					g_testAreaName[testindex] = string.sub(areaname,i+1);
					g_testAreaDis[testindex] = GameProduceLogin:GetServerAreaDis(index);
					g_testAreaIndex[testindex] = index;
					tuijian = 1;
					g_testAreaTip[testindex] = GameProduceLogin:GetServerAreaDis(index);
				elseif(string.sub(areaname,1,i-1)=="Công tr¡c" and nomalindex< EFFECT_LOGIN_SERVER_AREA_COUNT) then
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
	 		-- ÉèÖÃÃû×Ö.
			iLoginServerCount = GameProduceLogin:GetAreaLoginServerCount(index);
			if(iLoginServerCount > LOGIN_SERVER_COUNT) then
				iLoginServerCount=LOGIN_SERVER_COUNT;
			end
			--µÃµ½ÍÆ¼ö´óÇøÁĞ±í
			--local areaRecommendLevel = GameProduceLogin:GetServerAreaRecommendLevel(index);--Custom**
			local areaRecommendLevel = 0
			if(areaRecommendLevel > 0)  then
				if(i~=nil and i<string.len(areaname)) then
					if(string.sub(areaname,1,i-1)=="MÕng internet" and indexForRecommendCNCArea<RECOMMEND_AREA_COUNT) then
						indexForRecommendCNCArea = indexForRecommendCNCArea+1;
						g_RecommendCNCAreaRecommendLevel[indexForRecommendCNCArea] = areaRecommendLevel;
						g_RecommendCNCAreaName[indexForRecommendCNCArea] = string.sub(areaname,i+1);
					elseif(string.sub(areaname,1,i-1)=="Công tr¡c" and indexForRecommendArea< RECOMMEND_AREA_COUNT) then
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

			--µÃµ½ÍÆ¼öĞ?iÁĞ±í
			if(tuijian==1)then
				for i=0,iLoginServerCount-1 do

					ServerPrizeLevel= 0; --licehngjie¸³ÖµÖ®ºóÉèÎª0

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
						-- ÍÆ¼öĞ?iid
					if(RecommendLevel>0 and indexForCommendable <COMMENDABLE_LOGIN_SERVER_COUNT and ServerStatus ~= StatMax) then
						indexForCommendable = indexForCommendable + 1;
						g_CommendableLoginServerName[indexForCommendable] = ServerName;
						g_CommendableLoginServerServerIndex[indexForCommendable] = i;
						g_CommendableLoginServerAreaIndex[indexForCommendable] = index;
						g_CommendableLoginServerCommendableLevel[indexForCommendable] = RecommendLevel;
						g_CommendableLoginServerIsNew[indexForCommendable] = IsNew;
						g_CommendableLoginServerStatus[indexForCommendable] = ServerStatus;
						--added by lichengjie Èç¹ûÔÚ´Ë´¦ÓÃÈ«¾Ö±äÁ¿¸³ÖµµÄ»°£¬ÌáÊ¾´íÎó¡£¿Í»§¶ËKhông·¨Æô¶¯¡£
						--g_CommendableLoginServerPrizeLevel[indexForCommendable] = ServerPrizeLevel;
						SetValueForComLSPrizeLevel(indexForCommendable,ServerPrizeLevel)

						--end added by lichengjie

					end;


				end
			end;
	 	end
		--°´ĞòÏÔÊ¾ÍÆ¼ö´óÇø
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
		--°´ĞòÏÔÊ¾ÍÆ¼öĞ?i
		if(indexForCommendable>=1)then
			SortCommendableLoginServer();

			local strName="";
			for i = 1,indexForCommendable do
				g_CommendableBnLoginServer[i]:Show();
				local tmpAreaName = GameProduceLogin:GetServerAreaName(g_CommendableLoginServerAreaIndex[i]);
				local _i = string.find(tmpAreaName,"-");
				if(_i~=nil and _i<string.len(tmpAreaName)) then
					if(string.sub(tmpAreaName,1,_i-1)=="Công tr¡c" or string.sub(tmpAreaName,1,_i-1)=="MÕng internet")then
						tmpAreaName = string.sub(tmpAreaName,_i+1);
					end
				end
				strName =tmpAreaName.."-"..g_CommendableLoginServerName[i];
				if(g_CommendableLoginServerIsNew[i]~=0)then
					strName =strName.."(M¾i)";
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
--Ã¿¸öº¯ÊıÀïÃæµÄÈ«¾Ö±äÁ¿ÒıÓÃ´ÎÊı´ïµ½33¸öÊ±ºò£¬»áÌáÊ¾UpValues´íÎó
--ËùÒÔ£¬½«¸øÍÆ¼öĞ?i¸³½±ÀøµÈ¼¶µÄÊ±ºò£¬µ¥¶ÀÌáÈ¡³öÒ»¸öº¯Êı
--ÕâËµÃ÷ÁËÒ»¸öÎÊÌâ£¬SelectServerÒÑ¾­×ã¹»¸´ÔÓÁË£¬ĞèÒªÖØ¹¹Ò»ÏÂ£¬²ğ·Ö³öÒ»Ğ©Ğ¡º¯Êı
--ÁíÍâ£¬Ã¿¸öº¯ÊıÀïÃælocalµÄ¸öÊıÒ²ÓĞÏŞÖÆ¡£Õâ¶¼ÊÇ±àÒëÆ÷×ÔÉíµÄÉè¶¨£¬ËùÒÔÒª×¢ÒâÒ»ÏÂ¡£ÌØ´ËÉùÃ÷
--------------------------------------------------------------------------------------
--added by lichengjie
function SetValueForComLSPrizeLevel(indexForCommendable, prizelevel) --µ¥¶ÀÎª¸³Öµ
	g_CommendableLoginServerPrizeLevel[indexForCommendable] = prizelevel;

end
--------------------------------------------------------------------------------------
--Ã¿¸öº¯ÊıÀïÃæµÄÈ«¾Ö±äÁ¿ÒıÓÃ´ÎÊı´ïµ½33¸öÊ±ºò£¬»áÌáÊ¾UpValues´íÎó
--ËùÒÔ£¬½«¸øÍÆ¼öĞ?i¸³½±ÀøµÈ¼¶µÄÊ±ºò£¬µ¥¶ÀÌáÈ¡³öÒ»¸öº¯Êı
--ÕâËµÃ÷ÁËÒ»¸öÎÊÌâ£¬SelectServerÒÑ¾­×ã¹»¸´ÔÓÁË£¬ĞèÒªÖØ¹¹Ò»ÏÂ£¬²ğ·Ö³öÒ»Ğ©Ğ¡º¯Êı
--ÁíÍâ£¬Ã¿¸öº¯ÊıÀïÃælocalµÄ¸öÊıÒ²ÓĞÏŞÖÆ¡£Õâ¶¼ÊÇ±àÒëÆ÷×ÔÉíµÄÉè¶¨£¬ËùÒÔÒª×¢ÒâÒ»ÏÂ¡£ÌØ´ËÉùÃ÷
--------------------------------------------------------------------------------------
--added by lichengjie
--Custom**
function SetValueForShowComLSPrizeLeve(indexForCommendable) --ÏÔÊ¾Îª¸³Öµ

	--if( g_CommendableLoginServerPrizeLevel[indexForCommendable] > 0) then
	--	g_CommendableBnLoginServer[indexForCommendable]:SetToolTip(g_ThreePrizeTip[g_CommendableLoginServerPrizeLevel[indexForCommendable]]);
	--	g_CommendableBnLoginServerAnimate[indexForCommendable]:SetProperty("Animate",g_ThreeCommendablePrizeAnimate[g_CommendableLoginServerPrizeLevel[indexForCommendable]]);
	--	g_CommendableBnLoginServerAnimate[indexForCommendable]:SetProperty("Visible","True");
	--end
end

--ÅÅĞòÍÆ¼ö´óÇø£¬´ÓĞ¡µ½´ó
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

--ÅÅĞòÁĞ£¬´ÓĞ¡µ½´ó
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
-- Ñ¡ÔñÒ»¸öCông tr¡cÇøÓò
--
function SelectServer_SelectTestAreaServer(index)
	-- ¼ÇÂ¼µ±Ç°Ñ¡ÔñµÄÇøÓòË÷Òı.
	g_iCurSelArea = g_testAreaIndex[index+1];

	-- ÉèÖÃÑ¡ÔñµÄÃû×Ö
	g_iCurSelAreaName = g_testAreaName[index+1];

	-- ÉèÖÃ°´Å¥Ñ¡ÖĞ×´Ì¬.
	g_BntestArea[index+1]:SetCheck(1);

	-- Òş²ØÇøÓò°´Å¥.
	SelectServer_HideLoginServerBn();

	-- µÃµ½login serverµÄĞÅÏ¢
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
-- Ñ¡ÔñÒ»¸öÇøÓò
--
function SelectServer_SelectAreaServer(index)

	-- ¼ÇÂ¼µ±Ç°Ñ¡ÔñµÄÇøÓòË÷Òı.
	g_iCurSelArea = g_AreaIndex[index+CurPage*PageSize+1];

	-- ÉèÖÃÑ¡ÔñµÄÃû×Ö
	g_iCurSelAreaName = g_AreaName[index+CurPage*PageSize+1];

	-- ÉèÖÃ°´Å¥Ñ¡ÖĞ×´Ì¬.
	g_BnArea[index+1]:SetCheck(1);

	-- Òş²ØÇøÓò°´Å¥.
	SelectServer_HideLoginServerBn();

	-- µÃµ½login serverµÄĞÅÏ¢
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
-- ´ÓÍÆ¼öÁĞ±íÀïÑ¡ÔñÒ»¸ölogin server
--
--------------------------------------------------------------------------------------------------------------
function Commendable_SelectLoginServer(index)
	-- ÉèÖÃ°´Å¥Ñ¡ÖĞ×´Ì¬.
	if(g_CommendableBnLoginServer[index]:GetProperty("Disabled")=="True") then
		return;
	end

	g_iCurComSelLoginServer = index;

	g_CommendableBnLoginServer[index]:SetCheck(1);

	--Modify by ChengJianCai 2010/03/04
	g_iCurSelArea = g_CommendableLoginServerAreaIndex[index];
	g_iCurSelLoginServer = g_CommendableLoginServerServerIndex[index];
	g_iCurSelLoginServerName = GameProduceLogin:GetAreaLoginServerInfo(g_iCurSelArea, g_iCurSelLoginServer);
	--´óÇø°´Å¥ÉÁË¸Ğ§¹û
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
	--Í¬Ê±¸üĞÂÏÂÃæµÄĞ?iºÍserver
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
	--µÃµ½ÍÆ¼öĞ?i´óÇøÃû×Ö
	local tmpAreaName = GameProduceLogin:GetServerAreaName(g_CommendableLoginServerAreaIndex[index]);
	local _i = string.find(tmpAreaName,"-");
	if(_i~=nil and _i<string.len(tmpAreaName)) then
		if(string.sub(tmpAreaName,1,_i-1)=="Công tr¡c" or string.sub(tmpAreaName,1,_i-1)=="MÕng internet")then
			tmpAreaName = string.sub(tmpAreaName,_i+1);
		end
	end
	g_iCurSelAreaName = tmpAreaName;

	GameProduceLogin:SetPingServer(g_CommendableLoginServerAreaIndex[index],g_CommendableLoginServerServerIndex[index]);
	local strLoginServerStatus = "???";

	if(0 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cff0000Ğ¥y#cffffff";
	elseif(1 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cff8a00S¡p ğ¥y#cffffff";
	elseif(2 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cECE58DT¯t#cffffff";
	elseif(3 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#c4CFA4CCñc t¯t#cffffff";
	else

		strLoginServerStatus = "#e010101#c959595Bäo dßŞng#cffffff";
	end

	-- ÉèÖÃĞÅÏ¢
	SelectServer_Text2:Show();
	SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_CommendableLoginServerName[index], "", strLoginServerStatus);
end


-- Ñ¡ÔñÒ»¸ölogin server
--
function SelectServer_SelectLoginServer(index,flash)
	if(g_BnLoginServer[index+1]:GetProperty("Disabled")=="True") then
		return;
	end
	--Èç¹û´¦ÓÚËÑË÷ÏÔÊ¾Ò³Ãæ
	if(g_bSearch == 1) then
		g_iCurSelArea = g_SearchServerAreaIndex[index+1];
		g_iCurSelLoginServer = 	g_SearchServerIndex[index+1];
		g_BnLoginServer[index+1]:SetCheck(1);

		GameProduceLogin:SetPingServer(g_iCurSelArea,g_iCurSelLoginServer);
		local strSearchServerStatus = "???";

		if(0 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#cff0000Ğ¥y#cffffff";
		elseif(1 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#c9E5705S¡p ğ¥y#cffffff";
		elseif(2 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#cECE58DT¯t#cffffff";
		elseif(3 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#c4CFA4CCñc t¯t#cffffff";
		else

			strSearchServerStatus = "#e010101#c959595Bäo dßŞng#cffffff";
		end

		local tmpAreaName = GameProduceLogin:GetServerAreaName(g_iCurSelArea);
		local _i = string.find(tmpAreaName,"-");
		if(_i~=nil and _i<string.len(tmpAreaName)) then
			if(string.sub(tmpAreaName,1,_i-1)=="Công tr¡c" or string.sub(tmpAreaName,1,_i-1)=="MÕng internet")then
				tmpAreaName = string.sub(tmpAreaName,_i+1);
			end
		end
		g_iCurSelAreaName = tmpAreaName;

		SelectServer_Server_Lastarea:SetText(g_iCurSelAreaName);
		-- ÉèÖÃĞÅÏ¢
		SelectServer_Text2:Show();
		SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_SearchServerName[index+1], "", strSearchServerStatus);
				--ÍÆ¼öÑ¡Ôñ´úÀíĞ?i
		LoginSelectServer_RecommendNetProvider();
		return;
	end

	GameProduceLogin:SetPingServer(g_iCurSelArea,index);

	--EnableSelect();
	-- ¼ÇÂ¼µ±Ç°Ñ¡ÔñµÄlogin server
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
		--ÍÆ¼öÑ¡Ôñ´úÀíĞ?i
    LoginSelectServer_RecommendNetProvider();

	-- ÉèÖÃ°´Å¥Ñ¡ÖĞ×´Ì¬.
	g_BnLoginServer[index+1]:SetCheck(1);
	local strLoginServerStatus = "???";

	if(0 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#cff0000Ğ¥y#cffffff";
	elseif(1 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#c9E5705S¡p ğ¥y#cffffff";
	elseif(2 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#cECE58DT¯t#cffffff";
	elseif(3 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#c4CFA4CCñc t¯t#cffffff";
	else

		strLoginServerStatus = "#e010101#c959595Bäo dßŞng#cffffff";
	end

	-- ÉèÖÃĞÅÏ¢
	SelectServer_Text2:Show();
	SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_LoginServerName[index+1], "", strLoginServerStatus);

	--¸üĞÂÍÆ¼öĞ?i
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
-- µÃµ½Ò»¸ölogin serverĞÅÏ¢²¢ÏÔÊ¾
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
		strName = strName.."(M¾i)";
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


---Õâ¸öµØ·½¿ØÖÆ¾ßÌåµÄ°´Å¥ÏÔ²»ÏÔÊ¾ÒÔ¼°TIPS lichengjie
	--if(g_LoginServerPrizeLevel[index+1]>0) then
	--   g_BnLoginServer[index+1]:SetToolTip(g_ThreePrizeTip[g_LoginServerPrizeLevel[index+1]]);
	--   g_BnLoginServerAnimate[index+1]:SetProperty("Animate", g_ThreePrizeAnimate[g_LoginServerPrizeLevel[index+1]]);--´Ó3¸öÌØĞ§ÀïÃæÑ¡Ôñ¶ÔÓ¦µÄÒ»¸ö£¬ÌØĞ§Êı×éÔõÃ´Ğ´£¿
	--   g_BnLoginServerAnimate[index+1]:SetProperty("Visible", "True");--½«ÌØĞ§ÉèÎªÏÔÊ¾
   	--end
--Custom**

end

--------------------------------------------------------------------------------------------------------------
--
-- Òş²Ølogin server °´Å¥
--
function SelectServer_HideLoginServerBn()

	local index;
	for index = 1, LOGIN_SERVER_COUNT  do
 		g_BnLoginServer[index]:Hide();
		--added by lichengjie ²»µ«ÒªÒş²Ø£¬¶øÇÒÒª½«»ñ½±ÖÃÎª0£¬TipÖÃÎª¡°¡±£¬¶¯»­ÖÃÎªKhông
		g_BnLoginServer[index]:SetToolTip("");
		g_BnLoginServerAnimate[index]:SetProperty("Animate","");
		g_BnLoginServerAnimate[index]:SetProperty("Visible","False");
		g_LoginServerPrizeLevel[index] = 0;
		--lichengjie
 	end

end

--------------------------------------------------------------------------------------------------------------
--
-- Òş²Ølogin server °´Å¥
--
function SelectServer_ShowServerInfo(ServerName, NetStatus, ServerStatus)
	SelectServer_Text2:SetToolTip("");
	SelectServer_Text1:SetText("#e010101Máy chü:#cFFFF00"..ServerName);
	SelectServer_Text2:SetText(NetStatus);
	SelectServer_Text3:SetText("#e010101TrÕng thái:"..ServerStatus);

end

---------------------------------------------------------------------------------------------------------------
--
--  È·¶¨Ñ¡ÔñÒ»¸öĞ?i
--
function SelectServer_SelectOk()

	-- Á¬½Óµ½login server
	--Í¯Ï²£¬²»Ê¹ÓÃ´úÀí,´«ÈëĞ?i¹©Ó¦ÉÌ

	--Ñ¡ÔñLastĞ?i Modify by ChengJiancai 2010/03/10
	if(g_iCurSelArea == -1 or g_iCurSelLoginServer == -1) and g_LastServerState ~= StateStop then
		GameProduceLogin:SelectLoginServer(g_LastArea, g_LastServer, g_iNetProvide);
	else
		GameProduceLogin:SelectLoginServer(g_iCurSelArea, g_iCurSelLoginServer, g_iNetProvide);
	end
	return;
end

---------------------------------------------------------------------------------------------------------------
--
--   ×Ô¶¯Ñ¡ÔñÒ»¸öĞ?i
--
function SelectServer_SelectAuto()
	GameProduceLogin:AutoSelLoginServer(g_iNetProvide);
end

---------------------------------------------------------------------------------------------------------------
--
--   ÍË³öÓÎÏ·
--
function SelectServer_Exit()
	QuitApplication("quit");
end

---------------------------------------------------------------------------------------------------------------
-- Êó±ê½øÈëÍÆ¼öĞ?i
function Commendable_LoginServer_MouseEnter(index)
	--modified by lichengjie
	--if(g_CommendableLoginServerPrizeLevel[index] > 0) then
	--	SelectServer_Info:SetText(g_ThreePrizeTip[g_CommendableLoginServerPrizeLevel[index]]);
	--else
		SelectServer_Info:SetText(g_CommendableLoginServerName[index]..tostring("Máy chü phøc vø"));
	--end
	--lichengjie
end

---------------------------------------------------------------------------------------------------------------
--
-- Êó±ê½øÈëÇøÓò°´Å¥
--
function SelectServer_LoginServer_MouseEnter(index)
	if (g_bSearch == 1 ) then
	--lichengjie ÔÚÏÔÊ¾µÄÊ±ºò¼ÓµãÅĞ¶Ï Èç¹ûÊÇ»ñ½±Ğ?i£¬ÏÖÊµ3¸öTipsÖ®Ò»£¬Èç¹û²»ÊÇ»¹ÊÇÏÖÊµÄ³Ä³Ğ?i
		--if (g_SearchServerPrizeLevel[index+1] > 0) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_SearchServerPrizeLevel[index+1]]);
		--else
			SelectServer_Info:SetText(g_SearchServerName[index+1]..tostring("Máy chü phøc vø"));
		--end
	--lichengjie ÔÚÏÔÊ¾µÄÊ±ºò¼ÓµãÅĞ¶Ï
	else
		--lichengjie ÔÚÏÔÊ¾µÄÊ±ºò¼ÓµãÅĞ¶Ï Èç¹ûÊÇ»ñ½±Ğ?i£¬ÏÖÊµ3¸öTipsÖ®Ò»£¬Èç¹û²»ÊÇ»¹ÊÇÏÖÊµÄ³Ä³Ğ?i
		--if (g_LoginServerPrizeLevel[index+1] > 0) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_LoginServerPrizeLevel[index+1]]);
		--else
			SelectServer_Info:SetText(g_LoginServerName[index+1]..tostring("Máy chü phøc vø"));
		--end
		--lichengjie ÔÚÏÔÊ¾µÄÊ±ºò¼ÓµãÅĞ¶Ï
	end
end

---------------------------------------------------------------------------------------------------------------
--
-- Êó±ê½øÈëÇøÓò°´Å¥
--
function SelectServer_LastServer_MouseEnter()
	if(g_LastServerName~="") then
		--SelectServer_Info:SetText(g_LastServerName..tostring("Máy chü phøc vø"));
		--added by lichengjie ÅĞ¶ÏÉÏ´Î»ñµÃ½±Àø
		--if( g_LastServerPrizeLevel > 0 ) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_LastServerPrizeLevel]);
		--else
			SelectServer_Info:SetText(g_LastServerName..tostring("Máy chü phøc vø"));
		--end
	else
		SelectServer_Info:SetText("");
	end
end
---------------------------------------------------------------------------------------------------------------
--
-- Êó±êÀë¿ªÇøÓò°´Å¥
--
function SelectServer_LastServer_MouseLeave()

	SelectServer_Info:SetText("");
end
---------------------------------------------------------------------------------------------------------------
--
-- Êó±êÀë¿ªÇøÓò°´Å¥
--
function SelectServer_LoginServer_MouseLeave(index)

	SelectServer_Info:SetText("");
end
---------------------------------------------------------------------------------------------------------------
--
-- Êó±êCông tr¡cÇøÓò °´Å¥
--
function SelectServer_TestArea_MouseEnter(index)

	SelectServer_Info:SetText(g_testAreaDis[index+1]);
end


---------------------------------------------------------------------------------------------------------------
--
-- Êó±êÀë¿ªCông tr¡cÇøÓò °´Å¥
--
function SelectServer_TestArea_MouseLeave(index)

	SelectServer_Info:SetText("");
end;


---------------------------------------------------------------------------------------------------------------
--
-- Êó±ê½øÈëlogin server °´Å¥
--
function SelectServer_Area_MouseEnter(index)

	SelectServer_Info:SetText(g_AreaDis[index+1]);
end


---------------------------------------------------------------------------------------------------------------
--
-- Êó±êÀë¿ªlogin server °´Å¥
--
function SelectServer_Area_MouseLeave(index)

	SelectServer_Info:SetText("");
end;


function SelectServer_Accept_MouseEnter()

	SelectServer_Info:SetText("Nh¤p vào giao di®n ch÷n server ğång nh§p");
end;

function SelectServer_MouseLeave()

	SelectServer_Info:SetText("");
end;

function SelectServer_Automatic_MouseEnter()

	SelectServer_Info:SetText("Giúp các hÕ ch÷n server t¯t nh¤t");
end;


function SelectServer_Cancel_MouseEnter()

	SelectServer_Info:SetText("Thoát khöi Thiên Long Bát Bµ");
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

--Òş²ØÍÆ¼ö´óÇø°´Å¥
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

	--µ÷ÕûMÕng internet´óÇøÎ»ÖÃ
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

--ÏÔÊ¾ÍÆ¼ö´óÇø°´Å¥
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


-- Ë«»÷Ñ¡ÔñÒ»¸öĞ?i¡£
function SelectServer_ConfirmSelectLine(index)
	-- Ñ¡ÖĞÒ»¸ölogin server
	SelectServer_SelectLoginServer(index,0);

	-- È·ÈÏÑ¡ÔñÒ»¸öĞ?i
	SelectServer_SelectOk();

end;
-- Ë«»÷Ñ¡ÔñÒ»¸öĞ?i¡£
function SelectServer_LastConfirmSelectLine()

	-- Ñ¡ÖĞÒ»¸ölogin server
	SelectServer_SelectLastServer();

	-- È·ÈÏÑ¡ÔñÒ»¸öĞ?i
	SelectServer_SelectOk();

end;
-- Ë«»÷Ñ¡ÔñÒ»¸öĞ?i¡£
function Commendable_ConfirmSelectLine(index)
	-- Ñ¡ÖĞÒ»¸ölogin server
	Commendable_SelectLoginServer(index);

	-- È·ÈÏÑ¡ÔñÒ»¸öĞ?i
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
	--¸üĞÂ·­Ò³°´Å¥
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

--ÉêÇëÕÊºÅ
function SelectServer_AccountReg()
    GameProduceLogin:StartAccountReg()
end

--ÕÊºÅ³äÖµ
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
	SelectServer_Server_Lastarea:SetText("Không");
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
	SelectServer_Info:SetText("NÕp cash vào tài khoän cüa các hÕ");
end

function SelectServer_RequisitionID_MouseEnter()
	SelectServer_Info:SetText("Ğång kı tài khoän m¾i");
end

function SelectServer_ReturnAreaSelect_MouseEnter()
	SelectServer_Info:SetText("Tr· v« giao di®n ch÷n khu");
end

function SelectServer_shangyibu_MouseEnter()
	SelectServer_Info:SetText("Tr· v« giao di®n l¸ch trình hoÕt ğµng");
end

--Ñ¡ÔñÍÆ¼ö´óÇø
function SelectServer_RecommendArea(index)
	if(index > indexForRecommendArea) then
		return;
	end
	--Èç¹ûÍÆ¼ö´óÇøÃû×ÖÓëÆÕÍ¨´óÇøÏàÍ¬
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
	--Èç¹ûÍÆ¼ö´óÇøÃû×ÖÓëÆÕÍ¨´óÇøÏàÍ¬
	for i = 1,g_iCurTestAreaCount do
		if(g_testAreaName[i] == g_RecommendCNCAreaName[index]) then
			SelectServer_SelectTestAreaServer(i-1);
		end
	end
end

--Êó±ê½øÈëÍÆ¼ö´óÇø°´Å¥
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

--ËÑË÷°´Å¥
function SelectServer_Search_OK()
	local szSearchName = SelectServer_Server_SearchName:GetText();
	--È¥³ı×Ö·û´®Ê×Î²µÄ¿Õ¸ñ
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
	SelectServer_Server_Lastarea:SetText("Không");
	SelectServer_Server_Lastarea:SetCheck(1);
	GameProduceLogin:SetCurrentServerPage(2);
	--SelectServer_Frame2_Sub2:StartFade(0,1);
	g_bSearch = 1;

	if ( serverCount == 0) then
		SelectServer_Server_AreaNameShow:SetText("Chßa tìm ğßşc kªt quä tß½ng Ñng");
	else
		SelectServer_Server_AreaNameShow:SetText("Tìm kªt quä");
	end

	--Òş²ØËùÓĞĞ?i°´Å¥
	SelectServer_HideLoginServerBn();

	for i = 1,indexForCommendable do
			g_CommendableBnLoginServer[i]:SetCheck(0)
	end;
	NotFlashAll();
	NotFlashAreaBtnAll();

	--ÏÔÊ¾Ö®Ç°½«µ±Ç°Ñ¡ÔñÈ«²¿Çå¿Õ
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
		---lichengjie ËÑË÷µÃµ½µÄĞ?i»ñ½±µÈ¼¶
		,g_SearchServerPrizeLevel[i]
		---lichengjie
		 = GameProduceLogin:GetKeywordLoginServerInfo(i-1);

		g_BnLoginServer[i]:SetCheck(0);
		g_BnLoginServer[i]:Enable();
		g_BnLoginServer[i]:Show();

		--Ğ?i´¦ÓÚÎ´¿ª·Å×´Ì¬
		if(g_SearchServerStatus[i] == StatMax) then
			g_BnLoginServer[i]:Hide();
		end

		local strName = g_SearchServerName[i];
		if(g_SearchServerIsNew[i]==1)then
			strName = strName.."(M¾i)";
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

		---Õâ¸öµØ·½¿ØÖÆ¾ßÌåµÄ°´Å¥ÏÔ²»ÏÔÊ¾ÒÔ¼°TIPS lichengjie
		if(g_SearchServerPrizeLevel[i] > 0) then
		g_BnLoginServer[i]:SetToolTip(g_ThreePrizeTip[g_SearchServerPrizeLevel[i]]);
		g_BnLoginServerAnimate[i]:SetProperty("Animate", g_ThreePrizeAnimate[g_SearchServerPrizeLevel[i]]);--´Ó3¸öÌØĞ§ÀïÃæÑ¡Ôñ¶ÔÓ¦µÄÒ»¸ö£¬ÌØĞ§Êı×éÔõÃ´Ğ´£¿
		g_BnLoginServerAnimate[i]:SetProperty("Visible", "True");--½«ÌØĞ§ÉèÎªÏÔÊ¾
		end
		--
	end
end

--Çå³ıÏÂ·½Ñ¡ÔñĞ?iĞÅÏ¢
function ClearServerTextInfo()
	SelectServer_Text2:SetToolTip("");
	SelectServer_Text1:SetText("");
	SelectServer_Text2:SetText("");
	SelectServer_Text3:SetText("");
	SelectServer_Text2:Hide();
end

--Ë¢ĞÂ°´Å¥
function SelectServer_FreshPage()
	GameProduceLogin:LoadLaunch();
end

function LoginSelectServer_RecommendNetProvider()
	local loginServerNetProvider;
	--µÃµ½µ±Ç°loginServerµÄNetProvider
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