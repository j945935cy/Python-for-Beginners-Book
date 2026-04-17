# 第 7 章 清單

## 本章重點
- 認識什麼是清單
- 學會建立與讀取清單資料
- 學會修改、加入與刪除元素
- 了解清單索引與長度的概念

## 概念說明
在前面的章節裡，我們常常把一筆資料存進一個變數，例如名字、年齡或分數。

但是如果今天不是只有一筆資料，而是很多筆同類型的資料呢？

例如：
- 三種水果名稱
- 五位同學的分數
- 一週七天的名字

如果每一筆資料都開一個變數，會變得很麻煩，也不好管理。

這時候就可以使用 **清單（List）**。

清單可以把多筆資料放在同一個變數裡，而且資料會按照順序排好。你可以把它想成一個有順序的清單，裡面一格一格放著不同內容。

在 Python 中，List 會用中括號 `[]` 來表示，元素之間用逗號隔開。

![清單中的元素會依照順序排列，而且索引從 0 開始](assets/images/list-slots.svg)

## 範例程式
### 範例 1：建立清單並讀取元素
```python
fruits = ["apple", "banana", "orange"]
print(fruits[0])
print(fruits[1])
```

### 範例 2：修改清單中的資料
```python
colors = ["red", "blue", "green"]
colors[1] = "yellow"

print(colors)
```

### 範例 3：加入新元素
```python
numbers = [10, 20, 30]
numbers.append(40)

print(numbers)
```

### 範例 4：刪除元素
```python
fruits = ["apple", "banana", "orange"]
fruits.remove("banana")

print(fruits)
```

### 範例 5：查看清單長度
```python
students = ["小明", "小美", "阿華"]
print(len(students))
```

### 範例 6：搭配迴圈逐一顯示
```python
names = ["小明", "小美", "阿華"]

for name in names:
    print(name)
```

## 程式解說
### 1. 如何建立清單
建立清單很簡單，只要把資料放在中括號裡面即可。

```python
fruits = ["apple", "banana", "orange"]
```

這表示 `fruits` 裡面有三個元素，分別是 `apple`、`banana`、`orange`。

### 2. 什麼是索引
清單裡的每一個元素，都有自己的位置。
這個位置叫做**索引**。

在 Python 中，索引是從 **0** 開始算的，不是從 1 開始。

所以：
- `fruits[0]` 是第一個元素
- `fruits[1]` 是第二個元素
- `fruits[2]` 是第三個元素

這是初學者很容易搞混的地方，一定要特別記住。

### 3. 修改元素內容
清單裡的資料是可以改的。

例如：

```python
colors = ["red", "blue", "green"]
colors[1] = "yellow"
```

這表示把原本第二個元素 `blue` 改成 `yellow`。

修改之後，整個清單就會變成：

```python
["red", "yellow", "green"]
```

### 4. 加入新資料
如果你想在清單最後面加入一個新元素，可以使用 `append()`。

```python
numbers = [10, 20, 30]
numbers.append(40)
```

這樣 `40` 就會被加到最後面。

### 5. 刪除資料
如果你想刪除清單中的某個元素，可以使用 `remove()`。

```python
fruits = ["apple", "banana", "orange"]
fruits.remove("banana")
```

這樣 `banana` 就會從清單中被移除。

### 6. 查看清單長度
如果你想知道清單裡有幾筆資料，可以使用 `len()`。

```python
students = ["小明", "小美", "阿華"]
print(len(students))
```

這裡的 `len(students)` 會告訴你清單裡總共有幾個元素。

### 7. 用迴圈讀取整個清單
當清單裡有很多資料時，一個一個手動寫出來很不方便。

所以我們通常會搭配 `for` 迴圈，把清單裡的每個元素依序取出來。

```python
for name in names:
    print(name)
```

這段程式會把 `names` 裡的每個名字都印出來。

這種寫法很常見，之後你會經常使用。

## 常見錯誤
### 1. 忘記索引從 0 開始
很多初學者看到第一個元素時，會直覺寫成 `fruits[1]`。

但在 Python 裡，第一個元素應該是 `fruits[0]`。

### 2. 索引超出範圍
如果清單只有三個元素，你卻去讀 `fruits[5]`，程式就會報錯。

所以在讀取資料前，要先知道清單裡到底有幾個元素。

### 3. 把 `append` 寫錯
加入新元素時要寫成：

```python
numbers.append(40)
```

不要漏掉括號，也不要把方法名稱拼錯。

### 4. 刪除不存在的資料
如果你要刪除的內容根本不在清單裡，程式就會出錯。

例如清單裡沒有 `grape`，卻寫：

```python
fruits.remove("grape")
```

這樣 Python 就找不到要刪除的資料。

## 練習題
1. 建立一個包含三種飲料名稱的清單，並印出第一個元素。
2. 建立一個數字清單，修改其中一個數字後再印出整個清單。
3. 建立一個空清單，接著用 `append()` 加入三個資料。
4. 建立一個水果清單，刪除其中一個水果後再印出。
5. 建立一個名字清單，先印出清單長度，再使用 `for` 迴圈把每個名字印出來。
6. 想一想：如果要管理全班同學的名字，為什麼用清單會比一個一個變數方便？

## 練習題參考解答與解析
### 第 1 題
```python
drinks = ["tea", "coffee", "juice"]
print(drinks[0])
```
解析：第一個元素的索引是 0，不是 1。

### 第 2 題
```python
numbers = [10, 20, 30]
numbers[1] = 99
print(numbers)
```
解析：用索引可以直接修改清單中的資料。

### 第 3 題
```python
items = []
items.append("apple")
items.append("banana")
items.append("orange")
print(items)
```
解析：空清單也可以慢慢加入資料。

### 第 4 題
```python
fruits = ["apple", "banana", "orange"]
fruits.remove("banana")
print(fruits)
```
解析：`remove()` 可以刪除指定內容。

### 第 5 題
```python
names = ["小明", "小美", "阿華"]
print(len(names))
for name in names:
    print(name)
```
解析：`len()` 可以先看有幾筆資料，`for` 迴圈則可以把每個元素依序取出來。

### 第 6 題
參考答案：因為清單可以把多個同類資料放在一起，比一個一個變數更好整理，也更方便重複處理。

解析：這就是清單最主要的用途。

## 小結
這一章你已經學會了清單的基本概念。

你現在知道：
- 清單可以一次存放多筆資料
- 清單中的元素有順序，也有索引
- Python 的索引從 0 開始
- 可以修改元素，也可以用 `append()` 加入資料
- 可以用 `remove()` 刪除資料
- 可以用 `len()` 查看有幾筆資料
- 清單常常會搭配 `for` 迴圈一起使用

學會清單之後，你就更能有效管理多筆相關資料。
