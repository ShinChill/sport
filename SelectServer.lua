-------------------------------------------------------------------------------------------------------------
--
-- ȫ�ֱ���
--
local g_LastServer = -1;
local g_LastArea   = -1;
local g_LastServerState = -1;
local g_LastServerName = "";
local g_LastServerPrizeLevel = 0;--�ϴε�¼�?i�Ļ񽱼���added by lichengjie
local CriticalSpeed1 =250
local CriticalSpeed2 =500
local CriticalSpeed3 =1000

local CriticalSpeed =200;
local CurPage = 0
local NetSpeed ={"#e010101T�c �: #c4CFA4CT�t","#e010101T�c �: #c4CFA4CB�n r�n","#e010101T�c �: Ch�a bi�t", "#e010101T�c � m�ng: #cff0000T�c ngh�n" }
local PageSize = 24

-- ����ť�ĸ���
local LOGIN_SERVER_AREA_COUNT = 20;
--Ŀǰ��Ч������ť���������ڽ���Ķ�̫�����Ժ������ַ��ڣ��������������Ҫ�ǲ���ȥ����ҳ���롣
local EFFECT_LOGIN_SERVER_AREA_COUNT = 20;
-- C�ng tr�c����ť�ĸ���
local LOGIN_SERVER_TESTAREA_COUNT = 20;
-- ����ť
local g_BnArea = {};

-- C�ng tr�c����ť
local g_BntestArea = {};

-- ��ǰѡ�������
local g_iCurSelArea = 0;
-- login server �ͻ�������
local g_AreaIndex ={};
-- login server ����
local g_AreaName = {};
-- login server ����
local g_AreaDis = {};
-- testlogin server �ͻ�������
local g_testAreaIndex ={};
-- login server ����
local g_testAreaName = {};
-- login server ����
local g_testAreaDis = {};
-- ��ǰѡ�����������
local g_iCurSelAreaName;
-- ��ǰѡ����?i����
local g_iCurSelLoginServerName;

--����tips
local g_AreaTip = {};
local g_testAreaTip = {};

-- ѡ������������

--����Ĭ����������̡�
local default_iNetProvide	=	1;

local g_idBackSound = -1;

-- ѡ�����	tongxi ,ע�͵�
--local g_UseProxy = 0;
-- �����Ƽ��?i�ĸ���
local indexForCommendable = 1;
------------------------------------------------------------------------------
--
-- login server ��Ϣ
--

-- login server �ĸ���
--local LOGIN_SERVER_COUNT = 55;    -- modify by zchw 45-->55
local LOGIN_SERVER_COUNT = 85;    -- modify by zchw 45-->55

local COMMENDABLE_LOGIN_SERVER_COUNT = 12;

-- login server ��ť
local g_BnLoginServer = {};
local g_BnLoginServerAnimate = {};--�?i������ť added by lichengjie
-- login server ״̬
local g_LoginServerStatus = {};
-- login server ����
local g_LoginServerName = {};
-- login server �Ƽ��ȼ�
local g_LoginServerCommendableLevel = {};
-- login server �Ƿ��¿�
local g_LoginServerIsNew = {};
--added by lichengjie --�?i�����ȼ� 0 1 2 3
--0 ����Kh�ng������1����һ�Ƚ���2����2�ȼ� 3�������Ƚ���������ֵ������Ϊ0
local g_LoginServerPrizeLevel = {}


local g_ThreePrizeTip =--����ʾ
{
	"#{WJZH_100910_20}",--����ط����ֵ�WJZH_100910_19��Ϊ�µ�WJZH_100910_20
	"#{WJZH_100910_18}",
	"#{WJZH_100910_17}",
	"#{CLCZ_101207_03}",
	"#{CLCZ_101207_02}",
	"#{CLCZ_101207_01}",
	"#{KFZB_110628_205}", --ȫ���������ܾ�����һ�������?i��ȫ������1.2�����齱��������2�ܡ�7
	"#{KFZB_110628_206}", --ȫ���������ܾ����ڶ��������?i��ȫ������1.2�����齱��������1�ܡ�8
	"#{KFZB_110628_207}", --ȫ���������ܾ��������������?i��ȫ������1.2�����齱��������1�ܡ�9
	"#{KFZB_110628_208}", --ȫ��������������ǰ���������?i��ȫ������1.1�����齱��������1�ܡ�10
	"#{KFZB_110628_251}", --ȫ���������ܾ���32ǿ�����?i��ȫ������1.2�����齱��������3�졣��11
}
local g_ThreePrizeAnimate=--�񽱶�����Ч��Դ
{
	"Server_3",
	"Server_2",
	"Server_1",
	"Server_3",
	"Server_2",
	"Server_1",
	"Server_3", --7
	"Server_2", --8�м����������ЧӦ��һ�²Ŷ�
	"Server_2", --9
	"Server_1", --10
	"Server_1", --11
}
local g_ThreeCommendablePrizeAnimate = --�Ƽ��?i�б���Ч��Դ
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
local g_LastServerPrizeAnimate = --�ϴε�¼�?i��Ч��Դ
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

-- �Ƽ��?i��ť
local g_CommendableBnLoginServer = {};
-- �Ƽ��?i����
local g_CommendableLoginServerName = {};
-- �Ƽ��?iIndex
local g_CommendableLoginServerServerIndex = {};
-- �Ƽ��?i����Index
local g_CommendableLoginServerAreaIndex = {};
-- �Ƽ��?i�Ƽ��ȼ�
local g_CommendableLoginServerCommendableLevel = {};
-- �Ƽ��?i�Ƿ��·�
local g_CommendableLoginServerIsNew = {};
-- �Ƽ��?i ״̬
local g_CommendableLoginServerStatus = {};
-- added by lichengjie �Ƽ��?i��Ч��ť����
local g_CommendableBnLoginServerAnimate = {};
-- added by lichengjie �Ƽ��?i ���������
local g_CommendableLoginServerPrizeLevel = {};

