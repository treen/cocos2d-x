require "Cocos2d"
require "Cocos2dConstants"

WaitCircle = class("WaitCircle" , function() return ccui.Widget:create() end)





function WaitCircle:init(radius)
    self.pointlist = {}
    self.speed = 7
    self.radius = radius
    self.interval = 0.35
    
    local function update(delta)
        local time, x ,y ,speed,point,radian
        local lastradian = self.pointlist[1][3] + self.interval + 1
        local factorHeight
        for i=0, #self.pointlist - 1 ,1 do
            point = self.pointlist[i+1]
            point[2] = point[2] + delta
            y = point[1]:getPositionY()
            speed = self.speed*((y - radius)/(-2*radius))+ 1.8
            speed = speed
            radian = point[3]+speed*delta
            if( radian > lastradian - self.interval) then
                radian = lastradian - self.interval
            end
            --if(radian > 6.283185 ) then
            --    radian = radian - 6.283185
            --end
            point[3] = radian;
            lastradian = radian;
            x = math.cos(radian)*radius;
            y = math.sin(radian)*radius;
            
            factorHeight = (y +radius)/(2*radius)
            point[1]:setScale( -factorHeight*2 +2.5);
            point[1]:setColor(cc.c4f(90, (1-factorHeight)*155+100,90,255))
            point[1]:setPosition( x , y )
        end
        
    end

    
    self:scheduleUpdateWithPriorityLua(update,0)  
    local temp
    function onTintEnd(obj)
        local action = cc.TintTo:create(1,math.random(100,200),math.random(150,255),math.random(100,200))
        action = cc.Sequence:create(action,cc.CallFunc:create(onTintEnd))
        obj:runAction(action)
    end
    for i=0, 4 do
    	
        local point = CCSprite:create("res/ui/point.png")
        --local action = cc.TintTo:create(1,math.random(100,200),math.random(150,255),math.random(100,200))
        --action = cc.Sequence:create(action,cc.CallFunc:create(onTintEnd))
        --point:runAction(action)
        temp =  1.57079 - i*self.interval
        table.insert( self.pointlist,{point,1,temp} )
        --point:setColor(cc.c4f(90,i*30+120,90,255))
        x = math.cos(temp)*radius;
        y = math.sin(temp)*radius;
        point:setPosition( x , y )
        self:addChild( point )
    end
end

function WaitCircle:getColor( time )
    
end
function WaitCircle:create( radius )
    local node = WaitCircle.new()
    node:init( radius )
    return node
end

WaitDlg = class("WaitDlg" , function() return cc.LayerColor:create() end)

function WaitDlg:init()
    self.circleRadian = 200
    self:setColor(cc.c4b(10,10,10,255))
    self:setOpacity(128)
    

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
    self.waitcircle = WaitCircle:create(self.circleRadian)
    self.waitcircle:setPosition(visibleCenter.x , visibleCenter.y);
    self:addChild( self.waitcircle )
end

function WaitDlg:setScale(x)
    self.waitcircle:setScale(x)
    self.circleRadian = self.circleRadian*x   
    if( self.message ~= nil ) then
        self.message:setPosition( visibleCenter.x , visibleCenter.y - self.circleRadian - 50 )
    end 
end

function WaitDlg:create( parentScene )
    if( parentScene == nil ) then
        runningScene = cc.Director:getInstance():getRunningScene()
        if(runningScene)  then
            parentScene = runningScene
        else
            return nil
        end
    end
    local dlg = WaitDlg.new()
    dlg:init() 
    parentScene:addChild(dlg,10000)
    
    
    return dlg
end

function WaitDlg:setMessage( message )
    if( self.message == nil ) then
        self.message = cc.LabelTTF:create( message , "Arial" , 24 )
        self:addChild( self.message )
        self.message:setPosition( visibleCenter.x , visibleCenter.y - self.circleRadian - 24 )
    end
end

function WaitDlg:close()
    self:removeFromParent(true)
end




