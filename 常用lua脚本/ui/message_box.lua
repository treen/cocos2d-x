MessageBox = class("MessageBox" , function() return cc.LayerColor:create() end)

function MessageBox:init()
    self:setColor(cc.c4b(10,10,10,255))
    self:setOpacity(128)
    self.onCancel = self._onClose
    self.onOK = self._onClose
    self.onClose = self._onClose
    self.titleControl = nil
    self.textContent = nil
-- handing touch events
    local touchBeginPoint = nil
    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        cclog("onTouchBegan: %0.2f, %0.2f", location.x, location.y)
        touchBeginPoint = {x = location.x, y = location.y}
        
        return true
    end

    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        cclog("onTouchMoved: %0.2f, %0.2f", location.x, location.y)
        if touchBeginPoint then
           
        end
    end

    local function onTouchEnded(touch, event)
        local location = touch:getLocation()
        cclog("onTouchEnded: %0.2f, %0.2f", location.x, location.y)
        touchBeginPoint = nil
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true);
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    
    local messagebox = ccs.GUIReader:getInstance():widgetFromJsonFile("res/ui/youjiangUI/Popupbox.ExportJson")
    self:addChild(messagebox)
    local size = messagebox:getContentSize()
    messagebox:setPosition(visibleCenter.x - size.width*0.5,visibleCenter.y - size.height*0.5)
    local title = messagebox:getChildByName("title")
    self.titleControl = title:getChildByName("title")
    self.textContent = messagebox:getChildByName("text")
   -- message
   local close = title:getChildByName("close")
   close:addTouchEventListener(
   function(obj , event)
        if( event == ccui.TouchEventType.ended) then
            self:onClose()
        end
   end)
   
   self.okbutton = messagebox:getChildByName("ok")
   self.okbutton:addTouchEventListener(
   function(obj , event)
        if( event == ccui.TouchEventType.ended) then
            self:onOK()
        end
   end)
    
    
   self.cancel = messagebox:getChildByName("cancel")
   self.cancel:addTouchEventListener(
   function(obj , event)
        if( event == ccui.TouchEventType.ended) then
            self:onCancel()
        end
   end)
   
   
end

function MessageBox:setTitle( title )
    self.titleControl:setString( title )
end

function MessageBox:setMessage( message )
    self.textContent:setString( message )
end

function MessageBox:setOKButtonString( text )
    self.okbutton:setTitleText(text)
end

function MessageBox:setCancelButtonString( text )
    self.cancel:setTitleText(text)
end
function MessageBox:create()
    local dlg = MessageBox.new()
    dlg:init() 
    local runningScene = cc.Director:getInstance():getRunningScene()
    if(runningScene)  then
        runningScene:addChild(dlg,10000)
    end
    
    return dlg
end

function MessageBox:_onClose()
   self:close()
end

function MessageBox:_onOK()
end

function MessageBox:close()
    self:removeFromParent(true)
end