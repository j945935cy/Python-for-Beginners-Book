我已經把 GitHub repo 結構需要依賴的幾個做法對過官方文件了。接下來直接給你一套「可讓 Codex 開始建專案」的完整骨架，會包含 README、AGENTS、建置腳本、HTML 與 EPUB 的內容配置。

Thought for 25s

可以。下面我直接給你一套適合用在 Codex / GitHub / HTML 電子書 / EPUB 的完整專案骨架，重點是：

內容用 Markdown 寫，方便 AI 持續擴寫
HTML 網站版與 EPUB 電子書版共用同一份內容來源
repo 一開就能讓 Codex 知道怎麼工作
後續要接 GitHub Pages 也很順

GitHub 官方建議 repo 應有清楚的 README.md，而且放在 repo 根目錄、.github 或 docs 目錄的 README 會被 GitHub 辨識與展示；Pandoc 也官方支援輸出 EPUB，並可用 YAML metadata 與 defaults file 管理建置參數。

一、建議專案名稱
python-for-beginners-book
learn-python-to-function
python-beginner-ebook

若你這本書是教學導向，我比較建議：

python-for-beginners-book

理由：

一看就知道用途
GitHub repo 名稱清楚
後續做網站與 EPUB 都自然
二、完整專案結構
python-for-beginners-book/
├─ README.md
├─ AGENTS.md
├─ PROJECT_PROMPT.md
├─ TASK_PROMPT_BOOK.md
├─ LICENSE
├─ .gitignore
├─ package.json
├─ requirements.txt
├─ docs/
│  ├─ index.html
│  ├─ assets/
│  │  ├─ css/
│  │  │  └─ site.css
│  │  ├─ js/
│  │  │  └─ site.js
│  │  └─ images/
│  │     └─ cover.jpg
│  └─ chapters/
│     ├─ chapter01.html
│     ├─ chapter02.html
│     ├─ chapter03.html
│     ├─ chapter04.html
│     ├─ chapter05.html
│     ├─ chapter06.html
│     ├─ chapter07.html
│     ├─ chapter08.html
│     ├─ chapter09.html
│     └─ chapter10.html
├─ src/
│  ├─ index.md
│  ├─ 01-python-intro.md
│  ├─ 02-variables-and-types.md
│  ├─ 03-input-output.md
│  ├─ 04-operators.md
│  ├─ 05-if.md
│  ├─ 06-loop.md
│  ├─ 07-list.md
│  ├─ 08-dict.md
│  ├─ 09-string.md
│  └─ 10-function.md
├─ meta/
│  ├─ metadata.yaml
│  ├─ epub-metadata.xml
│  └─ cover.png
├─ templates/
│  ├─ page.html
│  └─ toc.html
├─ style/
│  ├─ ebook.css
│  └─ html-book.css
├─ scripts/
│  ├─ build-html.ps1
│  ├─ build-epub.ps1
│  ├─ build-all.ps1
│  └─ serve.ps1
├─ output/
│  ├─ html/
│  └─ epub/
└─ .github/
   └─ workflows/
      └─ build-book.yml
三、各資料夾用途
路徑	用途
src/	書的原始內容，全部用 Markdown 撰寫
docs/	網站版輸出，可直接配合 GitHub Pages
meta/	書籍中繼資料，例如書名、作者、語言、封面
style/	HTML 與 EPUB 共用或分開的 CSS
templates/	HTML 模板
scripts/	建置腳本，方便在 Windows + Codex 使用
output/	打包後成品
.github/workflows/	GitHub Actions 自動建置
四、最適合 Codex 的工作分工

建議你讓 Codex 遵守這個原則：

README.md
給人看
說明專案目的、使用方式、建置方式
AGENTS.md
給 AI 看
規定寫作格式、章節命名、禁止事項、輸出風格
PROJECT_PROMPT.md
專案長期規則
告訴 Codex 這本書的定位、讀者、語氣、產出格式
TASK_PROMPT_BOOK.md
單次任務
例如「請擴寫第 3 章到 2500 字，加入 5 題練習題」

GitHub 官方也建議 repo 應用 README 來說明專案用途與使用方式，這正好很適合拿來作為人類維護入口。

五、你可以直接放進 repo 的檔案內容
1. README.md
# Python for Beginners Book

這是一個用 Markdown 撰寫的 Python 入門電子書專案，內容範圍從 Python 基礎到 Function。

## 專案目標
- 建立可持續擴寫的 Python 入門教材
- 同時輸出 HTML 網站版與 EPUB 電子書版
- 方便使用 Codex 持續協作編寫