local g_SelectServer_Str = {
														"#{DLJM_XML_46}",   --����
														"#{DLJM_XML_48}",   --M�ng internet
														"#{DLJM_XML_50}",   --������
														"#{DDFWQ_XML_01}",  --Li�n th�ng 2 (Th�ng m�ng)
														"#{DLJM_XML_47}",   --Vi�n th�ng#G(ti�n c�)
														"#{DLJM_XML_49}",   --Li�n th�ng (M�ng l߾i th�ng tin)1#G(ti�n c�)
														"#{DLJM_XML_51}",   --M�ng gi�o d�c#G(ti�n c�)
														"#{DDFWQ_XML_03}",  --Li�n th�ng 2 (Th�ng m�ng)#G(Ti�n)
														"#{DLJM_XML_36}",	--T�i kH�an �i�n T�n xin nh�n t�y ch�n n�y � c� th� ch�i game su�n s� h�n
														"#{DLJM_XML_37}",	--T�i kH�an V�ng Th�ng xin nh�n t�y ch�n n�y � c� th� ch�i game su�n s�
														"#{DLJM_XML_38}",	--T�i kH�an Gi�o D�c V�ng xin nh�n t�y ch�n n�y � c� th� ch�i game su�n s� h�n
														"#{DDFWQ_XML_02}",  --li�n th�ng t�i kho�n (Th�ng m�ng), n�u sever m�c ti�u k�t n�i c�ng l� sever li�n th�ng (Th�ng m�ng) th� n�n d�ng ph߽ng th�c li�n ti�p.
														"#{DLJM_XML_52}",   --H� th�ng ph�t hi�n ���c c�c h� c� th� l� ng߶i s� d�ng �i�n t�n, ti�n c� c�c h� s� d�ng �i�n t�n server ��i l� � tr�i nghi�m game ���c t�t h�n.
														"#{DLJM_XML_53}",   --H� th�ng ph�t hi�n ���c c�c h� c� th� l� ng߶i s� d�ng li�n th�ng (m�ng l߾i th�ng tin), ti�n c� c�c h� s� d�ng li�n th�ng (m�ng l߾i th�ng tin) server ��i l� � tr�i nghi�m game ���c t�t h�n.
														"#{DLJM_XML_54}",   --H� th�ng ph�t hi�n ���c c�c h� c� th� l� ng߶i s� d�ng m�ng gi�o d�c, ti�n c� c�c h� d�ng m�ng gi�o d�c server ��i l� � tr�i nghi�m game ���c t�t h�n.
														"#{DLJM_XML_53}",   --H� th�ng ph�t hi�n ���c c�c h� c� th� l� ng߶i s� d�ng li�n th�ng (m�ng l߾i th�ng tin), ti�n c� c�c h� s� d�ng li�n th�ng (m�ng l߾i th�ng tin) server ��i l� � tr�i nghi�m game ���c t�t h�n.

														}
-------------------------------------------------------------------------------
--
-- ������Ϣ
--

-- ��ǰѡ���login server
local g_iCurSelLoginServer = -1;
-- ��ǰѡ����Ƽ�login server index
local g_iCurComSelLoginServer = -1;

-- ����ĸ���
local g_iCurAreaCount = 0;
--C�ng tr�c�������
local g_iCurTestAreaCount = 0;

local g_FirstLogin = 1;

--�?i����ά��״̬
local StateStop = 4;
--����ʾ״̬
local StatMax = 10;

local RECOMMEND_AREA_COUNT = 5;
--���ص����Ƽ���������
local indexForRecommendArea = 0;
--�Ƽ����Ŵ�����ť
local g_RecommendAreaBtn = {};
--�Ƽ����Ŵ�������
local g_RecommendAreaName = {};
--�Ƽ����Ŵ����Ƽ��ȼ�
local g_RecommendAreaRecommendLevel = {};

local RECOMMENDCNC_AREA_COUNT = 5;
--����M�ng internet�Ƽ���������
local indexForRecommendCNCArea = 0;
--�Ƽ�M�ng internet������ť
local g_RecommendCNCAreaBtn = {};
--�Ƽ�M�ng internet��������
local g_RecommendCNCAreaName = {};
--�Ƽ�M�ng internet�����Ƽ��ȼ�
local g_RecommendCNCAreaRecommendLevel = {};


-- �����б��?iIndex
local g_SearchServerIndex = {};
-- �����б��?i����Index
local g_SearchServerAreaIndex = {};
-- �����б��?i����
local g_SearchServerName = {};
-- �����б��?i�Ƿ��·�
local g_SearchServerIsNew = {};
-- �����б��?i״̬
local g_SearchServerStatus = {};
-- �Ƿ���ʾ����ҳ��
local g_bSearch = 0;
local g_SearchServerPrizeLevel = {};--�������?i�񽱵ȼ� added by lichengjie
local g_SearchServerAnimate = {};--�������?i����Ч added by lichengjie

-- �ͻ��˺��?i����M�ng internet��ʱ���漴�Ƽ�����һ��(0ΪM�ng internet�ൺ����1ΪĬ��)
local Sel_TuiJian = 0;

local g_iNetProvide = -1;		-- 0 : ����
								-- 1 : M�ng internet
								-- 2 : ����
								-- 3��Ĭ��
								-- 4��M�ng internet�ൺ

local g_AllNetProvide = {0,1,4,2,3}
-------------------------------------------------------------------------------------------------------------
--
-- ������.
--
--

