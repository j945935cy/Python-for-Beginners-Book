# Python for Beginners Book

這是一個用 Markdown 撰寫的 Python 入門電子書專案，內容從 Python 基礎一路介紹到函式，適合第一次接觸程式設計的讀者。

## 專案目標
- 建立適合初學者閱讀的 Python 教材
- 以 Markdown 作為單一內容來源，方便持續擴寫
- 同時輸出 HTML 網站版與 EPUB 電子書版

## 內容範圍
- Python 簡介
- 變數與資料型態
- 輸入與輸出
- 運算子
- 條件判斷
- 迴圈
- 清單
- 字典
- 字串
- 函式

## 專案結構
- `src/`：書籍章節 Markdown
- `assets/`：網站版使用的靜態資源
- `docs/`：補充文件與校稿資料
- `meta/`：書籍中繼資料與封面
- `style/`：HTML 與 EPUB 使用的樣式
- `scripts/`：建置與預覽腳本
- `output/`：輸出成品

## 建置需求
- Pandoc
- PowerShell
- Python 3（本機預覽用）

### 安裝 Pandoc
本專案的 HTML 與 EPUB 建置都需要 `pandoc`。

Windows 常見安裝方式：

```powershell
winget install --id JohnMacFarlane.Pandoc
```

如果你的電腦沒有 `winget`，也可以到 Pandoc 官方網站下載安裝程式：

`https://pandoc.org/installing.html`

安裝完成後，可以用下面指令確認是否安裝成功：

```powershell
pandoc --version
```

如果畫面有顯示 Pandoc 版本號，代表已經可以使用。

## 建置方式

### 產生 HTML
```powershell
./scripts/build-html.ps1
```

### 產生 EPUB
```powershell
./scripts/build-epub.ps1
```

### 同時建置 HTML 與 EPUB
```powershell
./scripts/build-all.ps1
```

### 本機預覽
```powershell
./scripts/serve.ps1
```

## 補充說明
- 根目錄的 `index.html` 是網站入口頁
- `src/` 內的 Markdown 是整本書的主要來源
- 書籍語言設定為 `zh-TW`
