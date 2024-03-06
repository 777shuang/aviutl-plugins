local P = {}

P.name = "svg�t�@�C���� exo ��"

P.priority = 2000

function P.ondragenter(files, state)
  for i, v in ipairs(files) do
    local ext = v.filepath:match("[^.]+$"):lower()
    if "svg" == ext then
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
    local dropflag = false
    local proj = GCMZDrops.getexeditfileinfo()
    local jp = not GCMZDrops.englishpatched()
    local exo = [[
[exedit]
width=]] .. proj.width .. "\r\n" .. [[
height=]] .. proj.height .. "\r\n" .. [[
rate=]] .. proj.rate .. "\r\n" .. [[
scale=]] .. proj.scale .. "\r\n" .. [[
length=64
audio_rate=]] .. proj.audio_rate .. "\r\n" .. [[
audio_ch=]] .. proj.audio_ch .. "\r\n"
    for i, v in ipairs(files) do
      local ext = v.filepath:match("[^.]+$"):lower()
      if "svg" == ext then
        dropflag = true
        -- �t�@�C���̊g���q�� json �̃t�@�C�����������珈���ł������Ȃ̂�
        filepath = v.filepath
        -- �t�@�C���𒼐ړǂݍ��ޑ���� exo �t�@�C����g�ݗ��Ă�
        math.randomseed(os.time())
        exo = exo .. [[
[]] .. i - 1 .. [[]
start=1
end=128
layer=]] .. i .. "\r\n" .. [[
overlay=1
camera=0
[]] .. i - 1 .. [[.0]
_name=]] .. (jp and [[�J�X�^���I�u�W�F�N�g]] or [[Custom object]]) .. "\r\n" .. [[
track0=100.00
track1=0.00
track2=0.00
track3=0.00
check0=0
type=0
filter=2
name=Basic@svgrender-JP
param=file=]] .. P.encodelua(filepath) .. "\r\n" .. [[
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
      local filepath = GCMZDrops.createtempfile("ILM", ".exo")

      f, err = io.open(filepath, "wb")
      if f == nil then
        error(err)
      end
      f:write(exo)
      f:close()
      print("[" .. P.name .. "] ��  �� exo �t�@�C���ɍ����ւ��܂����B���̃t�@�C���� orgfilepath �Ŏ擾�ł��܂��B")

      return { { filepath = filepath } }, state
    end
    -- ���̃C�x���g�n���h���[�ɂ����������������̂ł����͏�� false
  return false
end

return P
