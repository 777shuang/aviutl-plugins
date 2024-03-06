local P = {}

P.name = "svgファイルの exo 化"

P.priority = 2000

function P.ondragenter(files, state)
  for i, v in ipairs(files) do
    local ext = v.filepath:match("[^.]+$"):lower()
    if "svg" == ext then
      print("拡張子:" .. ext)
      -- ファイルの拡張子が json のファイルがあったら処理できそうなので true
      return true
    end
  end
  return false
end

function P.ondragover(files, state)
  -- ondragenterで処理できる、もしくは処理できそうな場合は true を返してください。
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

-- ondrop はマウスボタンが離され、ファイルがドロップされた時に呼ばれます。
-- ただし ondragenter や ondragover で false を返していた場合は呼ばれません。
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
        -- ファイルの拡張子が json のファイルがあったら処理できそうなので
        filepath = v.filepath
        -- ファイルを直接読み込む代わりに exo ファイルを組み立てる
        math.randomseed(os.time())
        exo = exo .. [[
[]] .. i - 1 .. [[]
start=1
end=128
layer=]] .. i .. "\r\n" .. [[
overlay=1
camera=0
[]] .. i - 1 .. [[.0]
_name=]] .. (jp and [[カスタムオブジェクト]] or [[Custom object]]) .. "\r\n" .. [[
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
_name=]] .. (jp and [[標準描画]] or [[Standard drawing]]) .. "\r\n" .. [[
X=0.0
Y=0.0
Z=0.0
]] .. (jp and [[拡大率]] or [[Zoom%]]) .. [[=100.00
]] .. (jp and [[透明度]] or [[Clearness]]) .. [[=0.0
]] .. (jp and [[回転\]] or [[Rotation]]) .. [[=0.00
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
      print("[" .. P.name .. "] が  を exo ファイルに差し替えました。元のファイルは orgfilepath で取得できます。")

      return { { filepath = filepath } }, state
    end
    -- 他のイベントハンドラーにも処理をさせたいのでここは常に false
  return false
end

return P
