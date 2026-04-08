-- 建立新資料庫
CREATE DATABASE MusicLibraryDB;
GO

-- 切換到新建立的資料庫
USE MusicLibraryDB;
GO

-- 創作者 (Creators) - 父實體
-- 儲存所有人物（歌手、作詞、作曲等）
CREATE TABLE Creators (
    creator_id INT PRIMARY KEY,  -- 我們將手動插入 ID 以便於關聯
    creator_name NVARCHAR(255) NOT NULL,
    creator_country NVARCHAR(100) NULL
);
GO
-- 專輯 (Albums) - 父實體
-- 儲存專輯資訊
CREATE TABLE Albums (
    album_id INT PRIMARY KEY,  -- 手動插入 ID
    album_title NVARCHAR(255) NOT NULL,
    album_date DATE NULL
);
GO
-- 歌曲 (Songs) - 依賴於 Albums
-- 儲存歌曲基本資訊
CREATE TABLE Songs (
    song_id INT PRIMARY KEY,  -- 手動插入 ID
    song_title NVARCHAR(255) NOT NULL,
    song_language NVARCHAR(50) NOT NULL,
    album_id INT NULL,
    CONSTRAINT FK_Songs_Albums FOREIGN KEY (album_id) REFERENCES Albums(album_id)
);
GO
-- 歌曲-創作者角色關聯表 (Song_Creator_Roles) - 弱實體
-- 連接 Songs 和 Creators，並定義角色
CREATE TABLE Song_Creator_Roles (
    song_id INT NOT NULL,
    creator_id INT NOT NULL,
    [role] NVARCHAR(50) NOT NULL,  -- [role] 因 role 是 T-SQL 關鍵字，用中括號
    
    -- 複合主鍵 (可識別關聯)
    CONSTRAINT PK_Song_Creator_Roles PRIMARY KEY (song_id, creator_id, [role]),
    
    -- 外部鍵
    CONSTRAINT FK_SCR_Songs FOREIGN KEY (song_id) REFERENCES Songs(song_id) ON DELETE CASCADE,
    CONSTRAINT FK_SCR_Creators FOREIGN KEY (creator_id) REFERENCES Creators(creator_id) ON DELETE CASCADE
);
GO

PRINT '開始插入資料...';
-- 插入 [Creators] (34 筆資料)
-- 包含歌手、作詞、作曲
BEGIN
    INSERT INTO Creators (creator_id, creator_name, creator_country) VALUES
    (101, N'周杰倫', N'台灣'),
    (102, N'方文山', N'台灣'),
    (103, N'阿信', N'台灣'),
    (104, N'蔡依林', N'台灣'),
    (105, N'林俊傑', N'台灣'),
    (106, N'張惠妹', N'台灣'),
    (107, N'鄧紫棋', N'香港'),
    (108, N'吳青峰', N'台灣'),
    (109, N'田馥甄', N'台灣'),
    (110, N'周興哲', N'台灣'),
    (111, N'李宗盛', N'台灣'),
    (112, N'林夕', N'香港'),
    (113, N'五月天', N'台灣'),
    (114, N'蘇打綠', N'台灣'),
    (115, N'S.H.E', N'台灣'),
    (116, N'黃偉文', N'香港'),
    (117, N'陳奕迅', N'香港'),
    (118, N'王菲', N'香港'),
    (119, N'陶喆', N'台灣'),
    (120, N'韋禮安', N'台灣'),
    (121, N'徐佳瑩', N'台灣'),
    (122, N'陳綺貞', N'台灣'),
    (123, N'盧廣仲', N'台灣'),
    (124, N'李榮浩', N'中國'),
    (125, N'毛不易', N'中國'),
    (126, N'艾怡良', N'台灣'),
    (127, N'葛大為', N'台灣'),
    (128, N'黃韻玲', N'台灣'),
    (129, N'姚若龍', N'台灣'),
    (130, N'伍佰', N'台灣'),
    (131, N'徐若瑄', N'台灣'),
    (132, N'黃俊郎', N'台灣'),
    (133, N'費玉清', N'台灣'),
    (134, N'陳鎮川', N'台灣');