-- ע��onLoad�¼�
function LoginSelectServer_PreLoad()
	-- ��ѡ���?i����
	this:RegisterEvent("GAMELOGIN_OPEN_SELECT_SERVER");

	-- ѡ������
	this:RegisterEvent("GAMELOGIN_CLOSE_SELECT_SERVER");

	-- ��ѡ���?i����
	this:RegisterEvent("GAMELOGIN_SELECT_AREA");

	-- ѡ��login
	this:RegisterEvent("GAMELOGIN_SELECT_LOGINSERVER");

	-- ѡ���Ƿ�ʹ�ô���
	this:RegisterEvent("GAMELOGIN_SELECT_USEPROXY");

	-- ע��ѡ��һ��login server�¼�
	this:RegisterEvent("GAMELOGIN_SELECT_LOGIN_SERVER");

	-- ��ҽ��볡��
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--ping���
	this:RegisterEvent("PING_RESAULT");
	--�ϴε�¼���?i
	this:RegisterEvent("GAMELOGIN_LASTSELECT_AREA_AND_SERVER");

	--�����˺��������
	this:RegisterEvent("GAMELOGIN_SERVER_SHOW_COUNTINPUT");

	--�����?iѡ��Sub1
	this:RegisterEvent("GAMELOGIN_SERVER_SHOW_SUB");

	--�����?i�б���Ϣ
	this:RegisterEvent("GAMELOGIN_UPDATE_SERVERINFO");

end

function LoginSelectServer_OnLoad()

	-- �õ�����ť
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

	--�õ��Ƽ��?i�б�
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

	--�õ��Ƽ��?i��Ч��ť�б� added by lichengjie
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
	--�õ��Ƽ��?i��Ч��ť�б� add by lichengjie
	--�õ��Ƽ������б�
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
	 	-- Login server ��ť

	 	g_CommendableBnLoginServer[i]:SetProperty("CheckMode", "1");
		-- login server ����
		g_CommendableLoginServerName[i] = "";
		--login server index
		g_CommendableLoginServerIndex[i]=-1;
		--added by lichengjie 2010-9-16
		g_CommendableLoginServerPrizeLevel[i] = 0;--��ʼ����ʱ���ʾ��Kh�ng����
		--end lichengjie
	end
	-- �õ��?i��ť
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
	 	-- Login server ��ť
	 	g_BnLoginServer[i]:SetProperty("CheckMode", "1");

		-- login server ״̬
		g_LoginServerStatus[i] = 0;

		-- login server ����
		g_LoginServerName[i] = "";

		g_LoginServerCommendableLevel[i]="";
		--added by lichengjie 2010-9-16
		g_LoginServerPrizeLevel[i] = 0;--��ʼ����ʱ���ʾ��Kh�ng����
		--end lichengjie
	end
	-- ���������Ƽ��?i
	HideAllCommendableBn();
	--�������Ƽ�������ť
	HideRecommendAreaBn();
	HideRecommendCNCAreaBn();
	-- �õ��?i��Ϣ
	LoginSelectServer_GetServerInfo();

	local strNormalColor = "#cFFF263";
	SelectServer_Help_Text1:SetText(	strNormalColor.."#e010101#cff0000��: Хy#cffffff" );
	SelectServer_Help_Text2:SetText(	strNormalColor.."#e010101#cECE58DNh�t: T�t#cffffff" );
	SelectServer_Help_Text3:SetText(	strNormalColor.."#e010101#c959595X�m: B�o d��ng#cffffff" );
	SelectServer_Help_Text4:SetText(	strNormalColor.."#e010101#cff8a00V�ng cam: S�p �y#cffffff" );
	SelectServer_Help_Text5:SetText(	strNormalColor.."#e010101#c4CFA4CM�u xanh: C�c t�t#cffffff" );


	--���M�ng internet��M�ng internet��һ��ļ����Ƽ�Ĭ�ϣ�һ��ļ����Ƽ�M�ng internet��
	local Num_Rand = math.random(1,10000);
	if(Num_Rand <= 5000) then
		Sel_TuiJian = 0;
	else
		Sel_TuiJian = 1;
	end

	--��Ч��ť����lichengjie
	-- �õ���Ч�?i��ť
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

	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_46}" ,1)	--����      0
	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_48}" ,2)	--M�ng internet1		1
	SelectServer_LineSelect:AddTextItem("#{DDFWQ_XML_01}" ,3)	--M�ng internet2		4
	SelectServer_LineSelect:AddTextItem("#{DLJM_XML_50}" ,4)	--M�ng gi�o d�c	2
	SelectServer_LineSelect:AddTextItem("M�c �nh" ,5)				--Ĭ��		3

	SelectServer_LineSelect:SetCurrentSelect(4)

	-- �򿪽���
	SelectServer_Frame:SetProperty("AlwaysOnTop", "True");

	-- ���������а�ť��
	HideAreaBn();
	-- ���������а�ť��
	HideTestAreaBn();

end

function HideAllCommendableBn()
	for i = 1,COMMENDABLE_LOGIN_SERVER_COUNT do
		g_CommendableBnLoginServer[i]:Hide();
		--lichengjie ����Ҫ���أ�����Ҫ������Ϊ0��Tip��Ϊ������������ΪKh�ng
		g_CommendableBnLoginServer[i]:SetToolTip("");
		g_CommendableBnLoginServerAnimate[i]:SetProperty("Animate","");
		g_CommendableBnLoginServerAnimate[i]:SetProperty("Visible","False");
		g_CommendableLoginServerPrizeLevel[i] = 0;
		--lichengjie
	end;
