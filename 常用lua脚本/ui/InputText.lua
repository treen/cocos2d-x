InputText = class("InputText" ,
    function() 
        return ccs.GUIReader:getInstance():widgetFromJsonFile("res/ui/youjiangUI/input_text.ExportJson")
    end)



function InputText:ctor( handler )

    self.backup = self:getChildByName("navigation"):getChildByName("backbutton")
    self.backup:addTouchEventListener(function(obj,event)
        if( event == ccui.TouchEventType.ended )then
            cc.Director:getInstance():popScene()
        end
    end)
    self.text = self:getChildByName("text")
    local buttonOK = self:getChildByName("OK")
    buttonOK:addTouchEventListener(function(obj,event)
        if( event == ccui.TouchEventType.ended )then
            handler( self.text:getStringValue())
        end
    end)
    self.text:attachWithIME()
end

function InputText:create( handler )
    local page = InputText.new(handler )
    return page
end
