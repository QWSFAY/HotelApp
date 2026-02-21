/*
HotelAppDB 的部署脚本

此代码由工具生成。
如果重新生成此代码，则对此文件的更改可能导致
不正确的行为并将丢失。
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "HotelAppDB"
:setvar DefaultFilePrefix "HotelAppDB"
:setvar DefaultDataPath "C:\Users\Leo\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Leo\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
请检测 SQLCMD 模式，如果不支持 SQLCMD 模式，请禁用脚本执行。
要在启用 SQLCMD 模式后重新启用脚本，请执行:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'要成功执行此脚本，必须启用 SQLCMD 模式。';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'已跳过具有键 a4cb07e1-3b6b-4d58-ba9c-459754d05c67 的重命名重构操作，不会将元素 [dbo].[Booking] (SqlTable) 重命名为 [Bookings]';


GO
-- 正在重构步骤以使用已部署的事务日志更新目标服务器
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a4cb07e1-3b6b-4d58-ba9c-459754d05c67')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a4cb07e1-3b6b-4d58-ba9c-459754d05c67')

GO

GO
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

GO
PRINT N'更新完成。';


GO