end
--�Ƿ��Զ���ѡ����?i��ű��0����ֹ.txt�ļ��д�ı䶯
local autoZero = 0;
-- OnEvent
function LoginSelectServer_OnEvent(event)

	if( event == "GAMELOGIN_OPEN_SELECT_SERVER" ) then
		this:Show();
		SelectServer_Server_SearchName:SetText("");
		-- ��ʾ���ڵ�����ť��
		--ShowAreaBn();
		--ShowTestAreaBn();
		--��ʾ���·�ҳ
		UpdateUpAddDownButton();
		ShowServerSelectSub1();

		-- ���ű�������
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
           -- GameProduceLogin:ShowMessageBox( "    Ŀǰֻ������һ̨M�ng internet�?i���ڲ��ԣ�������ǵ��ŵ��û��������?iѡ�������ұ�ѡ�񡰵��š����е�¼����������ʹ�û�����ͨ�����Ա�֤���������ٶȡ�", "OK", "1" );
		    --g_FirstLogin = 0
		--end

		return;
	end


	-- �رս���
	if( event == "GAMELOGIN_CLOSE_SELECT_SERVER") then
		NotFlashAreaBtnAll();
		this:Hide();
		return;
	end

	-- ѡ��һ��login server
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

	-- ѡ������
	if( event == "GAMELOGIN_SELECT_AREA") then
		--������˺�������淵�ش�������
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
		--��ȫû���ҵ���˵���ļ����˴�ı仯
		CurPage = 0;
		autoZero = 1;
		SelectServer_SelectAreaServer(1 - CurPage*PageSize -1);
		return;
	end;

	-- ѡ��login
	if( event == "GAMELOGIN_SELECT_LOGINSERVER") then
		--������˺�������淵�ش�������
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

	-- ʹ�ô���
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

	-- ���볡����ֹͣ��������
	if( event == "PLAYER_ENTERING_WORLD") then
		if(g_idBackSound ~= -1) then
			Sound:StopSound(g_idBackSound);
			g_idBackSound = -1;
		end
	end
	--ping���
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
				SelectServer_Text2:SetToolTip("K�o d�i th�i gian m�ng:"..num);
			else
				SelectServer_Text2:SetText(NetSpeed[3]);
				SelectServer_Text2:SetToolTip("K�o d�i th�i gian m�ng:ch�a bi�t");
			end
		end
	end

	--�ϴε�¼�?i
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
				--�ж��ϴε�¼�?i�Ƿ���ά��״̬ tt69698
				if (g_LastServerState == StateStop) then
					SelectServer_Server_Last:SetCheck(0);
					SelectServer_Server_Last:Disable();
				else
					SelectServer_Server_Last:Enable();
					--if(g_iCurSelArea == g_LastArea and g_LastServer ==g_iCurSelLoginServer)then
						SelectServer_Server_Last:SetCheck(1);
					--end
				end
				---lichengjie �ж��ϴλ�ý���������ϴδ���ά��״̬�Ƿ���ʾ��Ч������������ʾ
				g_LastServerPrizeLevel = 0--Custom**
				if( g_LastServerPrizeLevel > 0 ) then
					SelectServer_Server_Last_Animate:SetProperty("Animate", g_LastServerPrizeAnimate[g_LastServerPrizeLevel]);
					SelectServer_Server_Last_Animate:SetProperty("Visible", "True");
				else
					SelectServer_Server_Last_Animate:SetProperty("Animate", "");
					SelectServer_Server_Last_Animate:SetProperty("Visible", "False");
				end
				---lichengjie
				--��ȡѡ�����
				SelectServer_Server_AreaNameShow:SetText(g_iCurSelAreaName);
				if g_iCurSelAreaName ~= "" then
					SelectServer_Server_Lastarea:SetText(g_iCurSelAreaName);
				else
					SelectServer_Server_Lastarea:SetText("Kh�ng");
				end
				SelectServer_Server_Lastarea:Enable();
			else
				SelectServer_Server_Last:SetText("Kh�ng");
				SelectServer_Server_Last:SetCheck(0);
				SelectServer_Server_Last:Disable();
			end
		else
			SelectServer_Server_Last:SetText("Kh�ng");
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
		-- ���������Ƽ��?i
		HideAllCommendableBn();
		--�������Ƽ�������ť
		HideRecommendAreaBn();
		HideRecommendCNCAreaBn();
		-- �õ��?i��Ϣ
		LoginSelectServer_GetServerInfo();
			-- ���������а�ť��
		HideAreaBn();
		-- ���������а�ť��
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
-- �õ��?i��Ϣ
--