END
PRINT ' -> ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' 筆資料已插入 [Creators]';
-- 插入 [Albums] (20 筆資料)
BEGIN
    INSERT INTO Albums (album_id, album_title, album_date) VALUES
    (501, N'Jay', '2000-11-07'),
    (502, N'范特西', '2001-09-14'),
    (503, N'八度空間', '2002-07-19'),
    (504, N'葉惠美', '2003-07-31'),
    (505, N'七里香', '2004-08-03'),
    (506, N'11月的蕭邦', '2005-11-01'),
    (507, N'依然范特西', '2006-09-05'),
    (508, N'我很忙', '2007-11-02'),
    (509, N'J-Game', '2005-04-25'),
    (510, N'舞孃', '2006-05-12'),
    (511, N'特務J', '2007-09-21'),
    (512, N'第二天堂', '2004-06-04'),
    (513, N'曹操', '2006-02-17'),
    (514, N'西界', '2007-06-29'),
    (515, N'To Hebe', '2010-09-03'),
    (516, N'My Love', '2011-09-02'),
    (517, N'渺小', '2013-11-29'),
    (518, N'自傳', '2016-07-21'),
    (519, N'後青春期的詩', '2008-10-23'),
    (520, N'Ugly Beauty', '2018-12-26');
END
PRINT ' -> ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' 筆資料已插入 [Albums]';
-- 插入 [Songs] (30 筆資料)
BEGIN
    INSERT INTO Songs (song_id, song_title, song_language, album_id) VALUES
    -- 周杰倫 (1001-1010)
    (1001, N'可愛女人', N'國語', 501),
    (1002, N'黑色幽默', N'國語', 501),
    (1003, N'雙截棍', N'國語', 502),
    (1004, N'簡單愛', N'國語', 502),
    (1005, N'以父之名', N'國語', 504),
    (1006, N'晴天', N'國語', 504),
    (1007, N'七里香', N'國語', 505),
    (1008, N'夜曲', N'國語', 506),
    (1009, N'千里之外', N'國語', 507),
    (1010, N'青花瓷', N'國語', 508),
    -- 蔡依林 (1011-1015)
    (1011, N'野蠻遊戲', N'國語', 509),
    (1012, N'舞孃', N'國語', 510),
    (1013, N'馬德里不思議', N'國語', 510),
    (1014, N'特務J', N'國語', 511),
    (1015, N'日不落', N'國語', 511),
    -- 林俊傑 (1016-1020)
    (1016, N'江南', N'國語', 512),
    (1017, N'一千年以後', N'國語', 513),
    (1018, N'曹操', N'國語', 513),
    (1019, N'殺手', N'國語', 514),
    (1020, N'不為誰而作的歌', N'國語', NULL), -- 範例：單曲，無專輯
    -- 田馥甄 (1021-1025)
    (1021, N'LOVE!', N'國語', 515),
    (1022, N'寂寞寂寞就好', N'國語', 515),
    (1023, N'My Love', N'國語', 516),
    (1024, N'還是要幸福', N'國語', 516),
    (1025, N'你就不要想起我', N'國語', 517),
    -- 五月天 (1026-1030)
    (1026, N'突然好想你', N'國語', 519),
    (1027, N'你不是真正的快樂', N'國語', 519),
    (1028, N'後來的我們', N'國語', 518),
    (1029, N'如果我們不曾相遇', N'國語', 518),
    (1030, N'頑固', N'國語', 518);
END
PRINT ' -> ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' 筆資料已插入 [Songs]';