## 書籍範圍
- Python 簡介
- 變數與資料型態
- 輸入與輸出
- 運算子
- 條件判斷
- 迴圈
- List
- Dictionary
- String
- Function

## 專案結構
- `src/`：Markdown 原始章節
- `docs/`：網站版內容
- `meta/`：書籍中繼資料
- `style/`：CSS
- `scripts/`：建置腳本
- `output/`：輸出成品

## 建置方式

### HTML
```powershell
./scripts/build-html.ps1
EPUB
./scripts/build-epub.ps1
全部建置
./scripts/build-all.ps1
使用工具
Pandoc
PowerShell
GitHub Pages
Codex
授權

可依需求改成 MIT 或保留所有權利。


---

## 2. AGENTS.md

這份很重要，Codex 會用到。

```md
# AGENTS.md

## 專案定位
本專案是一套 Python 入門電子書，目標讀者為初學者、高中生、大學生、非資訊背景自學者。

## 寫作範圍
內容只寫到 Function，不進入 class、module 進階主題。

## 寫作語氣
- 白話
- 教學導向
- 適合第一次學 Python 的讀者
- 每段盡量短
- 優先用台灣常用術語

## 章節格式規範
每章固定包含：
1. 本章重點
2. 概念說明
3. 範例程式
4. 程式解說
5. 常見錯誤
6. 練習題
7. 小結

## 程式碼規範
- 使用 Python 3 語法
- 範例必須可執行
- 變數命名清楚
- 避免一次出現太多新觀念
- 每個範例聚焦一個核心概念

## Markdown 規範
- 使用 `#`、`##`、`###` 標題階層
- 程式碼使用三個反引號 fenced code block
- Python 程式碼標註 `python`
- 不使用 HTML 直接硬寫內容，除非必要

## 不要做的事
- 不要跳級解釋太多進階語法
- 不要混入過多理論
- 不要使用中國大陸用語
- 不要在未說明前使用 class、decorator、generator

## 修改原則
- 優先維持整本書風格一致
- 新增內容時不要破壞既有章節編號
- 若補充內容，優先放在對應章節內，不新增無關章節
3. PROJECT_PROMPT.md
# PROJECT_PROMPT.md

你正在協助撰寫一本 Python 入門電子書，書名暫定為《Python 程式設計入門：從 0 到 Function》。

## 讀者
- 完全初學者
- 高中生
- 大學生
- 非資訊背景學習者

## 書籍目標
- 幫助讀者建立 Python 基本語法能力
- 學會 if、loop、list、dict、string、function
- 看得懂簡單程式
- 能自己修改範例

## 寫作要求
- 內容淺顯易懂
- 每章都要有例子
- 每個重要語法至少提供 2 個範例
- 優先說明用途，再說語法
- 用字以繁體中文、台灣用語為主

## 輸出格式
- 內容以 Markdown 撰寫
- 每章獨立一個 md 檔
- 範例程式可直接複製執行
- 避免過度冗長
4. TASK_PROMPT_BOOK.md
# TASK_PROMPT_BOOK.md

請根據本 repo 的 AGENTS.md 與 PROJECT_PROMPT.md 規則，完成以下工作：

- 擴寫指定章節內容
- 保持初學者友善
- 補上範例程式、解說、常見錯誤、練習題、小結
- 輸出為 Markdown
- 不改動其他章節檔名與章節順序

本次任務：
請完善 `src/03-input-output.md`，補成一章完整教材，長度約 1500～2500 字，至少加入：
- 2 個 input 範例
- 2 個 print 範例
- 3 題練習題
- 1 段常見錯誤提醒
六、章節檔案命名建議

建議固定兩位數編號：

01-python-intro.md
02-variables-and-types.md
03-input-output.md
04-operators.md
05-if.md
06-loop.md
07-list.md
08-dict.md
09-string.md
10-function.md

好處是：

GitHub 上排序穩定
Pandoc 合併時順序明確
Codex 不容易亂掉章節順序
七、meta/metadata.yaml 範例

Pandoc 官方支援用 YAML metadata 來管理 EPUB／HTML 的書籍資訊，也支援用 --metadata-file 或 defaults file 載入。

title: "Python 程式設計入門：從 0 到 Function"
author:
  - "你的名字"
language: "zh-TW"
rights: "All rights reserved."
description: "一本給初學者的 Python 入門教材，內容涵蓋基礎語法到 Function。"
publisher: "自出版"
identifier: "python-for-beginners-book"
cover-image: "meta/cover.png"
toc: true
toc-depth: 2
number-sections: true
八、src/index.md 範例

