PageSwitcher = class("PageSwitcher")

function PageSwitcher:ctor( )
    self.pages={}
    
end

function PageSwitcher:addPage(page,idx)
    self.pages[idx]=page
    if( self.currentPage == nil )then
        self.currentPage = page
        self.currentPageIndex = #self.pages
    else
        page:setVisible(false)
    end
end

function PageSwitcher:switchPage( idx )
    local page = self.pages[idx]
    if( self.currentPage ~= page ) then
        local size = self.currentPage:getCustomSize()
        local offset = -size.width
        if( idx < self.currentPageIndex) then
            offset = -offset
        end 
        
        local action = cc.MoveTo:create(0.2,cc.p(offset, 0))
        self.currentPage:runAction(cc.Sequence:create(action,cc.Hide:create()))
        self.currentPage:setTouchEnabled(false)
        page:setPosition(-offset,0)
        action = cc.MoveTo:create(0.2,cc.p(0,0))
        page:setVisible(true);
        page:runAction(action)
        page:setTouchEnabled(true)
        self.currentPage = page
        self.currentPageIndex = idx
    end
end