# 第 9 章 字串

## 本章重點
- 認識什麼是字串
- 學會建立與輸出文字資料
- 學會字串串接與重複
- 認識常見的字串功能

## 概念說明
在 Python 裡，除了數字以外，另一種非常常見的資料型態就是**字串**。

字串就是文字資料。
例如：
- 姓名
- 地址
- 問候語
- 一段句子

只要是文字內容，通常都會用字串來表示。

在 Python 中，字串要放在引號裡面，可以使用單引號 `' '`，也可以使用雙引號 `" "`。

例如：

```python
name = "Amy"
message = 'Hello'
```

這兩種寫法都可以，只要前後成對就沒問題。

字串在程式裡非常重要，因為很多和人互動的內容都和文字有關，例如輸入名字、顯示提示訊息、處理句子內容等等。

## 範例程式
### 範例 1：建立與輸出字串
```python
name = "Python"
print(name)
print("歡迎學習 Python")
```

### 範例 2：字串串接
```python
first_name = "王"
last_name = "小明"
full_name = first_name + last_name

print(full_name)
```

### 範例 3：字串重複
```python
line = "=" * 10
print(line)
```

### 範例 4：常見字串功能
```python
text = "python programming"

print(text.upper())
print(text.title())
print(len(text))
```

## 程式解說
### 1. 字串要放在引號裡
如果你想在程式中表示一段文字，就必須把它放進引號。

例如：

```python
print("你好")
```

這樣 Python 才知道你要處理的是文字，而不是變數名稱。

### 2. 字串可以串接
字串和字串之間可以用 `+` 接起來。

例如：

```python
first_name = "王"
last_name = "小明"
full_name = first_name + last_name
```

這樣就會把兩段文字合成一段新的文字。

如果你想中間多一個空格，也可以自己加上去：

```python
english_name = "Amy" + " " + "Chen"
```

### 3. 字串也可以重複
除了串接，字串還可以和數字搭配使用 `*`。

```python
print("Hi" * 3)
```

結果會是：

```python
HiHiHi
```

這種寫法有時候可以拿來做分隔線或簡單排版。

### 4. 常見字串功能
Python 提供很多方便的字串功能，這裡先介紹幾個初學者常用的：

- `upper()`：轉成大寫
- `lower()`：轉成小寫
- `title()`：每個單字開頭改成大寫

例如：

```python
text = "python programming"
print(text.upper())
```

這樣會輸出：

```python
PYTHON PROGRAMMING
```

上面這些像 `upper()`、`lower()`、`title()`，都是字串常用的方法。

如果你想知道字串長度，可以使用 `len()`。

```python
print(len(text))
```

這裡的 `len()` 是 Python 提供的函式，不是字串方法。
它會告訴你這段文字總共有幾個字元。

## 常見錯誤
### 1. 把字串和數字直接相加
這是很常見的初學者錯誤。

例如：

```python
age = 18
print("我的年齡是" + age)
```

這樣會出錯，因為前面是字串，後面是整數。

比較簡單的寫法是：

```python
age = 18
print("我的年齡是", age)
```

### 2. 引號沒有成對
例如少打一個引號，Python 就會報語法錯誤。

錯誤示意：

```python
print("Hello)
```

### 3. 把方法名稱拼錯
像 `upper()`、`lower()` 這些方法，如果拼錯，程式就不會成功執行。

所以打字時要特別注意大小寫與拼字。

### 4. 把 `len()` 當成字串方法
`len()` 要寫成 `len(text)`，不能寫成 `text.len()`。

因為 `len()` 是函式，不是字串方法。

## 練習題
1. 建立一個字串變數，存放你的名字，然後印出來。
2. 建立兩個字串，分別是姓氏和名字，將它們串接後輸出。
3. 用 `*` 產生一條由 `-` 組成的分隔線。
4. 建立一段英文文字，試著使用 `upper()`、`lower()`、`title()`。
5. 使用 `len()` 計算一句話的長度。

## 練習題參考解答與解析
### 第 1 題
```python
name = "J5"
print(name)
```
解析：字串要放在引號裡，這樣 Python 才知道它是文字。

### 第 2 題
```python
last_name = "王"
first_name = "小明"
full_name = last_name + first_name
print(full_name)
```
解析：字串可以用 `+` 串接成一段完整內容。

### 第 3 題
```python
print("-" * 20)
```
解析：字串乘上數字可以重複顯示多次。

### 第 4 題
```python
text = "python book"
print(text.upper())
print(text.lower())
print(text.title())
```
解析：這三個方法分別能改變字母大小寫的呈現方式。

### 第 5 題
```python
sentence = "Hello Python"
print(len(sentence))
```
解析：`len()` 會回傳字串長度，也包含空格在內。

## 小結
這一章你已經學會字串的基本操作。

你現在知道：
- 字串是用來表示文字資料的型態
- 文字要放在引號裡
- 可以用 `+` 進行字串串接
- 可以用 `*` 做重複輸出
- 可以使用 `upper()`、`lower()`、`title()` 等字串方法
- 可以使用 `len()` 這個函式計算字串長度

字串是程式設計中非常常用的資料型態，學熟之後會幫助你更自然地處理各種文字內容。