-- 插入 [Song_Creator_Roles] (91 筆資料)
-- 這是 3NF 的核心，定義了每首歌的「歌手」、「作詞」、「作曲」
BEGIN
    INSERT INTO Song_Creator_Roles (song_id, creator_id, [role]) VALUES
    -- 1001 可愛女人 (詞:徐若瑄, 曲:周杰倫, 唱:周杰倫)
    (1001, 131, N'作詞'),
    (1001, 101, N'作曲'),
    (1001, 101, N'歌手'),
    -- 1002 黑色幽默 (詞:周杰倫, 曲:周杰倫, 唱:周杰倫)
    (1002, 101, N'作詞'),
    (1002, 101, N'作曲'),
    (1002, 101, N'歌手'),
    -- 1003 雙截棍 (詞:方文山, 曲:周杰倫, 唱:周杰倫)
    (1003, 102, N'作詞'),
    (1003, 101, N'作曲'),
    (1003, 101, N'歌手'),
    -- 1004 簡單愛 (詞:徐若瑄, 曲:周杰倫, 唱:周杰倫)
    (1004, 131, N'作詞'),
    (1004, 101, N'作曲'),
    (1004, 101, N'歌手'),
    -- 1005 以父之名 (詞:黃俊郎, 曲:周杰倫, 唱:周杰倫)
    (1005, 132, N'作詞'),
    (1005, 101, N'作曲'),
    (1005, 101, N'歌手'),
    -- 1006 晴天 (詞:周杰倫, 曲:周杰倫, 唱:周杰倫)
    (1006, 101, N'作詞'),
    (1006, 101, N'作曲'),
    (1006, 101, N'歌手'),
    -- 1007 七里香 (詞:方文山, 曲:周杰倫, 唱:周杰倫)
    (1007, 102, N'作詞'),
    (1007, 101, N'作曲'),
    (1007, 101, N'歌手'),
    -- 1008 夜曲 (詞:方文山, 曲:周杰倫, 唱:周杰倫)
    (1008, 102, N'作詞'),
    (1008, 101, N'作曲'),
    (1008, 101, N'歌手'),
    -- 1009 千里之外 (詞:方文山, 曲:周杰倫, 唱:周杰倫, 唱:費玉清)
    (1009, 102, N'作詞'),
    (1009, 101, N'作曲'),
    (1009, 101, N'歌手'),
    (1009, 133, N'歌手'),
    -- 1010 青花瓷 (詞:方文山, 曲:周杰倫, 唱:周杰倫)
    (1010, 102, N'作詞'),
    (1010, 101, N'作曲'),
    (1010, 101, N'歌手'),
    -- 1011 野蠻遊戲 (詞:陳鎮川, 曲:Jonas Nordelius..., 唱:蔡依林) (簡化作曲者)
    (1011, 134, N'作詞'),
    (1011, 101, N'作曲'), 
    (1011, 104, N'歌手'),
    -- 1012 舞孃 (詞:陳鎮川, 曲:Miriam Nervo..., 唱:蔡依林) (簡化作曲者)
    (1012, 134, N'作詞'),
    (1012, 101, N'作曲'), 
    (1012, 104, N'歌手'),
    -- 1013 馬德里不思議 (詞:黃俊郎, 曲:陳孟奇, 唱:蔡依林) (簡化作曲者)
    (1013, 132, N'作詞'),
    (1013, 101, N'作曲'), 
    (1013, 104, N'歌手'),
    -- 1014 特務J (詞:李宗恩, 曲:黃晟峰, 唱:蔡依林) (簡化)
    (1014, 111, N'作詞'),
    (1014, 105, N'作曲'),
    (1014, 104, N'歌手'),
    -- 1015 日不落 (詞:崔惟楷, 曲:Bodybangers, 唱:蔡依林) (簡化)
    (1015, 127, N'作詞'),
    (1015, 105, N'作曲'),
    (1015, 104, N'歌手'),
    -- 1016 江南 (詞:李瑞洵, 曲:林俊傑, 唱:林俊傑) (簡化)
    (1016, 112, N'作詞'),
    (1016, 105, N'作曲'),
    (1016, 105, N'歌手'),
    -- 1017 一千年以後 (詞:李瑞洵, 曲:林俊傑, 唱:林俊傑) (簡化)
    (1017, 112, N'作詞'),
    (1017, 105, N'作曲'),
    (1017, 105, N'歌手'),
    -- 1018 曹操 (詞:林秋離, 曲:林俊傑, 唱:林俊傑) (簡化)
    (1018, 112, N'作詞'),
    (1018, 105, N'作曲'),
    (1018, 105, N'歌手'),
    -- 1019 殺手 (詞:林秋離, 曲:林俊傑, 唱:林俊傑) (簡化)
    (1019, 112, N'作詞'),
    (1019, 105, N'作曲'),
    (1019, 105, N'歌手'),
    -- 1020 不為誰而作的歌 (詞:林秋離, 曲:林俊傑, 唱:林俊傑) (簡化)
    (1020, 112, N'作詞'),
    (1020, 105, N'作曲'),
    (1020, 105, N'歌手'),
    -- 1021 LOVE! (詞:黃淑惠, 曲:黃淑惠, 唱:田馥甄) (簡化)
    (1021, 129, N'作詞'),
    (1021, 129, N'作曲'),
    (1021, 109, N'歌手'),
    -- 1022 寂寞寂寞就好 (詞:施人誠, 曲:楊子樸, 唱:田馥甄) (簡化)
    (1022, 129, N'作詞'),
    (1022, 128, N'作曲'),
    (1022, 109, N'歌手'),
    -- 1023 My Love (詞:施人誠, 曲:王治平, 唱:田馥甄) (簡化)
    (1023, 129, N'作詞'),
    (1023, 128, N'作曲'),
    (1023, 109, N'歌手'),
    -- 1024 還是要幸福 (詞:徐世珍/司魚, 曲:張簡君偉, 唱:田馥甄) (簡化)
    (1024, 131, N'作詞'),
    (1024, 105, N'作曲'),
    (1024, 109, N'歌手'),
    -- 1025 你就不要想起我 (詞:施人誠, 曲:劉大江, 唱:田馥甄) (簡化)
    (1025, 129, N'作詞'),
    (1025, 120, N'作曲'),
    (1025, 109, N'歌手'),
    -- 1026 突然好想你 (詞:阿信, 曲:阿信, 唱:五月天)
    (1026, 103, N'作詞'),
    (1026, 103, N'作曲'),
    (1026, 113, N'歌手'),
    -- 1027 你不是真正的快樂 (詞:阿信, 曲:阿信, 唱:五月天)
    (1027, 103, N'作詞'),
    (1027, 103, N'作曲'),
    (1027, 113, N'歌手'),
    -- 1028 後來的我們 (詞:阿信, 曲:怪獸, 唱:五月天) (簡化)
    (1028, 103, N'作詞'),
    (1028, 103, N'作曲'),
    (1028, 113, N'歌手'),
    -- 1029 如果我們不曾相遇 (詞:阿信, 曲:阿信, 唱:五月天)
    (1029, 103, N'作詞'),
    (1029, 103, N'作曲'),
    (1029, 113, N'歌手'),
    -- 1030 頑固 (詞:阿信, 曲:阿信, 唱:五月天)
    (1030, 103, N'作詞'),
    (1030, 103, N'作曲'),
    (1030, 113, N'歌手');
