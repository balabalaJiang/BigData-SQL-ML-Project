# 大數據管理系統：SQL Server 機器學習與 Web 介面整合專案

本專案為大三「大數據管理系統」課程之期末實作成果。專案核心在於整合 **Microsoft SQL Server (SSMS)** 資料庫管理、**SQL Server Machine Learning Services** (In-Database ML) 以及 **Python Streamlit** 網頁開發技術，建立一個從數據儲存、模型運算到前端展示的完整大數據應用流程。

## 📂 專案檔案布局
根據目前的開發配置，專案結構如下：

```text
BigData_SQL_ML_Project/
├── app/
│   └── 1258001_江永閎_網站開發.py     # Python Web UI 程式碼 (Streamlit 框架)
├── docs/
│   └── 1258001_江永閎_網站開發.pdf    # 完整成果展示與開發報告書
├── sql/
│   └── 1258001_江永閎_機器學習.sql    # 資料庫建置、數據匯入與 ML 預存程序
├── .gitignore                         # Git 忽略設定檔案
├── README.md                          # 本專案說明文件
└── requirements.txt                   # Python 環境相依套件清單 (pyodbc, streamlit...)
```

## 🛠️ 技術棧與功能亮點
* **資料庫端 (Back-end)**: 利用 SSMS 進行結構化數據管理，並透過 `sp_execute_external_script` 在 SQL Server 內部直接執行機器學習演算法。
* **機器學習 (ML Logic)**: 整合 `pandas` 與 `scikit-learn` 進行薪資預測或數據趨勢分析，模型直接於資料庫內運行以減少數據傳輸損耗。
* **網頁介面 (Front-end)**: 採用 Streamlit 框架，透過 `pyodbc` 驅動程式連接 SQL 伺服器，實現即時查詢與「一鍵預測」功能。

## 🚀 部署與執行手冊

### 1. SQL Server 環境配置
* 確保您的 SQL Server 實例已安裝 **Machine Learning Services (Python)**。
* 開啟 SSMS 並執行 `sql/1258001_江永閎_機器學習.sql` 內的指令以建立資料庫與表格。
* **重要**: 必須開啟 SQL Server 的外部指令碼執行權限：
    ```sql
    EXEC sp_configure 'external scripts enabled', 1;
    RECONFIGURE;
    ```

### 2. Python 開發環境設定
* 請於專案根目錄開啟終端機，並執行以下指令安裝必要套件：
    ```bash
    pip install -r requirements.txt
    ```

### 3. 修改連線資訊
* 開啟 `app/1258001_江永閎_網站開發.py`。
* 找到 `pyodbc.connect` 區塊，將 `SERVER=` 修改為您本地的 SQL Server 實例名稱。

### 4. 啟動 Web UI
* 執行以下指令啟動 Streamlit 服務：
    ```bash
    streamlit run app/1258001_江永閎_網站開發.py
    ```

## 📝 專案備註
本專案完整呈現了「大數據管理系統」課程中關於數據整合與模型部署的實務操作。所有代碼與文件均保留開發時的原始狀態，詳情請參閱 `docs/` 資料夾中的報告文件。

---
* **開發者**: 江永閎 (Student ID: 1258001)
* **指導課程**: 大數據管理系統
