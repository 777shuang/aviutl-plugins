■本規約について■
Copyright (c) 2022 黒猫大福@roku10shi
Released under the MIT license

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


■本プログラムについて■
「黒猫大福」（以下、私という）が、「ごちゃまぜドロップス」と「Markdown、MarkdownEX、Markdown+EX」を使って
簡単にAviUtlの拡張編集にドラッグ＆ドロップできるように作成したプログラムです。

■ごちゃまぜドロップスについて■
「ごちゃまぜドロップス」は拡張編集ウィンドウへファイルやテキストをドラッグ＆ドロップした時の挙動を拡張するための AviUtl プラグインです。

・ごちゃまぜドロップスのGithub
https://github.com/oov/aviutl_gcmzdrops

・おおぶ様のTwitter
https://twitter.com/oovch

■Markdown、MarkdownEX、Markdown+EXについて■
「Markdown」はaviutl_browser向けのサンプルスクリプトです。
Markdown形式のテキストを表示するスクリプトです。

「MarkdownEX」はaviutl_browser向けの追加スクリプトです。
Markdownを拡張し追加で表や数式や絵文字を表示するスクリプトです。

・MarkdownEXの動画
https://www.nicovideo.jp/watch/sm38814110

「Markdown+EX」はaviutl_browser向けの追加スクリプトです。
MarkdownEXを拡張し追加でLaTeXマクロの登録や独自のMarkdown記法が追加できます。

・Markdown+EXの動画
https://www.nicovideo.jp/watch/sm42220656

■aviutl_browserについて■
AviUtl の拡張編集プラグイン上でブラウザーの表示内容を持ち込めるようにするためのプログラムです。

・aviutl_browserのGithub
https://github.com/oov/aviutl_browser

■bridge.dllについて■
拡張編集で Lua から外部プログラムを使って処理をしやすくするためのプラグインです。

・aviutl_browserのGithub
https://github.com/oov/aviutl_browser

■利用方法について■
使い方、ごちゃまぜドロップス（0.4.0beta9で動作確認済み）とbridge.dllとaviutl_browserをインストールします。
同梱の「GCMZDrops」フォルダを「exedit.auf」が存在するフォルダにドラッグ＆ドロップします。

そして利用したいMarkdownスクリプトを導入してください。

拡張編集に「*.md」ファイルをドラッグ＆ドロップすると導入されているスクリプトによって「Markdown+EX」または「MarkdownEX」のカスタムオブジェクトが設置されます。
「Shiftキー」を押しながらドラッグ＆ドロップすると「Markdown+EX」または「MarkdownEX」または「Markdown」のテキストオブジェクトが設置されます。

md2MarkdownEX.iniについて
本スクリプトの設定ファイルです。
「Markdown+EX」または「MarkdownEX」のときのみ利用されます。
CSSのプリセットの登録とプリセット選択機能のON、OFFに使っています。

CSSのプリセットをファイル毎に設定するときはtureにしてください。
[settings]
checkcss=false


デフォルト設定です。プリセット選択機能がOFFの場合でも使われます。
セクションが存在しない場合はスクリプトの定義が優先されます。
[default]
Markdown=markdown
Highlights=github
Emoji=default


プリセットのサンプルです。
CSS自体は「Markdown+EX」または「MarkdownEX」のcssフォルダ内のものが利用されます。
[css1]
Markdown=sample_markdown
Highlights=github_markdown
Emoji=default_markdown


■連絡先■

本プログラムについてお問い合わせがある場合は、
運営のTwitterのダイレクトメッセージよりお願いいたします。
https://twitter.com/roku10shi


■制定日■

2023年08月11日