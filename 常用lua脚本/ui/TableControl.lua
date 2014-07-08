TableControl = class("TableControl")
function TableControl:init( widget )
    self.buttons={}
    self.root = widget
    local function onSelect( obj ,event )
        if( event == ccui.CheckBoxEventType.selected ) then
            local tag = obj:getTag()
            self:select(tag)
        elseif( event == ccui.CheckBoxEventType.unselected ) then
            
        end
    end
    
    local buttonLayer = widget:getChildByName("tables")
    local tablenum = buttonLayer:getChildrenCount()
    for i = 1 , tablenum   do 
        local button = buttonLayer:getChildByName("table"..i)
        self.buttons[i] = button
        button:setTag(i)
        button:addEventListenerCheckBox(onSelect)
    end    
   
    self.slider = widget:getChildByName("slider")
    self.curSel = 2
    self.moveTime = 1;
    self.maxTime = 1
    self.startPosition = {};
    local x = self.buttons[1]:getPositionX()
    local y = self.slider:getPositionY()
    --ccui.Button:getpo
    --self.buttonBack:runAction(cc.EaseElasticOut:create(cc.MoveTo:create(1, cc.p(x,y) )))
    self.buttons[1]:setSelectedState(true)
end

function TableControl:setSize(size)
    self.root:setSize(size)
end

function TableControl:select( index )
    if( self.onTableSelect )then
        self.onTableSelect(index)
    end
    if(self.curSel == index ) then
    
    else
        
        local oldButton = self.buttons[self.curSel]
        local curButton = self.buttons[index]
        oldButton:setSelectedState(false)
        oldButton:setTouchEnabled(true)
        
        local x = curButton:getPositionX()
        local y = self.slider:getPositionY()
        --self:buttons[self.curSel]:setSelectedState(false)
        self.slider:runAction(cc.EaseElasticOut:create(cc.MoveTo:create(0.5, cc.p(x,y) ) , 0.65))
        self.curSel = index 
        curButton:setTouchEnabled(false)
        curButton:setSelectedState(true)
        
    end
end

function TableControl:update( delta )
   

end


function TableControl:getButton( index )
    return self.buttons[index]
end
