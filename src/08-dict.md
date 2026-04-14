# 第 8 章 Dictionary

## 本章重點
- 認識 Dictionary 的基本概念
- 學會鍵與值的對應方式
- 學會建立、讀取、修改與新增資料
- 了解 Dictionary 和 List 的差別

## 概念說明
前一章我們學到 List，知道它適合拿來存放一組有順序的資料。

但是有些資料，不只是單純排成一列，而是每一筆資料都有「欄位名稱」。

例如一位學生的資料可能有：
- 姓名
- 年齡
- 分數

如果只用 List 來放，就必須一直記住第 0 個是名字、第 1 個是年齡、第 2 個是分數。這樣雖然也做得到，但不夠直覺。

這時候就很適合用 **Dictionary**。

Dictionary 中文通常會翻成「字典」。它的特色是：
**每一筆資料都有一個名稱，透過這個名稱去找到對應的值。**

在 Dictionary 裡：
- 名稱叫做 **鍵**，英文是 key
- 對應的內容叫做 **值**，英文是 value

你可以把它想成查字典：
輸入一個字，就能找到對應的解釋。

在 Python 中，Dictionary 會使用大括號 `{}`，裡面放「鍵: 值」的組合。

## 範例程式
### 範例 1：建立 Dictionary
```python
student = {
    "name": "Amy",
    "age": 18,
    "score": 95
}

print(student)
```

### 範例 2：讀取指定資料
```python
student = {
    "name": "Amy",
    "age": 18
}

print(student["name"])
print(student["age"])
```

### 範例 3：修改與新增資料
```python
student = {
    "name": "Amy",
    "age": 18
}

student["age"] = 19
student["city"] = "Taipei"

print(student)
```

### 範例 4：逐一查看字典內容
```python
product = {
    "name": "Notebook",
    "price": 35,
    "stock": 20
}

for key in product:
    print(key, ":", product[key])
```

## 程式解說
### 1. Dictionary 的基本結構
先看這段：

```python
student = {
    "name": "Amy",
    "age": 18,
    "score": 95
}
```

這裡的 `student` 是一個 Dictionary。
裡面有三組資料：

- `name` 對應 `Amy`
- `age` 對應 `18`
- `score` 對應 `95`

這就是鍵和值的關係。

### 2. 如何讀取資料
如果你想取出某一筆資料，可以用：

```python
student["name"]
```

這表示：到 `student` 這本字典裡，找鍵是 `name` 的資料。

如果這筆資料存在，就能拿到對應的值。

### 3. 如何修改資料
Dictionary 的值是可以更新的。

例如：

```python
student["age"] = 19
```

這行程式會把原本的年齡改成 19。

### 4. 如何新增資料
如果這個鍵原本不存在，Python 會幫你新增一筆資料。

例如：

```python
student["city"] = "Taipei"
```

這樣字典裡就會多出一個 `city`。

所以同樣的寫法，既可以修改，也可以新增，差別在於那個鍵原本有沒有存在。

### 5. 和 List 有什麼不同
這是很重要的觀念：

- List 是用位置找資料，例如第 0 個、第 1 個
- Dictionary 是用名稱找資料，例如 `name`、`age`

如果資料很適合用欄位名稱表示，通常 Dictionary 會更清楚。

## 常見錯誤
### 1. 讀取不存在的鍵
例如：

```python
student = {"name": "Amy"}
print(student["score"])
```

這裡會出錯，因為 `score` 這個鍵並不存在。

### 2. 忘記鍵要用正確格式
通常字串型態的鍵要加引號，例如：

```python
student["name"]
```

如果少了引號，Python 可能會把它當成變數來看，造成錯誤。

### 3. 把大括號和中括號弄混
- Dictionary 建立時用大括號 `{}`
- 讀取指定鍵時用中括號 `[]`

這兩種符號用途不同，不能混用。

## 練習題
1. 建立一個 `book` Dictionary，裡面放書名、作者與頁數。
2. 讀取你建立的 Dictionary 中其中一筆資料並印出。
3. 修改其中一個值，例如把頁數改大一點。
4. 再新增一個欄位，例如出版社或價格。
5. 想一想：學生資料、商品資料、天氣資料，哪些情況適合用 Dictionary？為什麼？

## 練習題參考解答與解析
### 第 1 題
```python
book = {
    "title": "Python 入門",
    "author": "J5",
    "pages": 200
}
print(book)
```
解析：Dictionary 用大括號建立，裡面放鍵和值。

### 第 2 題
```python
print(book["title"])
```
解析：想取出某一筆資料時，要用對應的鍵去讀取。

### 第 3 題
```python
book["pages"] = 220
print(book)
```
解析：如果鍵已存在，指定新值就是修改資料。

### 第 4 題
```python
book["publisher"] = "自出版"
print(book)
```
解析：如果鍵原本不存在，這樣寫就會新增一筆資料。

### 第 5 題
參考答案：學生資料、商品資料、天氣資料都很適合用 Dictionary，因為它們都有清楚的欄位名稱，例如姓名、價格、溫度。

解析：只要資料適合用名稱管理，就很適合用 Dictionary。

## 小結
這一章你已經學會 Dictionary 的基本操作。

你現在知道：
- Dictionary 是由鍵和值組成
- 可以透過鍵快速找到對應資料
- 可以新增、修改與讀取內容
- 它很適合表示有欄位名稱的資料
- 和 List 相比，Dictionary 更適合用「名稱」管理資訊

學會 Dictionary 之後，你處理資料的方式會更有條理。
