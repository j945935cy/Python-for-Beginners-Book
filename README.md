# Python for Beginners Book

這是一個以 Markdown 撰寫的 Python 入門電子書專案。

## 專案目標
- 建立可持續擴寫的 Python 入門教材
- 同時輸出 HTML 網站版與 EPUB 電子書版
- 方便使用 AI 協作編寫內容

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
- `docs/`：網站版內容與靜態資源
- `meta/`：書籍中繼資料
- `style/`：HTML 與 EPUB 樣式
- `scripts/`：建置腳本
- `output/`：輸出成品

## 建置方式

### 需求
- Pandoc
- PowerShell
- Python 3（本機預覽用）

### HTML
```powershell
./scripts/build-html.ps1
```

### EPUB
```powershell
./scripts/build-epub.ps1
```

### 全部建置
```powershell
./scripts/build-all.ps1
```

### 本機預覽
```powershell
./scripts/serve.ps1
```

## 備註
- `docs/index.html` 可作為 GitHub Pages 的網站入口
- 作者名稱：J5
- 各章內容以 `src/` 內的 Markdown 為單一來源
