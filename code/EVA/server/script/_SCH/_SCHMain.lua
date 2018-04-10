--========================================================= 
-- 加载常用模块
--=========================================================

local BasePath = Utility.GetBasePath() .. "/script/";
package.path = BasePath .. "_SCH/?.lua;" .. BasePath .. "Framework/?.lua;";


require("InitFramework")
require("ScheduleService")
require("PLSInfo/PLSInfoMgr")
require("Player/PlayerInfoMgr")

PLSGameInfo         = require("PLSInfo/PLSGameInfo")
PLSInfo             = require("PLSInfo/PLSInfo")
PlayerInfo          = require("Player/PlayerInfo")
MsgLogin            = require("Msg/MsgLogin")


MsgLoginModule      = MsgLogin:new();


-- 主入口函数。从这里开始lua逻辑
function ServiceInit()
	
    print("Lua Start.");
    
    PLSInfoMgr:Init();
    PlayerInfoMgr:Init();
    ScheduleService:Init();
    
end

-- 游戏循环
function ServiceUpdate()
    TimerMgr:Update(math.floor(os.clock() * 1000));
end

function ServiceRelease()
    
    PLSInfoMgr:OnRelease();
    PlayerInfoMgr:OnRelease();
    ScheduleService:OnRelease();
    print("Lua Release.");
end