function LoginSelectServer_GetServerInfo()

	 	local iCurAreaCount = GameProduceLogin:GetServerAreaCount();
	 	local strAreaName = "Kh�ng c� m�y ch� ph�c v�";
		local iLoginServerCount = -1;
		local ServerName;
		local ServerStatus;
		--�Ƽ��ȼ�
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
	 		-- �õ���������.
			local i = string.find(areaname,"-");
			if(i~=nil and i<string.len(areaname)) then
				if(string.sub(areaname,1,i-1)=="M�ng internet" and testindex<LOGIN_SERVER_TESTAREA_COUNT)then
					testindex = testindex +1;
					g_testAreaName[testindex] = string.sub(areaname,i+1);
					g_testAreaDis[testindex] = GameProduceLogin:GetServerAreaDis(index);
					g_testAreaIndex[testindex] = index;
					tuijian = 1;
					g_testAreaTip[testindex] = GameProduceLogin:GetServerAreaDis(index);
				elseif(string.sub(areaname,1,i-1)=="C�ng tr�c" and nomalindex< EFFECT_LOGIN_SERVER_AREA_COUNT) then
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
	 		-- ��������.
			iLoginServerCount = GameProduceLogin:GetAreaLoginServerCount(index);
			if(iLoginServerCount > LOGIN_SERVER_COUNT) then
				iLoginServerCount=LOGIN_SERVER_COUNT;
			end
			--�õ��Ƽ������б�
			--local areaRecommendLevel = GameProduceLogin:GetServerAreaRecommendLevel(index);--Custom**
			local areaRecommendLevel = 0
			if(areaRecommendLevel > 0)  then
				if(i~=nil and i<string.len(areaname)) then
					if(string.sub(areaname,1,i-1)=="M�ng internet" and indexForRecommendCNCArea<RECOMMEND_AREA_COUNT) then
						indexForRecommendCNCArea = indexForRecommendCNCArea+1;
						g_RecommendCNCAreaRecommendLevel[indexForRecommendCNCArea] = areaRecommendLevel;
						g_RecommendCNCAreaName[indexForRecommendCNCArea] = string.sub(areaname,i+1);
					elseif(string.sub(areaname,1,i-1)=="C�ng tr�c" and indexForRecommendArea< RECOMMEND_AREA_COUNT) then
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

			--�õ��Ƽ��?i�б�
			if(tuijian==1)then
				for i=0,iLoginServerCount-1 do

					ServerPrizeLevel= 0; --licehngjie��ֵ֮����Ϊ0

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
						-- �Ƽ��?iid
					if(RecommendLevel>0 and indexForCommendable <COMMENDABLE_LOGIN_SERVER_COUNT and ServerStatus ~= StatMax) then
						indexForCommendable = indexForCommendable + 1;
						g_CommendableLoginServerName[indexForCommendable] = ServerName;
						g_CommendableLoginServerServerIndex[indexForCommendable] = i;
						g_CommendableLoginServerAreaIndex[indexForCommendable] = index;
						g_CommendableLoginServerCommendableLevel[indexForCommendable] = RecommendLevel;
						g_CommendableLoginServerIsNew[indexForCommendable] = IsNew;
						g_CommendableLoginServerStatus[indexForCommendable] = ServerStatus;
						--added by lichengjie ����ڴ˴���ȫ�ֱ�����ֵ�Ļ�����ʾ���󡣿ͻ���Kh�ng��������
						--g_CommendableLoginServerPrizeLevel[indexForCommendable] = ServerPrizeLevel;
						SetValueForComLSPrizeLevel(indexForCommendable,ServerPrizeLevel)

						--end added by lichengjie

					end;


				end
			end;
	 	end
		--������ʾ�Ƽ�����
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
		--������ʾ�Ƽ��?i
		if(indexForCommendable>=1)then
			SortCommendableLoginServer();

			local strName="";
			for i = 1,indexForCommendable do
				g_CommendableBnLoginServer[i]:Show();
				local tmpAreaName = GameProduceLogin:GetServerAreaName(g_CommendableLoginServerAreaIndex[i]);
				local _i = string.find(tmpAreaName,"-");
				if(_i~=nil and _i<string.len(tmpAreaName)) then
					if(string.sub(tmpAreaName,1,_i-1)=="C�ng tr�c" or string.sub(tmpAreaName,1,_i-1)=="M�ng internet")then
						tmpAreaName = string.sub(tmpAreaName,_i+1);
					end
				end
				strName =tmpAreaName.."-"..g_CommendableLoginServerName[i];
				if(g_CommendableLoginServerIsNew[i]~=0)then
					strName =strName.."(M�i)";
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
--ÿ�����������ȫ�ֱ������ô����ﵽ33��ʱ�򣬻���ʾUpValues����
--���ԣ������Ƽ��?i�������ȼ���ʱ�򣬵�����ȡ��һ������
--��˵����һ�����⣬SelectServer�Ѿ��㹻�����ˣ���Ҫ�ع�һ�£���ֳ�һЩС����
--���⣬ÿ����������local�ĸ���Ҳ�����ơ��ⶼ�Ǳ�����������趨������Ҫע��һ�¡��ش�����
--------------------------------------------------------------------------------------
--added by lichengjie
function SetValueForComLSPrizeLevel(indexForCommendable, prizelevel) --����Ϊ��ֵ
	g_CommendableLoginServerPrizeLevel[indexForCommendable] = prizelevel;

end
--------------------------------------------------------------------------------------
--ÿ�����������ȫ�ֱ������ô����ﵽ33��ʱ�򣬻���ʾUpValues����
--���ԣ������Ƽ��?i�������ȼ���ʱ�򣬵�����ȡ��һ������
--��˵����һ�����⣬SelectServer�Ѿ��㹻�����ˣ���Ҫ�ع�һ�£���ֳ�һЩС����
--���⣬ÿ����������local�ĸ���Ҳ�����ơ��ⶼ�Ǳ�����������趨������Ҫע��һ�¡��ش�����
--------------------------------------------------------------------------------------
--added by lichengjie
--Custom**
function SetValueForShowComLSPrizeLeve(indexForCommendable) --��ʾΪ��ֵ

	--if( g_CommendableLoginServerPrizeLevel[indexForCommendable] > 0) then
	--	g_CommendableBnLoginServer[indexForCommendable]:SetToolTip(g_ThreePrizeTip[g_CommendableLoginServerPrizeLevel[indexForCommendable]]);
	--	g_CommendableBnLoginServerAnimate[indexForCommendable]:SetProperty("Animate",g_ThreeCommendablePrizeAnimate[g_CommendableLoginServerPrizeLevel[indexForCommendable]]);
	--	g_CommendableBnLoginServerAnimate[indexForCommendable]:SetProperty("Visible","True");
	--end
end

--�����Ƽ���������С����
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

