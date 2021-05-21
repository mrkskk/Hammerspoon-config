


-- Hammerspoon window management shortcuts
--  ,------------------------------------------.                            ,----------------------------+------+--------.
--    ____,   1/6 ,  2/6  , 3/6 ,  1/4,   2/4,                                3/4,   4/4,    4/6,   5/6,   6/6,   ____  ,    
--  |--------+-----+------+------+------+------|                            |------+------+------+-------+------+--------|
--   ____ ,   1/3 ,  2/3  , 3/3, fullscr,Layout,                              ____, Focu_l, Focu_u, Focu_r,____ , ____     
--  |--------+-----+------+------+------+------+------+------.,------+------+------+------+------+-------+------+--------|
--     ____ ,   ____, ____,  ____,  ____,  ____,  ____,  ____,   ____,  ____,LScn  ,  Rscn  Focu_d, ____,  ____,  ____,    
--  `---------------------+------+------+------+------+------||------+------+------+------+------+-----------------------'
--                         _____, _____, _____, _____, _____,  _____, _____, _____, _____, ____   
--                        `----------------------------------'`----------------------------------'  


-- Screen is Dell 49 inch. Running with displayport and hdmi cable as two external monitors
hs.window.animationDuration = 0
  leftScreen = hs.screen.primaryScreen(0x600003f98880)
  rightScreen = leftScreen:toEast()


-- Set shortcuts to move windows between displays Hyper+N for leftScreen and hyper+M for rightScreen
function moveWindowToDisplay(d)
  return function()
    local displays = hs.screen.allScreens()
    local win = hs.window.focusedWindow()
    win:moveToScreen(displays[d], false, true)
  end
end




   local win = hs.window.focusedWindow()
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "N", moveWindowToDisplay(1))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "M", moveWindowToDisplay(2))

-- Set positions that can be used in grid and layout
positions = {
  maximized = hs.layout.maximized,
  centered = {x=0.15, y=0.15, w=0.7, h=0.7},
  fullscreen = {x=0, y=0, w=2, h=1},
  leftthird = {x=0, y=0, w=0.333, h=1},
  middlethird = {x=0.3334, y=0, w=0.3334, h=1},
  rightthird = {x=0.666, y=0, w=0.3334, h=1},

  betweenscreens = {x=0.666, y=0, w=0.666, h=1},
  twothirdsleft = {x=0, y=0, w=0.666, h=1},
  twothidsright= {x=0.3334, y=0, w=0.666, h=1},

  left50 = hs.layout.left50,
  left75 = hs.layout.left75,
  left66 = {x=0, y=0, w=0.666, h=1},

  right50 = hs.layout.right50,
  right75 = hs.layout.right75,
  right66 = {x=0.3334, y=0, w=0.666, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},
  lower50Right50 = {x=0.5, y=0.5, w=0.5, h=0.5}
}

function bindKey(key, fn)
  hs.hotkey.bind({"cmd", "ctrl","alt"}, key, fn)
end


grid = {
  --{key="q", units={positions.leftthird, positions.left50, positions.left66, }},
  --{key="w", units={positions.middlethird, positions.left66, positions.right66}},
  --{key="e", units={positions.rightthird, positions.right50, positions.right66,}},
  --{key="f", units={positions.maximized, positions.right75, positions.left75}},
  --{key="h", units={positions.twothirdsleft}},
  --{key="j", units={positions.betweenscreens}},
  --{key="k", units={positions.twothidsright}},

 --{key="x", units={positions.right66}},
 --{key="z", units={positions.left66}},

  -- {key="r", units={positions.left50, positions.lower50Left50, positions.upper50Left50, positions.upper50, positions.lower50}}, -- virker IKKE på sekundære skærm?
  -- {key="t", units={positions.right50, positions.lower50Right50, positions.upper50Right50, positions.upper50, positions.lower50}}, -- virker IKKE på sekundære skærm?

}

hs.fnutils.each(grid, function(entry)
  bindKey(entry.key, function()
    local units = entry.units
  -- Jeg kan ikke få grids til at virke med begge skærme
    local screen = hs.screen.mainScreen()
    local window = hs.window.focusedWindow()
    local windowGeo = window:frame()

    local index = 0
    hs.fnutils.find(units, function(unit)
      index = index + 1

      local geo = hs.geometry.new(unit):fromUnitRect(screen:frame()):floor()
     return windowGeo:equals(geo)
    end)
    if index == #units then index = 0 end

    window:moveToUnit(units[index + 1])
  end)
end)


