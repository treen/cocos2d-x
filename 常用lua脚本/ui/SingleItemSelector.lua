SingleItemSelector = class("ListViewRefresher",
    function() 
        return ccs.GUIReader:getInstance():widgetFromJsonFile("res/ui/youjiangUI/single_item_selector.ExportJson")
    end)
function SingleItemSelector:ctor()
    self.onBack=function()
        cc.Director:getInstance():popScene()
    end
end   
    
function  SingleItemSelector:init(title,onSelectHandle)
    self:registerScriptHandler(function( event , obj )
        if( event == "enterTransitionFinish") then
            
        end
    end)
    
    self.backup = self:getChildByName("navigation"):getChildByName("backbutton")
    self.backup:addTouchEventListener(function(obj,event)
        if( event == ccui.TouchEventType.ended ) then
            self.onBack()
        end
    end)
    
    self.stringItem = self:getChildByName("string_item")
    self.line = self:getChildByName("line")
    self.onSelectHandle = onSelectHandle
    self.listView = self:getChildByName("listview")
    self.title = self:getChildByName("navigation"):getChildByName("title")
    self.title:setString( title )
    self.items={}

end
function SingleItemSelector:addString( text , value )
    local item = self.stringItem:clone()
    item.myText = item:getChildByName("string")
    item.myText:setString(text)
    local size = self:getCustomSize()
    item:setVisible(true)
    item.myText:setColor(cc.c3b(81,81,81))
    item.myValue = value
    --item:setSizeType(ccui.SizeType.absolute)
    item:setSize(cc.size(size.width,80));
    self.listView:pushBackCustomItem(item)
    item:setTag(#self.items);
    table.insert(self.items,item)
    
    item:addTouchEventListener(function( obj , event )
        if( event == ccui.TouchEventType.ended) then            
            self.onSelectHandle(0,item.myValue)
        end
    end)
    
end
function GetItemAt(idx)
    return self.items[idx]
end
function SingleItemSelector:AddItem( widget , value )
end
function SingleItemSelector:create( title,onSelectHandle)
    local dlg = SingleItemSelector.new()
    dlg:init(title,onSelectHandle)
    return dlg
end