--�����У���С����
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
-- ѡ��һ��C�ng tr�c����
--
function SelectServer_SelectTestAreaServer(index)
	-- ��¼��ǰѡ�����������.
	g_iCurSelArea = g_testAreaIndex[index+1];

	-- ����ѡ�������
	g_iCurSelAreaName = g_testAreaName[index+1];

	-- ���ð�ťѡ��״̬.
	g_BntestArea[index+1]:SetCheck(1);

	-- ��������ť.
	SelectServer_HideLoginServerBn();

	-- �õ�login server����Ϣ
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
-- ѡ��һ������
--
function SelectServer_SelectAreaServer(index)

	-- ��¼��ǰѡ�����������.
	g_iCurSelArea = g_AreaIndex[index+CurPage*PageSize+1];

	-- ����ѡ�������
	g_iCurSelAreaName = g_AreaName[index+CurPage*PageSize+1];

	-- ���ð�ťѡ��״̬.
	g_BnArea[index+1]:SetCheck(1);

	-- ��������ť.
	SelectServer_HideLoginServerBn();

	-- �õ�login server����Ϣ
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
-- ���Ƽ��б���ѡ��һ��login server
--
--------------------------------------------------------------------------------------------------------------
function Commendable_SelectLoginServer(index)
	-- ���ð�ťѡ��״̬.
	if(g_CommendableBnLoginServer[index]:GetProperty("Disabled")=="True") then
		return;
	end

	g_iCurComSelLoginServer = index;

	g_CommendableBnLoginServer[index]:SetCheck(1);

	--Modify by ChengJianCai 2010/03/04
	g_iCurSelArea = g_CommendableLoginServerAreaIndex[index];
	g_iCurSelLoginServer = g_CommendableLoginServerServerIndex[index];
	g_iCurSelLoginServerName = GameProduceLogin:GetAreaLoginServerInfo(g_iCurSelArea, g_iCurSelLoginServer);
	--������ť��˸Ч��
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
	--ͬʱ����������?i��server
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
	--�õ��Ƽ��?i��������
	local tmpAreaName = GameProduceLogin:GetServerAreaName(g_CommendableLoginServerAreaIndex[index]);
	local _i = string.find(tmpAreaName,"-");
	if(_i~=nil and _i<string.len(tmpAreaName)) then
		if(string.sub(tmpAreaName,1,_i-1)=="C�ng tr�c" or string.sub(tmpAreaName,1,_i-1)=="M�ng internet")then
			tmpAreaName = string.sub(tmpAreaName,_i+1);
		end
	end
	g_iCurSelAreaName = tmpAreaName;

	GameProduceLogin:SetPingServer(g_CommendableLoginServerAreaIndex[index],g_CommendableLoginServerServerIndex[index]);
	local strLoginServerStatus = "???";

	if(0 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cff0000Хy#cffffff";
	elseif(1 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cff8a00S�p �y#cffffff";
	elseif(2 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#cECE58DT�t#cffffff";
	elseif(3 == g_CommendableLoginServerStatus[index]) then

		strLoginServerStatus = "#e010101#c4CFA4CC�c t�t#cffffff";
	else

		strLoginServerStatus = "#e010101#c959595B�o d��ng#cffffff";
	end

	-- ������Ϣ
	SelectServer_Text2:Show();
	SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_CommendableLoginServerName[index], "", strLoginServerStatus);
end


-- ѡ��һ��login server
--
function SelectServer_SelectLoginServer(index,flash)
	if(g_BnLoginServer[index+1]:GetProperty("Disabled")=="True") then
		return;
	end
	--�������������ʾҳ��
	if(g_bSearch == 1) then
		g_iCurSelArea = g_SearchServerAreaIndex[index+1];
		g_iCurSelLoginServer = 	g_SearchServerIndex[index+1];
		g_BnLoginServer[index+1]:SetCheck(1);

		GameProduceLogin:SetPingServer(g_iCurSelArea,g_iCurSelLoginServer);
		local strSearchServerStatus = "???";

		if(0 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#cff0000Хy#cffffff";
		elseif(1 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#c9E5705S�p �y#cffffff";
		elseif(2 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#cECE58DT�t#cffffff";
		elseif(3 == g_SearchServerStatus[index+1]) then

			strSearchServerStatus = "#e010101#c4CFA4CC�c t�t#cffffff";
		else

			strSearchServerStatus = "#e010101#c959595B�o d��ng#cffffff";
		end

		local tmpAreaName = GameProduceLogin:GetServerAreaName(g_iCurSelArea);
		local _i = string.find(tmpAreaName,"-");
		if(_i~=nil and _i<string.len(tmpAreaName)) then
			if(string.sub(tmpAreaName,1,_i-1)=="C�ng tr�c" or string.sub(tmpAreaName,1,_i-1)=="M�ng internet")then
				tmpAreaName = string.sub(tmpAreaName,_i+1);
			end
		end
		g_iCurSelAreaName = tmpAreaName;

		SelectServer_Server_Lastarea:SetText(g_iCurSelAreaName);
		-- ������Ϣ
		SelectServer_Text2:Show();
		SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_SearchServerName[index+1], "", strSearchServerStatus);
				--�Ƽ�ѡ������?i
		LoginSelectServer_RecommendNetProvider();
		return;
	end

	GameProduceLogin:SetPingServer(g_iCurSelArea,index);

	--EnableSelect();
	-- ��¼��ǰѡ���login server
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
		--�Ƽ�ѡ������?i
    LoginSelectServer_RecommendNetProvider();

	-- ���ð�ťѡ��״̬.
	g_BnLoginServer[index+1]:SetCheck(1);
	local strLoginServerStatus = "???";

	if(0 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#cff0000Хy#cffffff";
	elseif(1 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#c9E5705S�p �y#cffffff";
	elseif(2 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#cECE58DT�t#cffffff";
	elseif(3 == g_LoginServerStatus[index+1]) then

		strLoginServerStatus = "#e010101#c4CFA4CC�c t�t#cffffff";
	else

		strLoginServerStatus = "#e010101#c959595B�o d��ng#cffffff";
	end

	-- ������Ϣ
	SelectServer_Text2:Show();
	SelectServer_ShowServerInfo(g_iCurSelAreaName.."  "..g_LoginServerName[index+1], "", strLoginServerStatus);

	--�����Ƽ��?i
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
-- �õ�һ��login server��Ϣ����ʾ
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
		strName = strName.."(M�i)";
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


---����ط����ƾ���İ�ť�Բ���ʾ�Լ�TIPS lichengjie
	--if(g_LoginServerPrizeLevel[index+1]>0) then
	--   g_BnLoginServer[index+1]:SetToolTip(g_ThreePrizeTip[g_LoginServerPrizeLevel[index+1]]);
	--   g_BnLoginServerAnimate[index+1]:SetProperty("Animate", g_ThreePrizeAnimate[g_LoginServerPrizeLevel[index+1]]);--��3����Ч����ѡ���Ӧ��һ������Ч������ôд��
	--   g_BnLoginServerAnimate[index+1]:SetProperty("Visible", "True");--����Ч��Ϊ��ʾ
   	--end
--Custom**

end

--------------------------------------------------------------------------------------------------------------
--
-- ����login server ��ť
--
function SelectServer_HideLoginServerBn()

	local index;
	for index = 1, LOGIN_SERVER_COUNT  do
 		g_BnLoginServer[index]:Hide();
		--added by lichengjie ����Ҫ���أ�����Ҫ������Ϊ0��Tip��Ϊ������������ΪKh�ng
		g_BnLoginServer[index]:SetToolTip("");
		g_BnLoginServerAnimate[index]:SetProperty("Animate","");
		g_BnLoginServerAnimate[index]:SetProperty("Visible","False");
		g_LoginServerPrizeLevel[index] = 0;
		--lichengjie
 	end

end

--------------------------------------------------------------------------------------------------------------
--
-- ����login server ��ť
--
function SelectServer_ShowServerInfo(ServerName, NetStatus, ServerStatus)
	SelectServer_Text2:SetToolTip("");
	SelectServer_Text1:SetText("#e010101M�y ch�:#cFFFF00"..ServerName);
	SelectServer_Text2:SetText(NetStatus);
	SelectServer_Text3:SetText("#e010101Tr�ng th�i:"..ServerStatus);

end

---------------------------------------------------------------------------------------------------------------
--
--  ȷ��ѡ��һ���?i
--
function SelectServer_SelectOk()

	-- ���ӵ�login server
	--ͯϲ����ʹ�ô���,�����?i��Ӧ��

	--ѡ��Last�?i Modify by ChengJiancai 2010/03/10
	if(g_iCurSelArea == -1 or g_iCurSelLoginServer == -1) and g_LastServerState ~= StateStop then
		GameProduceLogin:SelectLoginServer(g_LastArea, g_LastServer, g_iNetProvide);
	else
		GameProduceLogin:SelectLoginServer(g_iCurSelArea, g_iCurSelLoginServer, g_iNetProvide);
	end
	return;
end

---------------------------------------------------------------------------------------------------------------
--
--   �Զ�ѡ��һ���?i
--
function SelectServer_SelectAuto()
	GameProduceLogin:AutoSelLoginServer(g_iNetProvide);
end

---------------------------------------------------------------------------------------------------------------
--
--   �˳���Ϸ
--
function SelectServer_Exit()
	QuitApplication("quit");
end

---------------------------------------------------------------------------------------------------------------
-- �������Ƽ��?i
function Commendable_LoginServer_MouseEnter(index)
	--modified by lichengjie
	--if(g_CommendableLoginServerPrizeLevel[index] > 0) then
	--	SelectServer_Info:SetText(g_ThreePrizeTip[g_CommendableLoginServerPrizeLevel[index]]);
	--else
		SelectServer_Info:SetText(g_CommendableLoginServerName[index]..tostring("M�y ch� ph�c v�"));
	--end
	--lichengjie
end

---------------------------------------------------------------------------------------------------------------
--
-- ����������ť
--
function SelectServer_LoginServer_MouseEnter(index)
	if (g_bSearch == 1 ) then
	--lichengjie ����ʾ��ʱ��ӵ��ж� ����ǻ��?i����ʵ3��Tips֮һ��������ǻ�����ʵĳĳ�?i
		--if (g_SearchServerPrizeLevel[index+1] > 0) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_SearchServerPrizeLevel[index+1]]);
		--else
			SelectServer_Info:SetText(g_SearchServerName[index+1]..tostring("M�y ch� ph�c v�"));
		--end
	--lichengjie ����ʾ��ʱ��ӵ��ж�
	else
		--lichengjie ����ʾ��ʱ��ӵ��ж� ����ǻ��?i����ʵ3��Tips֮һ��������ǻ�����ʵĳĳ�?i
		--if (g_LoginServerPrizeLevel[index+1] > 0) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_LoginServerPrizeLevel[index+1]]);
		--else
			SelectServer_Info:SetText(g_LoginServerName[index+1]..tostring("M�y ch� ph�c v�"));
		--end
		--lichengjie ����ʾ��ʱ��ӵ��ж�
	end
end

---------------------------------------------------------------------------------------------------------------
--
-- ����������ť
--
function SelectServer_LastServer_MouseEnter()
	if(g_LastServerName~="") then
		--SelectServer_Info:SetText(g_LastServerName..tostring("M�y ch� ph�c v�"));
		--added by lichengjie �ж��ϴλ�ý���
		--if( g_LastServerPrizeLevel > 0 ) then
		--	SelectServer_Info:SetText(g_ThreePrizeTip[g_LastServerPrizeLevel]);
		--else
			SelectServer_Info:SetText(g_LastServerName..tostring("M�y ch� ph�c v�"));
		--end
	else
		SelectServer_Info:SetText("");
	end
end
---------------------------------------------------------------------------------------------------------------
--
-- ����뿪����ť
--
function SelectServer_LastServer_MouseLeave()

	SelectServer_Info:SetText("");
end
---------------------------------------------------------------------------------------------------------------
--
-- ����뿪����ť
--
function SelectServer_LoginServer_MouseLeave(index)

	SelectServer_Info:SetText("");
end
---------------------------------------------------------------------------------------------------------------
--
-- ���C�ng tr�c���� ��ť
--
function SelectServer_TestArea_MouseEnter(index)

	SelectServer_Info:SetText(g_testAreaDis[index+1]);
end


---------------------------------------------------------------------------------------------------------------
--
-- ����뿪C�ng tr�c���� ��ť
--
function SelectServer_TestArea_MouseLeave(index)

	SelectServer_Info:SetText("");
end;


---------------------------------------------------------------------------------------------------------------
--
-- ������login server ��ť
--
function SelectServer_Area_MouseEnter(index)

	SelectServer_Info:SetText(g_AreaDis[index+1]);
end


---------------------------------------------------------------------------------------------------------------
--
-- ����뿪login server ��ť
--
function SelectServer_Area_MouseLeave(index)

	SelectServer_Info:SetText("");
end;


function SelectServer_Accept_MouseEnter()

	SelectServer_Info:SetText("Nh�p v�o giao di�n ch�n server ��ng nh�p");
end;

function SelectServer_MouseLeave()

	SelectServer_Info:SetText("");
end;

function SelectServer_Automatic_MouseEnter()

	SelectServer_Info:SetText("Gi�p c�c h� ch�n server t�t nh�t");
end;


function SelectServer_Cancel_MouseEnter()

	SelectServer_Info:SetText("Tho�t kh�i Thi�n Long B�t B�");
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

--�����Ƽ�������ť
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

	--����M�ng internet����λ��
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

--��ʾ�Ƽ�������ť
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


-- ˫��ѡ��һ���?i��
function SelectServer_ConfirmSelectLine(index)
	-- ѡ��һ��login server
	SelectServer_SelectLoginServer(index,0);

	-- ȷ��ѡ��һ���?i
	SelectServer_SelectOk();

end;
-- ˫��ѡ��һ���?i��
function SelectServer_LastConfirmSelectLine()

	-- ѡ��һ��login server
	SelectServer_SelectLastServer();

	-- ȷ��ѡ��һ���?i
	SelectServer_SelectOk();

end;
-- ˫��ѡ��һ���?i��
function Commendable_ConfirmSelectLine(index)
	-- ѡ��һ��login server
	Commendable_SelectLoginServer(index);

	-- ȷ��ѡ��һ���?i
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
	--���·�ҳ��ť
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

--�����ʺ�
function SelectServer_AccountReg()
    GameProduceLogin:StartAccountReg()
end

--�ʺų�ֵ
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
	SelectServer_Server_Lastarea:SetText("Kh�ng");
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
	SelectServer_Info:SetText("N�p cash v�o t�i kho�n c�a c�c h�");
end

function SelectServer_RequisitionID_MouseEnter()
	SelectServer_Info:SetText("��ng k� t�i kho�n m�i");
end

function SelectServer_ReturnAreaSelect_MouseEnter()
	SelectServer_Info:SetText("Tr� v� giao di�n ch�n khu");
end

function SelectServer_shangyibu_MouseEnter()
	SelectServer_Info:SetText("Tr� v� giao di�n l�ch tr�nh ho�t �ng");
end

--ѡ���Ƽ�����
function SelectServer_RecommendArea(index)
	if(index > indexForRecommendArea) then
		return;
	end
	--����Ƽ�������������ͨ������ͬ
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
	--����Ƽ�������������ͨ������ͬ
	for i = 1,g_iCurTestAreaCount do
		if(g_testAreaName[i] == g_RecommendCNCAreaName[index]) then
			SelectServer_SelectTestAreaServer(i-1);
		end
	end
end

--�������Ƽ�������ť
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

--������ť
function SelectServer_Search_OK()
	local szSearchName = SelectServer_Server_SearchName:GetText();
	--ȥ���ַ�����β�Ŀո�
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
	SelectServer_Server_Lastarea:SetText("Kh�ng");
	SelectServer_Server_Lastarea:SetCheck(1);
	GameProduceLogin:SetCurrentServerPage(2);
	--SelectServer_Frame2_Sub2:StartFade(0,1);
	g_bSearch = 1;

	if ( serverCount == 0) then
		SelectServer_Server_AreaNameShow:SetText("Ch�a t�m ���c k�t qu� t߽ng �ng");
	else
		SelectServer_Server_AreaNameShow:SetText("T�m k�t qu�");
	end

	--���������?i��ť
	SelectServer_HideLoginServerBn();

	for i = 1,indexForCommendable do
			g_CommendableBnLoginServer[i]:SetCheck(0)
	end;
	NotFlashAll();
	NotFlashAreaBtnAll();

	--��ʾ֮ǰ����ǰѡ��ȫ�����
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
		---lichengjie �����õ����?i�񽱵ȼ�
		,g_SearchServerPrizeLevel[i]
		---lichengjie
		 = GameProduceLogin:GetKeywordLoginServerInfo(i-1);

		g_BnLoginServer[i]:SetCheck(0);
		g_BnLoginServer[i]:Enable();
		g_BnLoginServer[i]:Show();

		--�?i����δ����״̬
		if(g_SearchServerStatus[i] == StatMax) then
			g_BnLoginServer[i]:Hide();
		end

		local strName = g_SearchServerName[i];
		if(g_SearchServerIsNew[i]==1)then
			strName = strName.."(M�i)";
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

		---����ط����ƾ���İ�ť�Բ���ʾ�Լ�TIPS lichengjie
		if(g_SearchServerPrizeLevel[i] > 0) then
		g_BnLoginServer[i]:SetToolTip(g_ThreePrizeTip[g_SearchServerPrizeLevel[i]]);
		g_BnLoginServerAnimate[i]:SetProperty("Animate", g_ThreePrizeAnimate[g_SearchServerPrizeLevel[i]]);--��3����Ч����ѡ���Ӧ��һ������Ч������ôд��
		g_BnLoginServerAnimate[i]:SetProperty("Visible", "True");--����Ч��Ϊ��ʾ
		end
		--
	end
end

--����·�ѡ���?i��Ϣ
function ClearServerTextInfo()
	SelectServer_Text2:SetToolTip("");
	SelectServer_Text1:SetText("");
	SelectServer_Text2:SetText("");
	SelectServer_Text3:SetText("");
	SelectServer_Text2:Hide();
end

--ˢ�°�ť
function SelectServer_FreshPage()
	GameProduceLogin:LoadLaunch();
end

function LoginSelectServer_RecommendNetProvider()
	local loginServerNetProvider;
	--�õ���ǰloginServer��NetProvider
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