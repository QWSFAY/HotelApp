/*
后期部署脚本模板							
--------------------------------------------------------------------------------------
 此文件包含将附加到生成脚本中的 SQL 语句。		
 使用 SQLCMD 语法将文件包含到后期部署脚本中。			
 示例:      :r .\myfile.sql								
 使用 SQLCMD 语法引用后期部署脚本中的变量。		
 示例:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-- 先检查 RoomTypes 表是否为空，如果为空则插入初始房型数据
IF NOT EXISTS (SELECT 1 FROM dbo.RoomTypes)
BEGIN
    INSERT INTO dbo.RoomTypes (Title, Description, Price)
    VALUES 
        ('King Size Bed', 'A room with a king-size bed and a window.', 100),
        ('Two Queen Size Beds', 'A room with two queen-size beds and a window.', 115),
        ('Executive Suite', 'Two rooms, each with a king-size bed and a window.', 205);
END
GO

-- 再检查 Rooms 表是否为空，如果为空则插入初始房间数据
IF NOT EXISTS (SELECT 1 FROM dbo.Rooms)
BEGIN
    DECLARE @roomId1 INT;
    DECLARE @roomId2 INT;
    DECLARE @roomId3 INT;

    -- 获取每个房型的 Id
    SELECT @roomId1 = Id FROM dbo.RoomTypes WHERE Title = 'King Size Bed';
    SELECT @roomId2 = Id FROM dbo.RoomTypes WHERE Title = 'Two Queen Size Beds';
    SELECT @roomId3 = Id FROM dbo.RoomTypes WHERE Title = 'Executive Suite';

    -- 插入房间（假设每个房型有几间房）
    INSERT INTO dbo.Rooms (RoomNumber, RoomTypeId)
    VALUES 
        ('101', @roomId1),
        ('102', @roomId1),
        ('103', @roomId1),
        ('201', @roomId2),
        ('202', @roomId2),
        ('301', @roomId3);
END
GO
