local P = {}

P.name = "md�t�@�C���� exo ��"

P.priority = 2000

local scriptNames = { "Markdown+EX", "MarkdownEX","Markdown" }

local function trimextension(filepath)
  local ext = filepath:match(".[^.]+$"):lower()
  return filepath:sub(1, #filepath - #ext)
end

local function fileread(filepath)
  print(filepath)
  local f = io.open(filepath, "rb")
  if f == nil then
    return nil
  end
  local b = f:read("*all")
  f:close()
  
  if b:sub(-1) ~= "\n" then
    b = b .. "\r\n"
  end
  local str = ""
  for line in b:gmatch("(.-)\r?\n") do
    str = str .. line .. "\r\n"
  end
  return str
end

local function checkANM()
  local scriptdir = GCMZDrops.scriptdir() .. "..\\script\\browser\\"
  for si, sv in ipairs(scriptNames) do
    local f = io.open(scriptdir .. sv .. ".anm", "rb")
    if f ~= nil then
      f:close()
      return true,sv
    end
  end
  f:close()
  return false,""
end

local function checkCSS(filepath)
  local f = io.open(GCMZDrops.scriptdir() .. "md2MarkdownEX.ini", "rb")
  local pms,phs,pem = "github-markdown","github","default"
  if f ~= nil then
    local str = f:read("*all")
    local ini = GCMZDrops.inistring(str)
    local r, v = false,"default"
    if ini:get("settings", "checkcss", false) == "true" then
      r, v = GCMZDrops.prompt("���p����CSS�Z�b�g���w�肵�Ă�������", "default")
    end
    pms = ini:get(v, "Markdown", "github-markdown")
    phs = ini:get(v, "Highlights", "github")
    pem = ini:get(v, "Emoji", "default")
    f:close()
  end
  return pms,phs,pem
end

local function loadMD(filepath)
  local loadstr = fileread(filepath)
  if #loadstr > 900 then
    loadstr = string.sub(loadstr, 0, 900)
  end
  print(GCMZDrops.convertencoding(loadstr or "", "utf8", "sjis"))
  local str = [[<?markdown=[==[]] .. "\r\n" ..  
  GCMZDrops.convertencoding(loadstr or "", "utf8", "sjis") .. "\r\n" ..  [[
]==]?>]]
return str
end

function P.ondragenter(files, state)
  for i, v in ipairs(files) do
    local ext = v.filepath:match("[^.]+$"):lower()
    if ext == "md" then
      print("�g���q:" .. ext)
      -- �t�@�C���̊g���q�� json �̃t�@�C�����������珈���ł������Ȃ̂� true
      return true
    end
  end
  return false
end

function P.ondragover(files, state)
  -- ondragenter�ŏ����ł���A�������͏����ł������ȏꍇ�� true ��Ԃ��Ă��������B
  return true
end

function P.ondragleave()
end

function P.encodelua(s)
  s = GCMZDrops.convertencoding(s, "sjis", "utf8")
  s = GCMZDrops.encodeluastring(s)
  s = GCMZDrops.convertencoding(s, "utf8", "sjis")
  return s
end

-- ondrop �̓}�E�X�{�^����������A�t�@�C�����h���b�v���ꂽ���ɌĂ΂�܂��B
-- ������ ondragenter �� ondragover �� false ��Ԃ��Ă����ꍇ�͌Ă΂�܂���B
function P.ondrop(files, state)
  local checkFlg,scriptName = checkANM()
  if checkFlg then
    local dropflag = false
    local proj = GCMZDrops.getexeditfileinfo()
    local jp = not GCMZDrops.englishpatched()
    local exo = ""
    for i, v in ipairs(files) do
      local ext = v.filepath:match("[^.]+$"):lower()
      -- �t�@�C���̊g���q�� md �̃t�@�C�����������珈���ł������Ȃ̂�
      if ext == "md" and state["shift"] then
        dropflag = true
        local str = loadMD(v.filepath)
        local exastr = GCMZDrops.encodeexotext(str)
        local pms,phs,pem = checkCSS(v.filepath)
        -- �t�@�C���𒼐ړǂݍ��ޑ���� exo �t�@�C����g�ݗ��Ă�
        exo = exo .. [[
[exedit]
width=]] .. proj.width .. "\r\n" .. [[
height=]] .. proj.height .. "\r\n" .. [[
rate=]] .. proj.rate .. "\r\n" .. [[
scale=]] .. proj.scale .. "\r\n" .. [[
length=]] .. proj.length .. "\r\n" .. [[
audio_rate=]] .. proj.audio_rate .. "\r\n" .. [[
audio_ch=]] .. proj.audio_ch .. "\r\n" .. [[
[]] .. i - 1 .. [[]
start=1
end=]] .. (proj.length / (proj.length / proj.rate)) .. "\r\n" .. [[
layer=]] .. i .. "\r\n" .. [[
overlay=1
camera=0
[]] .. i - 1 .. [[.0]
_name=�e�L�X�g
�T�C�Y=1
�\�����x=0.0
�������ɌʃI�u�W�F�N�g=0
�ړ����W��ɕ\������=0
�����X�N���[��=0
B=0
I=0
type=0
autoadjust=0
soft=0
monospace=0
align=4
spacing_x=0
spacing_y=0
precision=0
color=ffffff
color2=000000
font=MS UI Gothic
text=]] .. exastr .. "\r\n"

if scriptName ~= "Markdown" then
exo = exo .. [[
[]] .. i - 1 .. [[.1]
_name=�A�j���[�V��������
track0=1600.00
track1=900.00
track2=190.00
track3=0.00
check0=0
type=0
filter=2
name=]] .. scriptName .. "\r\n" .. [[
param=pms="]] .. pms ..[[";phs="]] .. phs ..[[";pem="]] .. pem ..[[";]] .. "\r\n"
else
exo = exo .. [[
[]] .. i - 1 .. [[.1]
_name=�A�j���[�V��������
track0=1600.00
track1=900.00
track2=190.00
track3=0.00
check0=0
type=0
filter=2
name=]] .. scriptName .. "\r\n" .. [[
param=]] .. "\r\n"
end

exo = exo .. [[
[]] .. i - 1 .. [[.2]
_name=]] .. (jp and [[�W���`��]] or [[Standard drawing]]) .. "\r\n" .. [[
X=0.0
Y=0.0
Z=0.0
]] .. (jp and [[�g�嗦]] or [[Zoom%]]) .. [[=100.00
]] .. (jp and [[�����x]] or [[Clearness]]) .. [[=0.0
]] .. (jp and [[��]\]] or [[Rotation]]) .. [[=0.00
blend=0]] .. "\r\n"
        elseif ext == "md" and scriptName ~= "Markdown" then
          dropflag = true
          local pms,phs,pem = checkCSS(v.filepath)
          exo = exo .. [[
[exedit]
width=]] .. proj.width .. "\r\n" .. [[
height=]] .. proj.height .. "\r\n" .. [[
rate=]] .. proj.rate .. "\r\n" .. [[
scale=]] .. proj.scale .. "\r\n" .. [[
length=]] .. proj.length .. "\r\n" .. [[
audio_rate=]] .. proj.audio_rate .. "\r\n" .. [[
audio_ch=]] .. proj.audio_ch .. "\r\n" .. [[
[]] .. i - 1 .. [[]
start=1
end=]] .. (proj.length / (proj.length / proj.rate)) .. "\r\n" .. [[
layer=]] .. i .. "\r\n" .. [[
overlay=1
camera=0
[]] .. i - 1 .. [[.0]
_name=�J�X�^���I�u�W�F�N�g
track0=1600.00
track1=900.00
track2=100.00
track3=0.00
check0=0
type=0
filter=2
name=]] .. scriptName .. "\r\n" .. [[
param=file=]] .. P.encodelua(v.filepath) .. [[;pms="]] .. pms ..[[";phs="]] .. phs ..[[";pem="]] .. pem ..[[";
[]] .. i - 1 .. [[.1]
_name=]] .. (jp and [[�W���`��]] or [[Standard drawing]]) .. "\r\n" .. [[
X=0.0
Y=0.0
Z=0.0
]] .. (jp and [[�g�嗦]] or [[Zoom%]]) .. [[=100.00
]] .. (jp and [[�����x]] or [[Clearness]]) .. [[=0.0
]] .. (jp and [[��]\]] or [[Rotation]]) .. [[=0.00
blend=0]] .. "\r\n"
      end
    end
    if dropflag then
      local filepath = GCMZDrops.createtempfile("m2ME", ".exo")

      f, err = io.open(filepath, "wb")
      if f == nil then
        error(err)
      end
      f:write(exo)
      f:close()
      print("[" .. P.name .. "] ��  �� exo �t�@�C���ɍ����ւ��܂����B")

      return { { filepath = filepath } }, state
    end
    -- ���̃C�x���g�n���h���[�ɂ����������������̂ł����͏�� false
  end
  return false
end

return P
