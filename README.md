# 大數據管理系統：SQL Server 機器學習與 Web 介面整合專案

<p align="left">
  <a href="https://www.python.org/downloads/"><img src="https://img.shields.io/badge/Python-3.8+-blue.svg" alt="Python 3.8+"></a>
  <a href="https://www.microsoft.com/en-us/sql-server/"><img src="https://img.shields.io/badge/Database-SQL%20Server-red.svg" alt="SQL Server"></a>
  <a href="https://streamlit.io/"><img src="https://img.shields.io/badge/Framework-Streamlit-FF4B4B.svg" alt="Streamlit"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="MIT License"></a>
</p>

## 關於本專案 (About)
本專案為大學三年級「大數據管理系統」課程之期末實作。
核心目標在於解決大數據環境下，數據移動所帶來的傳輸成本問題。本專案透過 **SQL Server Machine Learning Services** 實現了 **「資料庫內運算 (In-Database Analytics)」** 架構。我們將機器學習預測模型（如薪資趨勢線性迴歸）直接部署於資料庫內部，避免了將巨量資料提取至應用程式端的需求，並透過 **Streamlit** 開發互動式 Web 介面進行數據監控與預測展示。

## 專案檔案布局 (Project Structure)
根據目前的開發配置，專案結構如下：

```text
.
├── app/
│   └── 1258001_江永閎_網站開發.py     # Streamlit Web 應用程式主程式
├── docs/
│   └── 1258001_江永閎_網站開發.pdf    # 專案開發報告與技術文檔
├── sql/
│   └── 1258001_江永閎_機器學習.sql    # 資料庫 Schema、預存程序與 ML 邏輯
├── .gitignore                         # Git 忽略設定檔案
├── LICENSE                            # MIT 授權協議
├── README.md                          # 專案說明文件
└── requirements.txt                   # 環境依賴套件清單
```

## 技術棧與工具 (Tech Stack)
* **資料庫系統**: Microsoft SQL Server (SSMS)
* **數據分析環境**: SQL Server Machine Learning Services (Python 整合)
* **機器學習框架**: Scikit-learn (Linear Regression)
* **前端介面**: Python 3.8+ & Streamlit Framework
* **資料庫驅動**: pyodbc (支援 ODBC Driver 17/18)

## 核心功能說明
* **自動化數據整合**: 實時從 SQL Server 提取 `EmployeeData` 進行數據映射。
* **伺服器端預測**: 透過預存程序調用內建 Python 腳本，執行高性能數據預測。
* **數據視覺化**: 動態生成原始薪資與預測薪資的比較分析圖表，強化決策支援。

## 快速部署指南 (Deployment)
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

## 專案備註
本專案完整呈現了「大數據管理系統」課程中關於數據整合與模型部署的實務操作。所有代碼與文件均保留開發時的原始狀態，詳情請參閱 `docs/` 資料夾中的報告文件。

## 授權協議 (License)
本專案基於 MIT License 授權。詳細內容請參閱 [MIT License](LICENSE) 檔案。

---
* **開發者**: 江永閎
* **課程名稱**: 大數據管理系統