這個檔案當總入口，Pandoc 建書時很好用。

# Python 程式設計入門：從 0 到 Function

歡迎來到這本 Python 入門書。

本書適合完全沒有程式基礎的學習者，內容會一步一步帶你認識 Python，從最基本的語法開始，一直到 function。

## 目錄
1. Python 簡介
2. 變數與資料型態
3. 輸入與輸出
4. 運算子
5. if 條件判斷
6. 迴圈
7. List
8. Dictionary
9. String
10. Function
九、HTML / EPUB 建置方式

Pandoc 官方文件明確說明可以輸出 standalone HTML，也可以產出 EPUB；另外也支援 --number-sections、--css、--defaults 等建置選項。

1. scripts/build-html.ps1
$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force -Path output/html | Out-Null

pandoc `
  src/index.md `
  src/01-python-intro.md `
  src/02-variables-and-types.md `
  src/03-input-output.md `
  src/04-operators.md `
  src/05-if.md `
  src/06-loop.md `
  src/07-list.md `
  src/08-dict.md `
  src/09-string.md `
  src/10-function.md `
  --metadata-file=meta/metadata.yaml `
  --standalone `
  --toc `
  --number-sections `
  --css=style/html-book.css `
  -o output/html/index.html

Copy-Item output/html/index.html docs/index.html -Force
2. scripts/build-epub.ps1
$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force -Path output/epub | Out-Null

pandoc `
  src/index.md `
  src/01-python-intro.md `
  src/02-variables-and-types.md `
  src/03-input-output.md `
  src/04-operators.md `
  src/05-if.md `
  src/06-loop.md `
  src/07-list.md `
  src/08-dict.md `
  src/09-string.md `
  src/10-function.md `
  --metadata-file=meta/metadata.yaml `
  --toc `
  --number-sections `
  --css=style/ebook.css `
  --epub-cover-image=meta/cover.png `
  -o output/epub/python-for-beginners.epub
3. scripts/build-all.ps1
$ErrorActionPreference = "Stop"

./scripts/build-html.ps1
./scripts/build-epub.ps1
十、CSS 檔案建議
style/html-book.css
body {
  font-family: "Noto Sans TC", "Microsoft JhengHei", sans-serif;
  line-height: 1.9;
  max-width: 900px;
  margin: 0 auto;
  padding: 2rem;
  color: #222;
  background: #fff;
}

h1, h2, h3 {
  line-height: 1.4;
}

pre {
  background: #f4f4f4;
  padding: 1rem;
  overflow-x: auto;
  border-radius: 8px;
}

code {
  font-family: Consolas, monospace;
}

img {
  max-width: 100%;
}
style/ebook.css
body {
  font-family: serif;
  line-height: 1.8;
}

h1, h2, h3 {
  page-break-after: avoid;
}

pre {
  white-space: pre-wrap;
  word-break: break-word;
}

code {
  font-family: monospace;
}

Pandoc 文件也提到 HTML 與 EPUB 對圖片與屬性的支援有對應規則，因此用 Markdown + CSS 的方式維護通常比直接手寫大量 HTML 更穩定。

十一、GitHub Actions 自動建置
.github/workflows/build-book.yml
name: Build Book

on:
  push:
    branches: [ "main" ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Pandoc
        uses: pandoc/actions/setup@v1

      - name: Build HTML
        run: |
          pandoc \
            src/index.md \
            src/01-python-intro.md \
            src/02-variables-and-types.md \
            src/03-input-output.md \
            src/04-operators.md \
            src/05-if.md \
            src/06-loop.md \
            src/07-list.md \
            src/08-dict.md \
            src/09-string.md \
            src/10-function.md \
            --metadata-file=meta/metadata.yaml \
            --standalone \
            --toc \
            --number-sections \
            --css=style/html-book.css \
            -o docs/index.html

      - name: Build EPUB
        run: |
          mkdir -p output/epub
          pandoc \
            src/index.md \
            src/01-python-intro.md \
            src/02-variables-and-types.md \
            src/03-input-output.md \
            src/04-operators.md \
            src/05-if.md \
            src/06-loop.md \
            src/07-list.md \
            src/08-dict.md \
            src/09-string.md \
            src/10-function.md \
            --metadata-file=meta/metadata.yaml \
            --toc \
            --number-sections \
            --css=style/ebook.css \
            --epub-cover-image=meta/cover.png \
            -o output/epub/python-for-beginners.epub

      - name: Upload EPUB
        uses: actions/upload-artifact@v4
        with:
          name: python-for-beginners-epub
          path: output/epub/python-for-beginners.epub