--Ved at bruge demme kode istedet for grid kan man placere direkte på ve og hø skærm uden at bruge genvejene til at skifte skærm først: hyper n og hyper m
----------
--to trejdedel venstre
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "a", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w - (max.w *0.333)
  f.h = max.h
  win:setFrame(f)
end)

----------
--to trejdedel midt
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "s", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.666)
  f.y = max.y
  f.w = max.w - (max.w *0.333)
  f.h = max.h
  win:setFrame(f)
end)

----------
--to trejdedel højre
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "d", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = rightScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.333)
  f.y = max.y
  f.w = max.w - (max.w *0.333)
  f.h = max.h
  win:setFrame(f)
end)
----------
--en trejdedel venstre - leftScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "q", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w /3
  f.h = max.h
  win:setFrame(f)
end)
----------
--en trejdedel midt - leftScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "w", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.333)
  f.y = max.y
  f.w = max.w /3
  f.h = max.h
  win:setFrame(f)
end)
----------
--en trejdedel højre - leftScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "e", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.666)
  f.y = max.y
  f.w = max.w /3
  f.h = max.h
  win:setFrame(f)
end)
----------
----------
----------
--en trejdedel venstre - rightScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "i", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = rightScreen
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w /3
  f.h = max.h
  win:setFrame(f)
end)
----------
--en trejdedel midt - rightScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "o", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = rightScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.333)
  f.y = max.y
  f.w = max.w /3
  f.h = max.h
  win:setFrame(f)
end)
----------
--en trejdedel højre - rightScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "p", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = rightScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.666)
  f.y = max.y
  f.w = max.w /3
  f.h = max.h
  win:setFrame(f)
end)
----------
----------
--en ve halvdel  - leftScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w /2
  f.h = max.h
  win:setFrame(f)
end)
----------
--en ve halvdel  - leftScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "t", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.5)
  f.y = max.y
  f.w = max.w /2
  f.h = max.h
  win:setFrame(f)
end)
----------
--en ve halvdel  - rightScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "y", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = rightScreen
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w /2
  f.h = max.h
  win:setFrame(f)
end)
----------
--en hø halvdel  - rightScreen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "u", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = rightScreen
  local max = screen:frame()

  f.x = max.x + (max.w *0.5)
  f.y = max.y
  f.w = max.w /2
  f.h = max.h
  win:setFrame(f)
end)----------
--maximized - left screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "g", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x 
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)
----------
--maximized - right screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x + (max.w * 1)
  f.y = max.y
  f.w = max.w 
  f.h = max.h
  win:setFrame(f)
end)
--maximized - BOTH screens
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "f", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x 
  f.y = max.y
  f.w = max.w + (max.w)
  f.h = max.h
  win:setFrame(f)
end)
--midt - to fjeredele
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
local screen = leftScreen
  local max = screen:frame()

  f.x = max.x  + (max.w *0.5)
  f.y = max.y
  f.w = max.w 
  f.h = max.h
  win:setFrame(f)
end)
----------
----------
--Åbne Chrome vinduer-----------------------------------------------------

--hs.hotkey.bind({"cmd", "alt", "ctrl"}, 'v', function() 
  -- hs.application.open("Google Chrome", wait, waitForFirstWindow)
   --hs.eventtap.keyStroke({"cmd","alt", "ctrl"}, "N") --placerering venstreskærm
   --hs.eventtap.keyStroke({"cmd","alt", "ctrl"}, "q") --placerering leftthird
   --hs.eventtap.keyStroke({"cmd"}, "n")
   --hs.eventtap.keyStroke({"cmd","alt", "ctrl"}, "e") --placerering rightthird
   --hs.eventtap.keyStroke({"cmd","alt", "ctrl"}, "M") --placerering højreskærm
--end)

--layouts. Snaps all windows in place with a hotkey. 

