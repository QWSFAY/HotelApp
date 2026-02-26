#### 项目背景与定位

该项目是一套面向酒店日常运营管理的一体化解决方案，聚焦酒店入住登记核心场景，覆盖桌面端交互、数据库底层支撑及 Web 端拓展能力，旨在提升酒店入住流程的数字化效率，降低人工操作成本。

#### 技术栈与架构设计

- **整体架构**：采用分层设计思想，拆分为桌面端（HotelApp.Desktop）、数据库层（HotelAppDB）、核心业务类库（HotelAppLibrary）及 Web 端（HotalApp.Web）四大模块，实现业务逻辑与界面；
- **桌面端开发**：基于 WPF（XAML + C#）构建可视化交互界面，包含主窗口（MainWindow）、入住登记表单（CheckInForm）等核心页面，通过 App.xaml 完成应用程序生命周期管理，结合 appsettings.json 实现配置化管理；
- **数据层设计**：基于 SQL Server 项目（HotelAppDB.sqlproj）搭建数据库模型（HotelAppDB.dbmdl），包含 dbo 核心数据表、Scripts 脚本目录及 Public Profiles 配置，保障酒店入住数据的存储、查询与管理；
- **核心类库**：HotelAppLibrary 封装通用业务逻辑（如入住信息校验、数据映射等），为桌面端和 Web 端提供统一的业务支撑；
- **拓展能力**：预留 Web 端（HotalApp.Web）拓展模块，支持后续 B/S 架构的远程访问与多端适配。

#### 核心功能模块

1. **入住登记管理**：通过 CheckInForm 可视化表单实现宾客信息录入、身份核验、房间分配等核心流程，结合数据校验规则保障信息准确性；
2. **数据持久化**：基于自定义数据库模型实现入住数据、房间信息、宾客信息的结构化存储，支持数据的增删改查及批量操作；
3. **桌面端交互**：基于 WPF 实现轻量化、易操作的桌面交互界面，适配酒店前台人员的操作习惯，降低学习成本。

#### 项目价值与亮点

- **模块化设计**：各模块独立维护（如 Desktop、DB、Library），便于后续功能迭代与问题排查；
- **技术适配性**：兼顾桌面端本地操作的高效性与 Web 端拓展的灵活性，适配酒店不同场景的使用需求；
- **数据规范化**：通过数据库项目统一管理数据表结构、脚本及配置，保障数据存储的规范性与可维护性。

运行界面：
 ![]([https://github.com/QWSFAY/Qt_Mysql_practice/blob/main/img/1.png?raw=true)
![1](https://github.com/QWSFAY/HotelApp/blob/main/pic/1.png?raw=true)

![2](D:\Github\C#\HotelApp\pic\2.png)

![3](D:\Github\C#\HotelApp\pic\3.png)

![4](D:\Github\C#\HotelApp\pic\4.png)

![5](D:\Github\C#\HotelApp\pic\5.png)

![6](D:\Github\C#\HotelApp\pic\6.png)

![7](D:\Github\C#\HotelApp\pic\7.png)

