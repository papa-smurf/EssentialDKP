local _, core = ...;
local _G = _G;
local MonDKP = core.MonDKP;
local L = core.L;

local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local function SanityCheckPositiveDKPHistoryEntry(data)
  if not data then return false end
  if (data.deletedby or data.deletes) then return false end
  if (type(data.dkp) == "nil") then return false end
  if (type(data.reason) == "nil") then return false end
  if (data.reason == "Weekly Decay") then return false end
  if ((type(data.dkp) == "number") and (data.dkp <= 0)) then return false end

  -- This should not be ever reached but I'll add this just in case
  -- If any of the dkp adjustments in the CSV list is not positive we assume all are
  if ((type(data.dkp) == "string")) then
    local dkpAdjustement = { strsplit(",", data.dkp) }
    for _,val in pairs(dkpAdjustement) do
      if tonumber(val) <= 0 then return false end
    end
  end

  return true
end

local function GetActivePlayersTable(limit, activePlayers)
  -- Cache player classes
  local GuildieClassCache = {}
  GuildRoster()
  local guildMembers = GetNumGuildMembers();
  for i=1,guildMembers,1 do
    local character, _, _, level, class = GetGuildRosterInfo(i);
    local nameServer = { strsplit("-", character) }
    if (level >= 55) then
      GuildieClassCache[nameServer[1]] = class
    end
  end

  -- Activity
  local count = 0
  for _, data in pairs(MonDKP_DKPHistory) do
    if SanityCheckPositiveDKPHistoryEntry(data) then
      local players = { strsplit(",", data.players) }
      for _,name in pairs(players) do
        if not activePlayers[name] then
          if GuildieClassCache[name] then
            activePlayers[name] = {class = GuildieClassCache[name], lastActive = data.date}
          end
        end
      end
      count = count + 1
      if data.date < limit then return end
    end
  end
end

local function ActivePlayersTableToCSV(activePlayers)
  local csv = "charName,class,lastActive\n"
  for name,data in pairs(activePlayers) do
    csv = csv..name..";"..data.class..";"..data.lastActive.."\n"
  end
  return csv
end

local function SavedVariablesSync(order, input_data)

  local savedVariables = {
    --"MonDKP_DB",
    "MonDKP_Loot",
    "MonDKP_DKPTable",
    "MonDKP_DKPHistory",
    "MonDKP_MinBids",
    "MonDKP_MaxBids",
    "MonDKP_Whitelist",
    "MonDKP_Standby",
    "MonDKP_Archive"
  }

  local data = {}
  local serialized = nil;
  local compressed = nil;

  if order == "export" then
    data["MonDKP_DB"] = _G["MonDKP_DB"]
    for _,var in pairs(savedVariables) do
      data[var] = _G[var]
    end

    if data then
      serialized = LibAceSerializer:Serialize(data);  -- serializes tables to a string
    end

    if serialized then
      compressed = LibDeflate:CompressDeflate(serialized, {level = 9})
    end

    if compressed then
      local encoded_data = LibDeflate:EncodeForPrint(compressed)
      if encoded_data then
        MonDKP:Print("Export success");
        return encoded_data
      end
    end
    MonDKP:Print("Export error");
  elseif order == "import" then -- import
    if not data then
      return
  end
  compressed = LibDeflate:DecodeForPrint(input_data)
  serialized = LibDeflate:DecompressDeflate(compressed)
  local success, data = LibAceSerializer:Deserialize(serialized);

  if success then
    if data["MonDKP_DB"] then
      -- Backup pricate settings that are localted in the DB
      local backup = {
        ["bidpos"] = _G["MonDKP_DB"].bidpos,
        ["bidintpos"] = _G["MonDKP_DB"].bidintpos,
        ["timerpos"] = _G["MonDKP_DB"].timerpos,
        ["defaults"] = _G["MonDKP_DB"].defaults
      }
      -- Load sync data
      _G["MonDKP_DB"] = data["MonDKP_DB"]
      -- Load backed up data
      _G["MonDKP_DB"].bidpos = backup["bidpos"]
      _G["MonDKP_DB"].bidintpos = backup["bidintpos"]
      _G["MonDKP_DB"].timerpos = backup["timerpos"]
      _G["MonDKP_DB"].defaults = backup["defaults"]

    end
    for _,var in pairs(savedVariables) do
      if data[var] then
        _G[var] = data[var]
      end
    end
    MonDKP:Print("Import success");
  else
    MonDKP:Print("Import error");
  end
  end
  return nil
