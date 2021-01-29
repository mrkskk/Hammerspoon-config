hs.window.animationDuration = 0
  leftScreen = hs.screen.primaryScreen(0x600003f98880)
  rightScreen = leftScreen:toEast()

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
 -- {key="f", units={positions.maximized, positions.upper50, positions.lower50}},
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
--en ve halvdel  - rightScreen
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
end)
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

--layouts-------------------------------------------------------------------

local gLayout = {
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
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "g", function()
  hs.layout.apply(gLayout)
end)


--Focus window----------------------------------------------------------------
local hyper = {"cmd", "alt", "ctrl"}

hs.hotkey.bind(hyper, 'k', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowNorth()
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper, ',', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowSouth()
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper, 'l', function()
    if hs.window.focusedWindow() then
    hs.window.focusedWindow():focusWindowEast()
    else
        hs.alert.show("No active window")
    end
end)

hs.hotkey.bind(hyper, 'j', function()
    if hs.window.focusedWindow() then
        hs.window.focusedWindow():focusWindowWest()
    else
        hs.alert.show("No active window")
    end
end)


-------------------
-----Reload config
-------------------
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.alert.show("Config loaded")
-------------------
-------------------
-------------------
function coords ()
  return hs.window.focusedWindow(), hs.window.focusedWindow():frame(),
         hs.window.focusedWindow():screen(), hs.window.focusedWindow():screen():frame()
end


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "left", function()

  local win, wf, scr, sf = coords()

  if wf.x <= sf.x and wf.w <= math.floor(sf.w/3) then
    wf.x = sf.x
    wf.w = math.floor(sf.w/4)
  elseif wf.x <= sf.x and wf.w <= math.floor(sf.w/2) then
    wf.x = sf.x
    wf.w = math.floor(sf.w/3)
  else
    wf.x = sf.x
    wf.w = math.floor(sf.w/2)
  end
  wf.y=sf.y
  wf.h=sf.h
  win:setFrame(wf, 0)
end)


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "right", function()

  local win, wf, scr, sf = coords()

  if wf.x >= math.floor(sf.x + sf.w/3) and wf.w <= math.floor(sf.w/3) then
    wf.w = sf.w/4
    wf.x = math.floor(sf.x + 3 * sf.w/4)
  elseif wf.x >= math.floor(sf.x + sf.w/2) and wf.w <= math.floor(sf.w/2) then
    wf.w = sf.w/3
    wf.x = math.floor(sf.x + 2 * sf.w/3)
  else
    wf.w = sf.w/2
    wf.x = math.floor(sf.x + sf.w/2)
  end
  wf.y=sf.y
  wf.h=sf.h
  win:setFrame(wf, 0)
end)


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()

  local win, wf, scr, sf = coords()

  win:setFrame(sf, 0)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "down", function()

  local win, wf, scr, sf = coords()

  if wf.x ~= math.floor(sf.x + sf.w/3) and wf.w ~= math.floor(sf.w/3) then
    wf.w = math.floor(sf.w/3)
    wf.x = math.floor(sf.x + sf.w/3)
  else
    wf.w = sf.w/2
    wf.x = math.floor(sf.x + sf.w/4)
  end
  wf.y=sf.y
  wf.h=sf.h

  win:setFrame(wf, 0)
end)