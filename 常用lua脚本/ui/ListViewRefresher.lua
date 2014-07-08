ListViewRefresher = class("ListViewRefresher",
    function() 
        return ccs.GUIReader:getInstance():widgetFromJsonFile("res/ui/youjiangUI/list_view_refresher.ExportJson")
    end)
    
    
function ListViewRefresher:init( listview , freshHandle ,nextHandle )
    self.freshHandle = freshHandle
    self.listview = listview;
    self.isFreshing = false
    self:registerScriptHandler(function( event , obj )
        if( event == "enterTransitionFinish") then
            local size = self:getParent():getCustomSize()
            local oldsize = self.page:getCustomSize()
            self:setSize(cc.size(size.width ,0 ))
            self.page:setSize(cc.size(size.width ,oldsize.height ))
            self:setPosition(0,0)
            --listview:jumpToTop();
        end
    end)
    
    self.page = self:getChildByName("refresher")
    self.text = self.page:getChildByName("text")
    listview:getInnerContainer():addChild(self)
    --listview:addProtectedChild(self)
    --listview:insertCustomItem(self,0)
    listview:addEventListenerScrollView(function(obj,event)
        if( event == ccui.ScrollviewEventType.bounceTop )then
            
            if(self.isFreshing )then
                if( self.freshHandle )then
                    self.freshHandle()
                end
                self.text:setString(stringTable[102])            
                self.isFreshing = false
                self.circle:removeFromParent()
            end
            
        elseif( event == ccui.ScrollviewEventType.scrolling)   then
            local y = listview:getInnerContainer():getPositionY()
            local topY=listview:getSize().height - listview:getInnerContainerSize().height
            if( y < topY -200 and y > topY - 400) then
                if(not self.isFreshing)then
                    self.isFreshing = true
                    self:fresh()
                end
            elseif( y >200 )then
                if( nextHandle )then
                    nextHandle()
                end
            end
        end
        return false
    end)
    
    
    
end

function ListViewRefresher:fresh()
    self.text:setString(stringTable[101])
    self.circle =  WaitCircle:create(200)
    self.circle:setScale(0.1)
    self.text:addChild( self.circle) 
    self.circle:setPosition(-100,20)
    
end
function ListViewRefresher:create( listview,freshHandler ,nextHandler)
    local refresher = ListViewRefresher.new()
    refresher:init(listview,freshHandler,nextHandler)
    return refresher
end