end

local function GenerateDKPTables(table, format)
  local ExportString;
  local ExportDefinition;

  if table == "FullExport" then
    ExportString = SavedVariablesSync("export")
    MonDKPExportBoxEditBox:SetText(ExportString)
    return;
  end

  if table == "FullImport" then
    SavedVariablesSync("import", MonDKPExportBoxEditBox:GetText())

    StaticPopupDialogs["SUGGEST_RELOAD"] = {
      text = "|CFFFF0000"..L["WARNING"].."|r: "..L["MUSTRELOADUI"],
      button1 = L["YES"],
      button2 = L["NO"],
      OnAccept = function()
        ReloadUI();
      end,
      timeout = 0,
      whileDead = true,
      hideOnEscape = true,
      preferredIndex = 3,
    }
    StaticPopup_Show ("SUGGEST_RELOAD")

    return;
  end

  if format == "HTML" then
    if table == MonDKP_DKPTable then
      ExportString = "<html>\n<script>\nfunction openTab(tabName) {\n   var i;\n   var x = document.getElementsByClassName(\"tab\");\n   for (i = 0; i < x.length; i++) {\n      x[i].style.display = \"none\";\n   }\n   document.getElementById(tabName).style.display = \"block\";\n}\n</script>\n";
      ExportString = ExportString.."<script>var whTooltips = {colorLinks: true, iconizeLinks: true, renameLinks: true};</script><script src=\"https://wow.zamimg.com/widgets/power.js\"></script>\n"
      ExportString = ExportString.."<style>\nhtml { background-color: #000; };\n.divTable{ display: table; float: left; margin: 10px 10px; }\n.divTableRow { display: table-row; background-color: #000}\n.divTableRow:hover { background-color: #222; }\n.divTableHeading { background-color: #EEE; display: table-header-group; }\n.divTableCell, .divTableHead { border: 1px solid #999999; display: table-cell; padding: 3px 10px; }\n";
      ExportString = ExportString..".divPlayer { border: 1px solid #999999; display: table-cell; width: 700px; padding: 3px 10px; text-align: left; vertical-align: middle; word-wrap: normal; color: #ffffff; }\n.divClass { border: 1px solid #999999; display: table-cell; padding: 3px 10px; text-align: center; vertical-align: middle; color: #ffffff; }\n.divDKP { border: 1px solid #999999; display: table-cell; width: 200px%; padding: 3px 10px; text-align: center; vertical-align: middle; color: #ffffff; }\n"
      ExportString = ExportString..".divPlayerHeader { border: 1px solid #999999; display: table-cell; font-weight: bold; width: 50%; padding: 3px 10px; text-align: left; background-color: #bbb; }\n.divClassHeader { border: 1px solid #999999; display: table-cell; font-weight: bold; width: 150px; padding: 3px 10px; text-align: center; background-color: #bbb; }\n.divDKPHeader { border: 1px solid #999999; display: table-cell; font-weight: bold; width: 30%; padding: 3px 10px; text-align: center; background-color: #bbb; }\n"
      ExportString = ExportString..".divTableHeading { background-color: #EEE; display: table-header-group; font-weight: bold; }\n.divTableFoot { background-color: #EEE; display: table-footer-group; font-weight: bold; }\n.divTableBody { display: table-row-group; }\n</style>\n\n"
      ExportString = ExportString.."<br /><br />\n<div>\n   <button onclick=\"openTab('DKP')\">DKP Table</button>\n   <button onclick=\"openTab('DKPHistory')\">DKP History</button>\n   <button onclick=\"openTab('LootHistory')\">Loot History</button>\n</div>\n<br /><br />\n"

      ExportString = ExportString.."<div id=\"DKP\" class=\"tab\"><div class=\"divTable\" style=\"width: 30%;border: 1px solid #000;\">\n   <div class=\"divTableBody\">\n      <div class=\"divTableRow\">\n         <div class=\"divPlayerHeader\">Player</div>\n         <div class=\"divClassHeader\">Class</div>\n         <div class=\"divDKPHeader\">DKP</div>\n      </div>\n"

      for i=1, #MonDKP_DKPTable do
        ExportString = ExportString.."      <div class=\"divTableRow\">\n         <div class=\"divPlayer\">"..MonDKP_DKPTable[i].player.."</div>\n         <div class=\"divClass\" style=\"width: 150px;\"><img src=\"https://wow.zamimg.com/images/wow/icons/large/classicon_"..strlower(MonDKP_DKPTable[i].class)..".jpg\" height=\"24\" width=\"24\" /></div>\n         <div class=\"divDKP\">"..MonDKP_DKPTable[i].dkp.."</div>\n      </div>\n"
      end

      ExportString = ExportString.."   </div>\n</div>\n</div>"
    elseif table == MonDKP_DKPHistory then
      local numrows;

      if #MonDKP_DKPHistory > 200 then
        numrows = 200;
      else
        numrows = #MonDKP_DKPHistory
      end

      ExportString = "<div id=\"DKPHistory\" class=\"tab\" style=\"display:none;\"><div class=\"divTable\" style=\"width: 95%;border: 1px solid #000;\">\n   <div class=\"divTableBody\">\n      <div class=\"divTableRow\">\n         <div class=\"divPlayerHeader\">Players</div>\n         <div class=\"divClassHeader\" style=\"width: 4%;\">DKP</div>\n         <div class=\"divDKPHeader\">Date/Reason</div>\n      </div>\n"

      for i=1, numrows do
        ExportString = ExportString.."      <div class=\"divTableRow\">\n         <div class=\"divPlayer\" style=\"font-size: 0.7em; width: 71%;\">"..gsub(MonDKP_DKPHistory[i].players, ",", ", ").."</div>\n         <div class=\"divClass\" style=\"width: 4%;\">"..MonDKP_DKPHistory[i].dkp.."</div>\n         <div class=\"divDKP\" style=\"width: 25%; font-size: 0.7em;\">"..MonDKP_DKPHistory[i].reason.."<br />("..date("%m/%d/%y %H:%M:%S", MonDKP_DKPHistory[i].date)..") </div>\n      </div>\n"
      end
      ExportString = ExportString.."   </div>\n</div>\n</div>"

    elseif table == MonDKP_Loot then
      local numrows;

      if #MonDKP_Loot > 200 then
        numrows = 200;
      else
        numrows = #MonDKP_Loot
      end
      ExportString = "<div id=\"LootHistory\" class=\"tab\" style=\"display:none;\"><div class=\"divTable\" style=\"width: 50%;border: 1px solid #000;\">\n   <div class=\"divTableBody\">\n      <div class=\"divTableRow\">\n         <div class=\"divPlayerHeader\">Loot</div>\n         <div class=\"divClassHeader\">Player</div>\n         <div class=\"divDKPHeader\">From</div>\n      </div>\n"
      for i=1, numrows do
        local cur = MonDKP_Loot[i].loot
        local itemNumber = strsub(cur, string.find(cur, "Hitem:")+6, string.find(cur, ":", string.find(cur, "Hitem:")+6)-1)
        ExportString = ExportString.."      <div class=\"divTableRow\">\n         <div class=\"divPlayer\" style=\"width: 40%;\"><a href=\"https://classic.wowhead.com/item="..itemNumber.."\" data-wowhead=\"item="..itemNumber.."\"></a> ("..MonDKP_Loot[i].cost.." DKP)</div>\n         <div class=\"divClass\" style=\"width: 20%;\">"..MonDKP_Loot[i].player.."</div>\n         <div class=\"divDKP\" style=\"width: 40%; font-size: 0.7em;\">"..MonDKP_Loot[i].zone..": "..MonDKP_Loot[i].boss.."<br />("..date("%m/%d/%y %H:%M:%S", MonDKP_Loot[i].date)..") </div>\n      </div>\n"
      end
      ExportString = ExportString.."   </div>\n</div>\n</div>\n</html>"
    end
  elseif format == "CSV" then
    if table == "Activity" then
      local limit = time() - 30*24*60*60
      local activePlayers = {}
      GetActivePlayersTable(limit, activePlayers)
      ExportString = ActivePlayersTableToCSV(activePlayers)
    elseif table == MonDKP_DKPTable then
      Headers = "player;class;DKP;previousDKP;lifetimeGained;lifetimeSpent\n"
      ExportString = Headers.."";
      for i=1, #MonDKP_DKPTable do
        if i == #MonDKP_DKPTable then
          ExportString = ExportString..MonDKP_DKPTable[i].player..";"..MonDKP_DKPTable[i].class..";"..MonDKP_DKPTable[i].dkp..";"..MonDKP_DKPTable[i].previous_dkp..";"..MonDKP_DKPTable[i].lifetime_gained..";"..MonDKP_DKPTable[i].lifetime_spent;
        else
          ExportString = ExportString..MonDKP_DKPTable[i].player..";"..MonDKP_DKPTable[i].class..";"..MonDKP_DKPTable[i].dkp..";"..MonDKP_DKPTable[i].previous_dkp..";"..MonDKP_DKPTable[i].lifetime_gained..";"..MonDKP_DKPTable[i].lifetime_spent.."\n";
        end
      end
    elseif table == MonDKP_DKPHistory then
      local numrows;

      if #MonDKP_DKPHistory > 200 then
        numrows = 200;
      else
        numrows = #MonDKP_DKPHistory
      end

      Headers = "player;DKP;date;reason\n"
      ExportString = Headers.."";
      for i=1, numrows do
        local PlayerString = strsub(MonDKP_DKPHistory[i].players, 1, -2)

        if i == numrows then
          ExportString = ExportString.."\""..PlayerString.."\""..";"..MonDKP_DKPHistory[i].dkp..";"..MonDKP_DKPHistory[i].date..";".."\""..MonDKP_DKPHistory[i].reason.."\"";
        else
          ExportString = ExportString.."\""..PlayerString.."\""..";"..MonDKP_DKPHistory[i].dkp..";"..MonDKP_DKPHistory[i].date..";".."\""..MonDKP_DKPHistory[i].reason.."\"".."\n";
        end
      end
    elseif table == MonDKP_Loot then
      local numrows;

      if #MonDKP_Loot > 200 then
        numrows = 200;
      else
        numrows = #MonDKP_Loot
      end

      Headers = "player;itemName;itemNumber;zone;boss;date;cost\n"
      ExportString = Headers.."";
      for i=1, numrows do
        local cur = MonDKP_Loot[i].loot
        local itemNumber = strsub(cur, string.find(cur, "Hitem:")+6, string.find(cur, ":", string.find(cur, "Hitem:")+6)-1)
        local itemName = strsub(cur, string.find(cur, "::|h%[")+5, string.find(cur, "%]", string.find(cur, "::|h%[")+5)-1)

        if i == numrows then
          ExportString = ExportString..MonDKP_Loot[i].player..";".."\""..itemName.."\""..";"..itemNumber..";".."\""..MonDKP_Loot[i].zone.."\""..";"..MonDKP_Loot[i].boss..";"..MonDKP_Loot[i].date..";"..MonDKP_Loot[i].cost;
        else
          ExportString = ExportString..MonDKP_Loot[i].player..";".."\""..itemName.."\""..";"..itemNumber..";".."\""..MonDKP_Loot[i].zone.."\""..";"..MonDKP_Loot[i].boss..";"..MonDKP_Loot[i].date..";"..MonDKP_Loot[i].cost.."\n";
        end
      end
    end
  elseif format == "XML" then
    if table == MonDKP_DKPTable then
      ExportString = "<dkptable>\n";
      for i=1, #MonDKP_DKPTable do
        ExportString = ExportString.."    <dkpentry>\n        <player>"..MonDKP_DKPTable[i].player.."</player>\n        <class>"..MonDKP_DKPTable[i].class.."</class>\n        <dkp>"..MonDKP_DKPTable[i].dkp.."</dkp>\n        <lifetimegained>"..MonDKP_DKPTable[i].lifetime_gained.."</lifetimegained>\n        <lifetimespent>"..MonDKP_DKPTable[i].lifetime_spent.."</lifetimespent>\n    </dkpentry>\n";
      end
      ExportString = ExportString.."</dkptable>"
    elseif table == MonDKP_DKPHistory then
      local numrows;

      if #MonDKP_DKPHistory > 200 then
        numrows = 200;
      else
        numrows = #MonDKP_DKPHistory
      end

      ExportString = "<dkphistory>\n";
      for i=1, numrows do
        local deletes;
        local deletedby;
        if MonDKP_DKPHistory[i].deletes == nil then
          deletes = ''
        else
          deletes = MonDKP_DKPHistory[i].deletes
        end

        if MonDKP_DKPHistory[i].deletedby == nil then
          deletedby = ''
        else
          deletedby = MonDKP_DKPHistory[i].deletedby
        end

        ExportString = ExportString.."    <historyentry>\n        <playerstring>"..MonDKP_DKPHistory[i].players.."</playerstring>\n        <dkp>"..MonDKP_DKPHistory[i].dkp.."</dkp>\n        <timestamp>"..MonDKP_DKPHistory[i].date.."</timestamp>\n        <reason>"..MonDKP_DKPHistory[i].reason.."</reason>\n        <deletes>"..deletes.."</deletes>\n        <deletedby>"..deletedby.."</deletedby>\n    </historyentry>\n";
      end
      ExportString = ExportString.."</dkphistory>";
    elseif table == MonDKP_Loot then
      local numrows;

      if #MonDKP_Loot > 200 then
        numrows = 200;
      else
        numrows = #MonDKP_Loot
      end

      ExportString = "<loothistory>\n";
      for i=1, numrows do
        local cur = MonDKP_Loot[i].loot
        local itemNumber = strsub(cur, string.find(cur, "Hitem:")+6, string.find(cur, ":", string.find(cur, "Hitem:")+6)-1)
        local itemName = strsub(cur, string.find(cur, "::|h%[")+5, string.find(cur, "%]", string.find(cur, "::|h%[")+5)-1)

        local deletes;
        local deletedby;
        if MonDKP_Loot[i].deletes == nil then
          deletes = ''
        else
          deletes = MonDKP_Loot[i].deletes
        end

        if MonDKP_Loot[i].deletedby == nil then
          deletedby = ''
        else
          deletedby = MonDKP_Loot[i].deletedby
        end

        ExportString = ExportString.."    <lootentry>\n        <player>"..MonDKP_Loot[i].player.."</player>\n        <itemname>"..itemName.."</itemname>\n        <itemnumber>"..itemNumber.."</itemnumber>\n        <zone>"..MonDKP_Loot[i].zone.."</zone>\n        <boss>"..MonDKP_Loot[i].boss.."</boss>\n        <timestamp>"..MonDKP_Loot[i].date.."</timestamp>\n        <cost>"..MonDKP_Loot[i].cost.."</cost>\n        <deletes>"..deletes.."</deletes>\n        <deletedby>"..deletedby.."</deletedby>\n    </lootentry>\n";
      end
      ExportString = ExportString.."</loothistory>";
    end
  elseif format == "JSON" then
    if table == MonDKP_DKPTable then
      ExportString = "This opperation is currently not supported";
    elseif table == MonDKP_DKPHistory then
      ExportString = "This opperation is currently not supported";
    elseif table == MonDKP_Loot then
      local numberOfLootEntries = #MonDKP_Loot;

      ExportString = '{"items":[';
      for entryIndex = 1, numberOfLootEntries do
        local entry = MonDKP_Loot[entryIndex];
        local cur = entry.loot;
        local itemId = strsub(cur, string.find(cur, 'Hitem:') + 6, string.find(cur, ':', string.find(cur, 'Hitem:') + 6) -1);

        -- Make sure awardedFor is positive, paying someone to get an item sounds wrong
        if entry.cost < 0 then
          awardedFor = entry.cost * -1;
        else
          awardedFor = entry.cost;
        end

        if entry.zone == nil then
          awardedIn = '';
        else
          awardedIn = entry.zone
        end

        ExportString = ExportString..string.format('{"itemId":%s,"awardedOn":%s,"awardedTo":"%s","awardedFor":%s,"awardedIn":"%s"}',
          itemId,
          entry.date,
          entry.player,
          awardedFor,
          awardedIn
        );

        -- there are more entries coming so add a comma (,)
        if entryIndex ~= numberOfLootEntries then
          ExportString = ExportString..',';
        end
      end
      ExportString = ExportString.."],";
      ExportString = ExportString..'"bids":[';

      local numberOfBidEntries = #MonDKP_DB.allbids;
      for entryIndex = 1, numberOfBidEntries do
        local entry = MonDKP_DB.allbids[entryIndex];
        local itemId = strsub(entry.item, string.find(entry.item, 'Hitem:') + 6, string.find(entry.item, ':', string.find(entry.item, 'Hitem:') + 6) -1);

        ExportString = ExportString..string.format('{"itemId":%s,"on":%s,"by":"%s","bid":%s}',
          itemId,
          entry.on,
          entry.player,
          entry.bid
        );

        -- there are more entries coming so add a comma (,)
        if entryIndex ~= numberOfBidEntries then
          ExportString = ExportString..',';
        end
      end
      ExportString = ExportString.."]}";
    end
  end


  MonDKPExportBoxEditBox:SetText(ExportString)
