UnfoldControl = class("UnfoldControl" ,function(filename)
    return ccs.GUIReader:getInstance():widgetFromJsonFile(filename)
end )

function UnfoldControl:_init()
    
    self.state = 0
    self.head = self:getChildByName("head")
    self.foot = self:getChildByName("footbar")
    self.content = self:getChildByName("content")
    
    self:setClippingEnabled(true)
    --self:setClippingType(0)
    self.foot:setClippingEnabled(true)
    --self.foot:setClippingType(0)
    self.line = self.foot:getChildByName("line")
    self.content:setClippingEnabled(true)
    self.content:setVisible(false)
    self.headHeight = self.head:getCustomSize().height
    self.footHeight = self.foot:getCustomSize().height
    self.contentHeight = self.content:getCustomSize().height
    self.foldHeight = self.headHeight + self.footHeight
    self.time = 0
    self.animationTime = 0.9
    self.unfoldPercent = 0
    self:scheduleUpdateWithPriorityLua(function( delta )
        if( self.state == 0 )then
            return 
        else
            
            self.time = self.time + delta
            if( self.time > self.animationTime)then
                if( self.state == 1 )then
                    self.unfoldPercent = 1
                elseif( self.state == 2)then
                    self.unfoldPercent = 0
                end
                self.time = self.animationTime
                self.state = 0
            end
            if( self.state == 1 )then
                self.unfoldPercent = math.sin(self.time/self.animationTime*1.5707)
            elseif( self.state == 2)then
                self.unfoldPercent = math.cos(self.time/self.animationTime*1.5707)
            end
            self:setHeightPercent(self.unfoldPercent)
            if(self.onSizeChangeHandle) then
                self.onSizeChangeHandle()
            end
            
        end
    end,0)
end

function UnfoldControl:setSizeChangeHandle(handle)
    self.onSizeChangeHandle = handle
end
function UnfoldControl:setHeightPercent( percent )
    local size = self:getCustomSize()
    --self.contentHeight = self.downloadContent:getCustomSize().height
    self:setInfoSize( size.width , self.contentHeight*percent + self.foldHeight  )
    
    if( percent == 0) then
        self.content:setVisible(false)
    else
        self.content:setVisible(true)
    end
end


function UnfoldControl:setInfoSize( width,height )
    local size = cc.size(width,2)
    self:setSize(cc.size(width,height))
    self.head:setSize(cc.size(width,self.headHeight))
    self.content:setSize(cc.size(width-4, height - self.foldHeight ))
    self.foot:setSize(cc.size(width,self.footHeight))
    self.line:setSize( cc.size(width-10,2))
end

function UnfoldControl:addContent(widget)
    local lp = ccui.LinearLayoutParameter:create()
    lp:setGravity(ccui.LinearGravity.centerHorizontal)
    widget:setLayoutParameter(lp)
    self.content:addChild( widget )
    
    self.contentHeight = self.contentHeight + widget:getCustomSize().height
end

function UnfoldControl:insertContent(widget,pos)
    local lp = ccui.LinearLayoutParameter:create()
    lp:setGravity(ccui.LinearGravity.centerHorizontal)
    widget:setLayoutParameter(lp)
    self.content:addChild(widget,pos)
    self.contentHeight = self.contentHeight + widget:getCustomSize().height
end
function UnfoldControl:unfold()
    self.state = 1 
    self.time = 0
end


function UnfoldControl:fold()
    self.state = 2
    self.time = 0
end
