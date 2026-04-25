import urllib.request
import urllib.error
import sys

URL = "http://localhost:8000/index.html"

# 我們預期在 HTML 裡面會出現的各章節標題
EXPECTED_CHAPTERS = [
    "第 1 章 Python 簡介",
    "第 2 章 變數與資料型態",
    "第 3 章 輸入與輸出",
    "第 4 章 運算子",
    "第 5 章 條件判斷",
    "第 6 章 迴圈",
    "第 7 章 清單",
    "第 8 章 字典",
    "第 9 章 字串",
    "第 10 章 函式"
]

def run_tests():
    print(f"Testing local server at {URL} ...\n")
    try:
        # 1. 測試伺服器是否正常回應
        req = urllib.request.urlopen(URL)
        if req.getcode() == 200:
            print("[OK] Server is responding (HTTP 200 OK)")
        else:
            print(f"[FAIL] Server returned unexpected code: {req.getcode()}")
            sys.exit(1)
            
        html_content = req.read().decode('utf-8')
        
        all_passed = True
        print("\n--- Testing Chapter Contents ---")
        
        # 2. 測試是否包含所有章節內容
        for chapter in EXPECTED_CHAPTERS:
            if chapter in html_content:
                print(f"[OK] Found: {chapter}")
            else:
                print(f"[FAIL] Missing: {chapter}")
                all_passed = False
                
        # 3. 測試新加的圖片是否成功渲染進去
        print("\n--- Testing Images ---")
        if "assets/images/python-intro.svg" in html_content:
            print("[OK] Found: python-intro.svg")
        else:
            print("[FAIL] Missing: python-intro.svg")
            all_passed = False
            
        print("\n===============================")
        if all_passed:
            print("[SUCCESS] All tests passed successfully!")
            sys.exit(0)
        else:
            print("[ERROR] Some tests failed.")
            sys.exit(1)
            
    except urllib.error.URLError as e:
        print(f"[FAIL] Failed to connect to {URL}. Is the server running (`npm run serve`)?")
        print(f"Error details: {e}")
        sys.exit(1)

if __name__ == "__main__":
    run_tests()