end

function MonDKPExportBox_Show(text)
  if not MonDKPExportBox then
    local f = CreateFrame("Frame", "MonDKPExportBox", UIParent)
    f:SetPoint("CENTER")
    f:SetSize(850, 590)

    f:SetBackdrop({
      bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
      edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight", -- this one is neat
      edgeSize = 17,
      insets = { left = 8, right = 6, top = 8, bottom = 8 },
    })
    f:SetBackdropBorderColor(0, .44, .87, 0.5) -- darkblue

    -- Movable
    f:SetMovable(true)
    f:SetClampedToScreen(true)
    f:SetScript("OnMouseDown", function(self, button)
      if button == "LeftButton" then
        self:StartMoving()
      end
    end)
    f:SetScript("OnMouseUp", f.StopMovingOrSizing)

    -- Close Button
    f.closeContainer = CreateFrame("Frame", "MonDKPTitle", f)
    f.closeContainer:SetPoint("CENTER", f, "TOPRIGHT", -4, 0)
    f.closeContainer:SetBackdrop({
      bgFile   = "Textures\\white.blp", tile = true,
      edgeFile = "Interface\\AddOns\\EssentialDKP\\Media\\Textures\\edgefile.tga", tile = true, tileSize = 1, edgeSize = 3,
    });
    f.closeContainer:SetBackdropColor(0,0,0,0.9)
    f.closeContainer:SetBackdropBorderColor(1,1,1,0.2)
    f.closeContainer:SetSize(28, 28)

    f.closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    f.closeBtn:SetPoint("CENTER", f.closeContainer, "TOPRIGHT", -14, -14)
    tinsert(UISpecialFrames, f:GetName()); -- Sets frame to close on "Escape"

    -- ScrollFrame
    local sf = CreateFrame("ScrollFrame", "MonDKPExportBoxScrollFrame", MonDKPExportBox, "UIPanelScrollFrameTemplate")
    sf:SetPoint("LEFT", 20, 0)
    sf:SetPoint("RIGHT", -32, 0)
    sf:SetPoint("TOP", 0, -20)
    sf:SetPoint("BOTTOM", 0, 160)

    -- Description
    f.desc = f:CreateFontString(nil, "OVERLAY")
    f.desc:SetFontObject("MonDKPSmallLeft");
    f.desc:SetPoint("TOPLEFT", sf, "BOTTOMLEFT", 10, -10);
    f.desc:SetText("|CFFAEAEDDExport below one at a time in order. Copy all html and paste into local .html file one after the other. DKP and Loot History often take a few seconds to generate and will lock your screen briefly. As a result they are limited to the most recent 200 entries for each. All tables will be tabbed for convenience.|r");
    f.desc:SetWidth(sf:GetWidth()-30)

    -- EditBox
    local eb = CreateFrame("EditBox", "MonDKPExportBoxEditBox", MonDKPExportBoxScrollFrame)
    eb:SetSize(sf:GetSize())
    eb:SetMultiLine(true)
    eb:SetAutoFocus(false) -- dont automatically focus
    eb:SetFontObject("ChatFontNormal")
    eb:SetScript("OnEscapePressed", function() f:Hide() end)
    sf:SetScrollChild(eb)

    -- Resizable
    f:SetResizable(true)
    f:SetMinResize(850, 500)

    local rb = CreateFrame("Button", "MonDKPExportBoxResizeButton", MonDKPExportBox)
    rb:SetPoint("BOTTOMRIGHT", -6, 7)
    rb:SetSize(16, 16)

    rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

    rb:SetScript("OnMouseDown", function(self, button)
      if button == "LeftButton" then
        f:StartSizing("BOTTOMRIGHT")
      end
    end)
    rb:SetScript("OnMouseUp", function(self, button)
      f:StopMovingOrSizing()
      self:GetHighlightTexture():Show()
      eb:SetWidth(sf:GetWidth())
      f.desc:SetWidth(sf:GetWidth()-30)
    end)
    f:Show()

    f.ImportDataButton = MonDKP:CreateButton("BOTTOMLEFT", f, "BOTTOMLEFT", 200, 45, "Import");
    f.ImportDataButton:SetSize(150, 24)
    f.ImportDataButton:SetScript("OnClick", function()
      GenerateDKPTables("FullImport", nil)
    end)

    f.ExportDataButton = MonDKP:CreateButton("BOTTOMLEFT", f, "BOTTOMLEFT", 200, 20, "Export");
    f.ExportDataButton:SetSize(150, 24)
    f.ExportDataButton:SetScript("OnClick", function()
      GenerateDKPTables("FullExport", nil)
    end)

    -- Begin officer only buttons
    if core.IsOfficer then
      -- Format DROPDOWN box
      local CurFormat;

      f.FormatDropDown = CreateFrame("FRAME", "MonDKPModeSelectDropDown", f, "MonolithDKPUIDropDownMenuTemplate")
      f.FormatDropDown:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 20, 55)
      UIDropDownMenu_SetWidth(f.FormatDropDown, 100)
      UIDropDownMenu_SetText(f.FormatDropDown, "Select Format")

      -- Create and bind the initialization function to the dropdown menu
      UIDropDownMenu_Initialize(f.FormatDropDown, function(self, level, menuList)
        local Format = UIDropDownMenu_CreateInfo()
        Format.func = self.SetValue
        Format.fontObject = "MonDKPSmallCenter"
        Format.text, Format.arg1, Format.checked, Format.isNotRadio = "HTML", "HTML", "HTML" == CurFormat, false
        UIDropDownMenu_AddButton(Format)
        Format.text, Format.arg1, Format.checked, Format.isNotRadio = "CSV", "CSV", "CSV" == CurFormat, false
        UIDropDownMenu_AddButton(Format)
        Format.text, Format.arg1, Format.checked, Format.isNotRadio = "XML", "XML", "XML" == CurFormat, false
        UIDropDownMenu_AddButton(Format)
        Format.text, Format.arg1, Format.checked, Format.isNotRadio = "JSON", "JSON", "JSON" == CurFormat, false
        UIDropDownMenu_AddButton(Format)
      end)

      -- Dropdown Menu Function
      function f.FormatDropDown:SetValue(arg1)
        CurFormat = arg1;
        if arg1 == "HTML" then
          ExportDefinition = "|CFFAEAEDDExport below one at a time in order. Copy all html and paste into local .html file one after the other. DKP and Loot History often take a few seconds to generate and will lock your screen briefly. As a result they are limited to the most recent 200 entries for each. All tables will be tabbed for convenience.|r"
        elseif arg1 == "CSV" then
          ExportDefinition = "|CFFAEAEDDCSV can only be used for applications designed specifically to distribute each value to the correct variable. Generate them one at a time (in order) and copy/paste all contents, one after the other, and use as needed.|r"
        elseif arg1 == "XML" then
          ExportDefinition = "|CFFAEAEDDGenerate tables one at a time and copy/paste all contents into a new .xml file on your desktop. XML files are for use with web applications designed to parse this XML format.|r"
        end

        f.desc:SetText(ExportDefinition);
        UIDropDownMenu_SetText(f.FormatDropDown, CurFormat)
        CloseDropDownMenus()
      end

      f.FormatDropDown:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetText("Export Format", 0.25, 0.75, 0.90, 1, true);
        GameTooltip:AddLine("Select the format you wish to export data with.", 1.0, 1.0, 1.0, true);
        GameTooltip:Show();
      end)
      f.FormatDropDown:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
      end)

      StaticPopupDialogs["NO_FORMAT"] = {
        text = "You do not have a format selected.",
        button1 = "Ok",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
      }

      f.GenerateActivityButton = MonDKP:CreateButton("BOTTOMRIGHT", f, "BOTTOMRIGHT", -200, 45, "1) "..L["GENACTIVITY"]);
      f.GenerateActivityButton:SetSize(150, 24)
      f.GenerateActivityButton:SetScript("OnClick", function()
        if CurFormat then
          GenerateDKPTables("Activity", CurFormat)
        else
          StaticPopup_Show ("NO_FORMAT")
        end
      end)

      f.GenerateDKPButton = MonDKP:CreateButton("BOTTOMRIGHT", f, "BOTTOMRIGHT", -200, 20, "2) "..L["GENDKPTABLE"]);
      f.GenerateDKPButton:SetSize(150, 24)
      f.GenerateDKPButton:SetScript("OnClick", function()
        if CurFormat then
          GenerateDKPTables(MonDKP_DKPTable, CurFormat)
        else
          StaticPopup_Show ("NO_FORMAT")
        end
      end)

      f.GenerateDKPHistoryButton = MonDKP:CreateButton("BOTTOMRIGHT", f, "BOTTOMRIGHT", -45, 45, "3) "..L["GENDKPHIST"]);
      f.GenerateDKPHistoryButton:SetSize(150, 24)
      f.GenerateDKPHistoryButton:SetScript("OnClick", function()
        if CurFormat then
          GenerateDKPTables(MonDKP_DKPHistory, CurFormat)
        else
          StaticPopup_Show ("NO_FORMAT")
        end
      end)

      f.GenerateDKPLootButton = MonDKP:CreateButton("BOTTOMRIGHT", f, "BOTTOMRIGHT", -45, 20, "4) "..L["GENLOOTHIST"]);
      f.GenerateDKPLootButton:SetSize(150, 24)
      f.GenerateDKPLootButton:SetScript("OnClick", function()
        if CurFormat then
          GenerateDKPTables(MonDKP_Loot, CurFormat)
        else
          StaticPopup_Show ("NO_FORMAT")
        end
      end)
    end
    -- End officer only buttons
    f.SelectAllButton = MonDKP:CreateButton("BOTTOMLEFT", f, "BOTTOMLEFT", 45, 20, L["SELECTALL"]);
    f.SelectAllButton:SetSize(50, 20)
    f.SelectAllButton:SetScript("OnClick", function()
      MonDKPExportBoxEditBox:HighlightText()
      MonDKPExportBoxEditBox:SetFocus()
    end)

    f.ClearButton = MonDKP:CreateButton("BOTTOMLEFT", f, "BOTTOMLEFT", 100, 20, "Clear");
    f.ClearButton:SetSize(50, 20)
    f.ClearButton:SetScript("OnClick", function()
      MonDKPExportBoxEditBox:SetText("")
    end)

  end

  if text then
    MonDKPExportBoxEditBox:SetText(text)
  end
  MonDKPExportBox:Show()
end

function MonDKP:ToggleExportWindow()
  MonDKPExportBox_Show()
end

local function GenerateActiveRaidersTable(table)
  local MONTH_SECONDS = 60*60*24*30;

end