local bLayout = {
--rightScreen
  --fullscreen
    {"Obsidian", nil, rightScreen,   hs.layout.fullscreen,   nil, nil},
  --left50
    {"Sublime Text", nil, rightScreen,   hs.layout.left50,   nil, nil},
    {"Microsoft Word", nil, rightScreen,   hs.layout.left50,   nil, nil},
  --right50
    {"Books",   nil, rightScreen,  positions.right50, nil, nil},
  --leftthird
    {"Spotify", nil, rightScreen,   hs.layout.leftthird,   nil, nil},
  --middlethird
    {"iterm", nil, rightScreen,   hs.layout.middlethird,   nil, nil},
  --rightthird
    {"Facebook Messenger",  nil, rightScreen,  positions.rightthird,    nil, nil},
--leftScreen
  --left50
    {"Google Chrome",  nil, leftScreen,  hs.layout.left50,    nil, nil},
    {"Calibre", nil, leftScreen,   hs.layout.left50,   nil, nil},
    {"Zotero",  nil, leftScreen,  positions.left50,    nil, nil},
    {"Signal",  nil, leftScreen,  positions.left50,    nil, nil},
  --right50
    {"Skim",       nil, leftScreen,  positions.right50, nil, nil},
    {"Google Chrome",  nil, leftScreen,  hs.layout.right50,    nil, nil},
    {"Outlook",  nil, leftScreen,  positions.right50,    nil, nil},
    {"Discord",  nil, leftScreen,  positions.right50,    nil, nil},
  --leftthird
  --middlethird
  --rightthird
}
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "b", function()
  hs.layout.apply(gLayout)
end)


--Focus window. Changes the focusedWindow with shortcuts
local hyper2 = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper2, 'o', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowNorth()
        -- Center mouse on Window after focus or switch occurs
      currentWindow = hs.window.focusedWindow()
      currentFrame = currentWindow:frame()
      cfx = currentFrame.x + (currentFrame.w / 2)
      cfy = currentFrame.y + (currentFrame.h / 2)
      cfp = hs.geometry.point(cfx, cfy)
      hs.mouse.setAbsolutePosition(cfp)
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper2, 'e', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowSouth()
        -- Center mouse on Window after focus or switch occurs
      currentWindow = hs.window.focusedWindow()
      currentFrame = currentWindow:frame()
      cfx = currentFrame.x + (currentFrame.w / 2)
      cfy = currentFrame.y + (currentFrame.h / 2)
      cfp = hs.geometry.point(cfx, cfy)
      hs.mouse.setAbsolutePosition(cfp)
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper2, 'i', function()
    if hs.window.focusedWindow() then
    hs.window.focusedWindow():focusWindowEast() 
    -- Center mouse on Window after focus or switch occurs
      currentWindow = hs.window.focusedWindow()
      currentFrame = currentWindow:frame()
      cfx = currentFrame.x + (currentFrame.w / 2)
      cfy = currentFrame.y + (currentFrame.h / 2)
      cfp = hs.geometry.point(cfx, cfy)
      hs.mouse.setAbsolutePosition(cfp)
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper2, 'a', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowWest()
     -- Center mouse on Window after focus or switch occurs
      currentWindow = hs.window.focusedWindow()
      currentFrame = currentWindow:frame()
      cfx = currentFrame.x + (currentFrame.w / 2)
      cfy = currentFrame.y + (currentFrame.h / 2)
      cfp = hs.geometry.point(cfx, cfy)
      hs.mouse.setAbsolutePosition(cfp)
    else
        hs.alert.show("No active window")
    end
end)


hs.hotkey.bind(hyper2, "p", function()
    hs.window.highlight.ui.overlayColor = {0.2,0.05,0,0.25}
    hs.window.highlight.start()
end)

hs.hotkey.bind(hyper2, ",", function()
    hs.window.highlight.toggleIsolate(v)
end)






------
------
------Defeat Paste blocking
------
------
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

wifiwatcher = hs.wifi.watcher.new(function ()
    net = hs.wifi.currentNetwork()
    if net==nil then
        hs.notify.show("You lost Wi-Fi connection","","","")
    else
        hs.notify.show("Connected to Wi-Fi network","",net,"")
    end
end)
wifiwatcher:start()




-------------------
-----Reload config - automaticly reload config after saving this file
-------------------
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.alert.show("Config loaded")
-------------------
-------------------
------------------- 
