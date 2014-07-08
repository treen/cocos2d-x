
module("system",package.seeall)

local targetPlatform = cc.Application:getInstance():getTargetPlatform()
if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
    luac = require("luac")  
elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
    luaj = require("luaj")
elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
elseif(cc.PLATFORM_OS_MAC == targetPlatform) then 
end
function isRunning( packetname )
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
       
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={packetname}
        local sig = "(Ljava/lang/String;)Z"
        ok, ret=luaj.callStaticMethod("org.cocos2dx.lua.AppActivity", "isPacketRunning", args, sig)
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
    return ret
end
function isInstalled(packetname)
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={packetname}
        local sig = "(Ljava/lang/String;)Z"
        ok, ret = luaj.callStaticMethod("org.cocos2dx.lua.AppActivity", "isPacketInstalled", args, sig)
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
    return ret
end

function installApp( filename )
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={filename}
        local sig = "(Ljava/lang/String;)V"
        ok, ret = luaj.callStaticMethod("org.cocos2dx.lua.AppActivity", "installApp", args, sig)
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
    

end

function runApp( packetname )
    local ok, ret
    local args ={packetname}
    local sig = "(Ljava/lang/String;)V"
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        ok, ret = luaj.callStaticMethod("org.cocos2dx.lua.AppActivity", "runApp", args, sig)
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
end

function openWeb( url )
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={url}
        local sig = "(Ljava/lang/String;)V"
        ok, ret = luaj.callStaticMethod("org.cocos2dx.lua.AppActivity", "openWeb", args, sig)
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
        os.execute("start "..url)
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
end

function GetLaunchString()
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={}
        local sig = "()Ljava/lang/String;"
        ok, ret = luaj.callStaticMethod("com.longye.my365.App", "GetLaunchString", args, sig)
        return ret
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
end

function OnAuthorizeLoginSuccess(token,uid)
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={token,uid}
        local sig = "(Ljava/lang/String;Ljava/lang/String;)V"
        ok, ret = luaj.callStaticMethod("com.longye.my365.AuthorizeLoginActivity", "onAuthorizeLoginSuccess", args, sig)
        return ret
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
end

function SetCocosReady()
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={}
        local sig = "()V"
        ok, ret = luaj.callStaticMethod("com.longye.my365.App", "SetCocosReady", args, sig)
        return ret
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
end

function IsCocosReady()
    local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={}
        local sig = "()Z"
        ok, ret = luaj.callStaticMethod("com.longye.my365.App", "IsCocosReady", args, sig)
        return ret
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
end

function GetSDCardPath()
local ok, ret
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then        
    elseif(cc.PLATFORM_OS_ANDROID == targetPlatform) then
        local args ={}
        local sig = "()Ljava/lang/String;"
        ok, ret = luaj.callStaticMethod("org.cocos2dx.lua.AppActivity", "getSDCardPath", args, sig)
        return ret
    elseif(cc.PLATFORM_OS_WINDOWS == targetPlatform) then
    elseif(cc.PLATFORM_OS_MAC == targetPlatform) then  
    end
end