END
PRINT ' -> ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' 筆資料已插入 [Song_Creator_Roles]';
GO
PRINT '資料庫建置與資料插入完成。';
GO

/********************************************************************************
 * 預存程序 1：sp_GetSongDetailsByTitle
 * * 目的： 
 * 依據歌曲名稱（支援模糊查詢），取得一首歌的完整詳細資料，
 * 包含專輯、所有歌手、所有作詞、所有作曲。
 *
 * 優點：
 * 封裝了 3NF 結構中最複雜的查詢（多次 JOIN）。
 * 應用程式只需要呼叫這個 SP，就能取得所有需要的資訊。
 ********************************************************************************/
IF OBJECT_ID('sp_GetSongDetailsByTitle', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetSongDetailsByTitle;
GO
CREATE PROCEDURE sp_GetSongDetailsByTitle
    -- 參數：@PartialTitle (要查詢的部分歌名)
    @PartialTitle NVARCHAR(255)
AS
BEGIN
    -- 設定為不回傳受影響的資料列數目，可提升一點效能
    SET NOCOUNT ON;
    SELECT 
        s.song_title AS '歌曲名稱',
        s.song_language AS '語言',
        ISNULL(a.album_title, N'-- 單曲 --') AS '所屬專輯',
        c.creator_name AS '創作者名稱',
        scr.[role] AS '擔任角色'
    FROM 
        Songs s
    -- 1. JOIN 關聯表 (核心)
    LEFT JOIN 
        Song_Creator_Roles scr ON s.song_id = scr.song_id
    -- 2. JOIN 創作者表 (取得創作者名稱)
    LEFT JOIN 
        Creators c ON scr.creator_id = c.creator_id
    -- 3. LEFT JOIN 專輯表 (因為可能是單曲，所以用 LEFT JOIN)
    LEFT JOIN 
        Albums a ON s.album_id = a.album_id
    WHERE 
        -- 使用 LIKE 進行模糊查詢
        s.song_title LIKE '%' + @PartialTitle + '%'
    ORDER BY
        s.song_title, 
        -- 讓角色排序更美觀
        CASE 
            WHEN scr.[role] = N'歌手' THEN 1
            WHEN scr.[role] = N'作曲' THEN 2
            WHEN scr.[role] = N'作詞' THEN 3
            ELSE 4
        END;
END;
GO
PRINT '預存程序 [sp_GetSongDetailsByTitle] 建立完成。';
GO
/********************************************************************************
 * 預存程序 2：sp_GetWorksByCreatorName
 *
 * 目的：
 * 依據創作者名稱（支援模糊查詢），查詢該創作者的所有作品
 * 以及他/她在每首作品中擔任的角色。
 *
 * 優點：
 * 這是「人物為導向」的查詢，例如 "查詢周杰倫的所有作品"。
 * 應用程式不需要知道 Creators, Songs, Roles 之間的複雜關係。
 ********************************************************************************/
IF OBJECT_ID('sp_GetWorksByCreatorName', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetWorksByCreatorName;
GO
CREATE PROCEDURE sp_GetWorksByCreatorName
    -- 參數：@CreatorName (要查詢的創作者名稱)
    @CreatorName NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        c.creator_name AS '創作者名稱',
        s.song_title AS '歌曲名稱',
        scr.[role] AS '擔任角色',
        ISNULL(a.album_title, N'-- 單曲 --') AS '所屬專輯'
    FROM 
        Creators c
    -- 1. JOIN 關聯表 (從創作者出發)
    JOIN 
        Song_Creator_Roles scr ON c.creator_id = scr.creator_id
    -- 2. JOIN 歌曲表 (取得歌曲名稱)
    JOIN 
        Songs s ON scr.song_id = s.song_id
    -- 3. LEFT JOIN 專輯表 (歌曲可能是單曲)
    LEFT JOIN 
        Albums a ON s.album_id = a.album_id
    WHERE 
        -- 使用 LIKE 進行模糊查詢
        c.creator_name LIKE '%' + @CreatorName + '%'
    ORDER BY
        c.creator_name,
        s.song_title,
        -- 同樣對角色進行排序
        CASE 
            WHEN scr.[role] = N'歌手' THEN 1
            WHEN scr.[role] = N'作曲' THEN 2
            WHEN scr.[role] = N'作詞' THEN 3
            ELSE 4
        END;
END;
GO
PRINT '預存程序 [sp_GetWorksByCreatorName] 建立完成。';
GO


/********************************************************************************
 * 執行預存程序
 ********************************************************************************/
PRINT '--- 測試執行 [sp_GetSongDetailsByTitle] ---';
-- 範例 1：查詢歌曲 "千里之外" (有兩位歌手)
EXEC sp_GetSongDetailsByTitle @PartialTitle = N'千里之外';
GO
-- 範例 2：查詢所有歌名包含 "愛" 的歌曲
EXEC sp_GetSongDetailsByTitle @PartialTitle = N'愛';
GO

PRINT '--- 測試執行 [sp_GetWorksByCreatorName] ---';
-- 範例 3：查詢 "周杰倫" (ID=101) 的所有作品與角色
EXEC sp_GetWorksByCreatorName @CreatorName = N'周杰倫';
GO
-- 範例 4：查詢 "方文山" (ID=102) 的所有作品與角色
EXEC sp_GetWorksByCreatorName @CreatorName = N'方文山';
GO




-- 建立自訂函數
-- 切換到您的音樂資料庫
USE MusicLibraryDB;
GO
/********************************************************************************
 * 1. 建立 2 個自訂函數 (UDF)
 ********************************************************************************/
-- --- 自訂函數 1 (純量值函數) ---
-- 目的： 依據創作者 ID，回傳創作者的「姓名」。
IF OBJECT_ID('fn_GetCreatorNameByID', 'FN') IS NOT NULL
    DROP FUNCTION fn_GetCreatorNameByID;
GO
CREATE FUNCTION fn_GetCreatorNameByID (
    @CreatorID INT
)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @CreatorName NVARCHAR(255);
    
    SELECT @CreatorName = creator_name
    FROM Creators
    WHERE creator_id = @CreatorID;
    RETURN @CreatorName;
END;
GO
PRINT '函數 1/2 [fn_GetCreatorNameByID] 建立完成。';
GO

-- --- 自訂函數 2 (資料表值函數) ---
-- 目的： 依據創作者 ID，回傳該創作者的所有作品（歌曲、角色、專輯）。
IF OBJECT_ID('fn_GetWorksByCreatorID', 'IF') IS NOT NULL
    DROP FUNCTION fn_GetWorksByCreatorID;
GO
CREATE FUNCTION fn_GetWorksByCreatorID (
    @CreatorID INT
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        s.song_id,
        s.song_title AS '歌曲名稱',
        scr.[role] AS '擔任角色',
        ISNULL(a.album_title, N'-- 單曲 --') AS '所屬專輯'
    FROM 
        Song_Creator_Roles scr
    JOIN 
        Songs s ON scr.song_id = s.song_id
    LEFT JOIN 
        Albums a ON s.album_id = a.album_id
    WHERE 
        scr.creator_id = @CreatorID
);
GO
PRINT '函數 2/2 [fn_GetWorksByCreatorID] 建立完成。';
GO

/********************************************************************************
 * 2. 建立預存程序 (SP)
 * * 目的： 
 * 建立一個 SP 來查詢特定歌曲的詳細資訊。
 * 此 SP 將會呼叫「函數 1 (fn_GetCreatorNameByID)」，
 * 將創作者 ID 轉換為可讀的姓名，使 SP 的回傳結果更友善。
 ********************************************************************************/
IF OBJECT_ID('sp_GetSongDetails_WithReadableNames', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetSongDetails_WithReadableNames;
GO
CREATE PROCEDURE sp_GetSongDetails_WithReadableNames
    -- 輸入參數：歌曲 ID
    @SongID INT
AS
BEGIN
    SET NOCOUNT ON;
    -- SP 的核心查詢
    SELECT 
        s.song_title AS '歌曲名稱',
        s.song_language AS '語言',
        ISNULL(a.album_title, N'-- 單曲 --') AS '所屬專輯',
        
        -- *** 這裡呼叫了自訂函數 1 ***
        dbo.fn_GetCreatorNameByID(scr.creator_id) AS '創作者姓名', 
        
        scr.[role] AS '擔任角色'
    FROM 
        Songs s
    LEFT JOIN 
        Albums a ON s.album_id = a.album_id
    JOIN 
        Song_Creator_Roles scr ON s.song_id = scr.song_id
    WHERE 
        s.song_id = @SongID
    ORDER BY
        -- 讓角色排序更美觀
        CASE 
            WHEN scr.[role] = N'歌手' THEN 1
            WHEN scr.[role] = N'作曲' THEN 2
            WHEN scr.[role] = N'作詞' THEN 3
            ELSE 4
        END;
END;
GO
PRINT '預存程序 [sp_GetSongDetails_WithReadableNames] (已呼叫 UDF 1) 建立完成。';
GO
 
 
 
-- 執行範例
PRINT '--- 範例 A：在 SELECT 中使用「函數 1」---';
-- 查詢「千里之外」(ID=1009) 的角色，並將 ID 轉換為姓名
SELECT 
    song_id,
    creator_id,
    -- 直接在 SELECT 列表呼叫
    dbo.fn_GetCreatorNameByID(creator_id) AS '創作者姓名',
    [role]
FROM 
    Song_Creator_Roles
WHERE 
    song_id = 1009;
GO

PRINT '--- 範例 B：在 SELECT 中使用「函數 2」---';
-- 查詢「周杰倫」(ID=101) 的所有作品
-- 由於它回傳一個資料表，我們像查詢一般資料表一樣使用它
SELECT 
    * FROM 
    dbo.fn_GetWorksByCreatorID(101); -- 101 是周杰倫的 ID
GO

PRINT '--- 範例 C：(進階) 在 SELECT 中使用「函數 2」搭配 APPLY ---';
-- 查詢多位創作者 (周杰倫 101, 方文山 102) 的所有作品
SELECT 
    c.creator_name,
    Works.歌曲名稱,
    Works.擔任角色
FROM 
    Creators c
CROSS APPLY -- 將函數應用於 Creators 表的每一筆指定資料
    dbo.fn_GetWorksByCreatorID(c.creator_id) AS Works
WHERE
    c.creator_id IN (101, 102); -- 批次查詢
GO

PRINT '--- (補充) 執行呼叫了函數的「預存程序」---';
-- 執行我們建立的 SP (它內部會呼叫 UDF 1)
EXEC sp_GetSongDetails_WithReadableNames @SongID = 1009; -- 查詢「千里之外」
GO


--觸發程序
 
-- 建立一個備份表，結構與 Songs 類似，但多了刪除時間
IF OBJECT_ID('Songs_Deleted_Log', 'U') IS NOT NULL
    DROP TABLE Songs_Deleted_Log;
GO
CREATE TABLE Songs_Deleted_Log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    original_song_id INT,
    song_title NVARCHAR(255),
    deleted_at DATETIME DEFAULT GETDATE(), -- 自動記錄刪除時間
    deleted_by NVARCHAR(100) DEFAULT SYSTEM_USER -- 自動記錄是誰刪除的
);
GO
 
CREATE TRIGGER trg_BackupDeletedSongs
ON Songs
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- [deleted] 是一個系統虛擬資料表，裡面存放著「剛剛被刪除」的資料列
    INSERT INTO Songs_Deleted_Log (original_song_id, song_title)
    SELECT 
        song_id, 
        song_title
    FROM 
        deleted; -- 從虛擬表讀取被刪除的資料
    PRINT '觸發程序啟動：已將刪除的歌曲備份至 Log 表。';
END;
GO
 
PRINT '--- 測試 Trigger 1：刪除歌曲 ---';
-- 1. 先確認目前 log 表是空的
SELECT * FROM Songs_Deleted_Log;
-- 2. 刪除一首歌 (例如 ID 1020 '不為誰而作的歌')
-- 注意：若該歌曲有外鍵關聯 (Song_Creator_Roles)，需先設定 CASCADE 或先刪除關聯資料
-- 這裡假設外鍵設定了 ON DELETE CASCADE，或者我們先手動刪除關聯
DELETE FROM Song_Creator_Roles WHERE song_id = 1020;
DELETE FROM Songs WHERE song_id = 1020;
-- 3. 再次查詢 log 表，應該會看到備份資料
SELECT * FROM Songs_Deleted_Log;
GO
 
CREATE TRIGGER trg_CheckAlbumDate
ON Albums
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- [inserted] 是一個系統虛擬資料表，裡面存放著「剛剛新增」或「修改後」的資料列
    -- 檢查是否有任何一筆資料的日期大於今天
    IF EXISTS (SELECT 1 FROM inserted WHERE album_date > GETDATE())
    BEGIN
        -- 如果發現未來日期，回滾事務 (取消剛才的 INSERT 或 UPDATE)
        ROLLBACK TRANSACTION;
        
        -- 拋出錯誤訊息給使用者
        RAISERROR ('錯誤：專輯發行日期不能是未來時間，操作已取消。', 16, 1);
    END
END;
GO
 
PRINT '--- 測試 Trigger 2：輸入未來日期的專輯 ---';
BEGIN TRY
    -- 嘗試插入一張日期為 "2099年" 的專輯
    INSERT INTO Albums (album_id, album_title, album_date) 
    VALUES (999, N'未來專輯', '2099-01-01');
END TRY
BEGIN CATCH
    -- 捕捉錯誤並顯示
    PRINT '捕捉到錯誤訊息：' + ERROR_MESSAGE();
END CATCH;
-- 確認該資料沒有被寫入
SELECT * FROM Albums WHERE album_id = 999;
GO


--交易控制範例
USE MusicLibraryDB;
GO
PRINT '--- 範例 1：交易控制與錯誤處理 ---';
BEGIN TRY
    -- 1. 開始交易
    BEGIN TRANSACTION;
    -- 2. 第一步：新增歌曲 (這步會成功)
    INSERT INTO Songs (song_id, song_title, song_language, album_id)
    VALUES (9999, N'測試交易曲', N'火星文', NULL);
    
    PRINT '步驟 1：歌曲新增成功 (尚未 Commit)';
    -- 3. 第二步：新增關聯 (故意製造錯誤)
    -- 我們故意使用一個不存在的 creator_id (例如 99999) 來觸發 Foreign Key 錯誤
    INSERT INTO Song_Creator_Roles (song_id, creator_id, [role])
    VALUES (9999, 99999, N'作詞');
    PRINT '步驟 2：關聯新增成功';
    -- 4. 如果都沒錯，提交交易
    COMMIT TRANSACTION;
    PRINT '交易成功：資料已寫入';
END TRY
BEGIN CATCH
    -- 5. 錯誤處理：如果有任何錯誤發生
    IF @@TRANCOUNT > 0
    BEGIN
        -- 撤銷交易：所有在 BEGIN TRAN 之後的動作都會被取消
        ROLLBACK TRANSACTION;
        PRINT '!!! 發生錯誤，交易已撤銷 (Rollback) !!!';
    END
    -- 顯示錯誤訊息
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO
-- 驗證結果：歌曲 9999 不應該存在，因為交易被 Rollback 了
SELECT * FROM Songs WHERE song_id = 9999;
GO


-- [視窗 1] 寫入者
USE MusicLibraryDB;
GO
BEGIN TRANSACTION;
-- 更新歌曲名稱，加上 (修改中)
UPDATE Songs
SET song_title = N'七里香 (修改中...)'
WHERE song_id = 1007; -- 鎖定這一行
PRINT 'Session A: 已更新資料，但尚未 Commit... (持有 X 鎖)';
-- 注意：這裡沒有寫 COMMIT，交易仍然開啟中
-- 此時這筆資料被 Session A 鎖定

-- [視窗 2] 讀取者
USE MusicLibraryDB;
GO
PRINT '--- 測試 A：READ COMMITTED (預設值) ---';
-- 這是 SQL Server 的預設隔離層級
-- 它會試圖取得 S 鎖 (共享鎖)，但會被 Session A 的 X 鎖擋住
-- 結果：查詢會「卡住」(Blocking)，直到 Session A 提交或撤銷
SELECT * FROM Songs WHERE song_id = 1007;
-- (若上方卡住太久，請按停止按鈕，接著執行下方測試 B)
PRINT '--- 測試 B：READ UNCOMMITTED (髒讀) ---';
-- 設定隔離層級為「讀取未提交」
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- 這相當於使用了 (NOLOCK)
-- 它不申請 S 鎖，直接讀取記憶體中的資料
-- 結果：會立刻讀到 '七里香 (修改中...)'，即使 Session A 還沒確認要存檔
SELECT * FROM Songs WHERE song_id = 1007;
-- 恢復預設值
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- [視窗 1]
-- 撤銷修改，讓資料恢復原狀
ROLLBACK TRANSACTION;
PRINT 'Session A: 交易已撤銷，釋放鎖定';



-- SQL Server 機器學習
 
USE MusicLibraryDB;
GO
EXEC sp_execute_external_script
  @language = N'Python',
  @script = N'
import pandas as pd
from sklearn.cluster import KMeans
# 1. 取得 SQL 輸入資料
df = InputDataSet
# 2. 建立特徵 (Features)
features = df[["singer_ratio", "composer_ratio", "lyricist_ratio"]]
# 3. 訓練 K-Means 模型
# 固定 random_state=42 以確保分類結果與我們先前的分析一致：
# 0: 純歌手, 1: 幕後, 2: 全能 (基於先前觀察到的中心點)
kmeans = KMeans(n_clusters=3, random_state=42, n_init=10)
kmeans.fit(features)
# 4. 取得分群 ID
df["cluster_id"] = kmeans.labels_
# 5. [新增步驟] 定義行銷標籤映射函數
# 注意：在真實專案中，應先分析中心點後再寫這個對應規則
def get_marketing_persona(cluster_id):
    if cluster_id == 0:
        return "純粹歌者 (Pure Vocalist)"
    elif cluster_id == 1:
        return "幕後創作人 (Behind-the-Scenes)"
    else:
        return "全能創作歌手 (Singer-Songwriter)"
# 6. 應用函數產生新欄位
df["marketing_persona"] = df["cluster_id"].apply(get_marketing_persona)
# 7. 整理輸出順序 (將行銷定義放在數值後面)
OutputDataSet = df[[
    "creator_name", 
    "singer_ratio", 
    "composer_ratio", 
    "lyricist_ratio", 
    "cluster_id", 
    "marketing_persona"  # <--- 將定義放在最後
]]
',
  @input_data_1 = N'
    /* SQL 資料前處理 */
    SELECT 
        c.creator_name,
        CAST(SUM(CASE WHEN scr.role = ''歌手'' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS singer_ratio,
        CAST(SUM(CASE WHEN scr.role = ''作曲'' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS composer_ratio,
        CAST(SUM(CASE WHEN scr.role = ''作詞'' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS lyricist_ratio
    FROM Song_Creator_Roles scr
    JOIN Creators c ON scr.creator_id = c.creator_id
    GROUP BY c.creator_name
    HAVING COUNT(*) > 0 -- 確保至少有一筆作品
  '
WITH RESULT SETS ((
    creator_name NVARCHAR(255),
    singer_ratio FLOAT,       -- 機器學習數值 1
    composer_ratio FLOAT,     -- 機器學習數值 2
    lyricist_ratio FLOAT,     -- 機器學習數值 3
    cluster_id INT,           -- 機器學習分群 ID
    marketing_persona NVARCHAR(100) -- [新增] 行銷定義 (放在數值後)
));