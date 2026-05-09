# tasktrove-zh Prompts

> 项目：dohsimpson/TaskTrove 汉化版（tasktrove-zh）
> 技术栈：Next.js 14 + React + Tailwind CSS + Radix UI，i18next 国际化，Turborepo monorepo

---

## 功能迭代

**1. 添加任务甘特图视图**
在 tasktrove-zh 中添加甘特图视图模式。在 viewMode 选项中新增"甘特图"选项，使用 react-gantt-chart 或自定义实现，按项目和截止日期展示任务时间线，支持拖拽调整任务时间范围。

**2. 支持任务依赖关系**
在 tasktrove-zh 中为任务添加依赖关系功能。用户可以设置"此任务依赖于"其他任务，被依赖的任务完成前，当前任务显示为阻塞状态。在任务详情侧边栏中显示依赖关系图。

**3. 添加 AI 智能任务分解**
在 tasktrove-zh 的快速添加任务对话框中，添加"AI 分解"按钮。用户输入大任务描述后，调用 AI API 自动将其分解为多个子任务，用户可以选择性地接受建议的子任务。

**4. 支持任务时间追踪**
在 tasktrove-zh 中为每个任务添加时间追踪功能。用户可以启动/暂停计时器记录在任务上花费的时间，在任务详情中显示总计时间，并在统计页面展示每日/每周时间分配报告。

**5. 添加看板泳道功能**
在 tasktrove-zh 的看板视图中添加泳道（Swimlane）功能，支持按负责人、优先级或标签对任务进行分组，每个分组显示为独立的水平泳道，方便团队协作时查看各成员的任务分配。

---

## Bug 修复

**6. 修复快速添加任务时智能解析误识别中文内容**
在 tasktrove-zh 中，智能解析功能在处理中文任务标题时，有时会将中文数字（如"三天后"）误识别为截止日期，或将中文标点误识别为优先级标记。请优化智能解析的正则表达式，增加对中文内容的特殊处理。

**7. 修复任务拖拽到看板列时偶发的位置错误**
在 tasktrove-zh 的看板视图中，将任务从一列拖拽到另一列时，偶尔会出现任务插入到错误位置的问题。请检查拖拽排序逻辑中的索引计算，确保在快速拖拽时位置计算的准确性。

**8. 修复重复任务在时区切换后日期错误**
在 tasktrove-zh 中，设置了重复规则的任务在用户切换时区后，下次重复的日期计算出现偏差。请检查重复任务的日期计算逻辑，确保所有日期操作都基于用户本地时区而非 UTC。

**9. 修复大量任务时搜索性能下降**
在 tasktrove-zh 中，当任务数量超过 500 个时，搜索功能响应明显变慢。请为搜索功能添加防抖处理（300ms），并考虑使用 Web Worker 在后台执行搜索，避免阻塞主线程。

**10. 修复任务评论中 Markdown 渲染 XSS 漏洞**
在 tasktrove-zh 的任务评论中，Markdown 渲染器未对用户输入进行充分的 XSS 过滤，攻击者可以通过构造特殊的 Markdown 内容注入恶意脚本。请使用 DOMPurify 对渲染后的 HTML 进行净化处理。

---

## 重构

**11. 将任务数据层迁移到 React Query**
tasktrove-zh 目前使用自定义 hooks 管理任务数据的获取和缓存。请将数据层迁移到 TanStack Query（React Query），利用其内置的缓存、后台刷新、乐观更新等功能，减少手动状态管理代码。

**12. 提取通用的对话框基础组件**
tasktrove-zh 中有多个对话框组件（删除确认、添加项目、添加标签等）存在大量重复代码。请提取通用的 `BaseDialog` 组件，封装标题、描述、确认/取消按钮等通用逻辑，各具体对话框只需传入差异化的 props。

---

## 测试

**13. 为任务 CRUD 操作编写端到端测试**
使用 Playwright 为 tasktrove-zh 编写端到端测试，覆盖：创建任务、编辑任务标题和描述、设置截止日期和优先级、完成任务、删除任务。测试应在真实浏览器环境中运行。

**14. 为 i18n 翻译完整性编写测试**
编写测试脚本验证 tasktrove-zh 所有语言文件的翻译完整性：对比中文翻译文件与英文基准文件，找出缺失的翻译 key，并在 CI 中运行此检查，防止新增功能时遗漏翻译。

**15. 为智能解析功能编写单元测试**
为 tasktrove-zh 的智能解析（Smart Parsing）功能编写完整单元测试，覆盖：优先级识别（P1-P4）、截止日期解析（今天/明天/下周/具体日期）、项目标记（#项目名）、标签标记（@标签名）、重复模式识别。

---

## 代码理解

**16. 解释 Turborepo monorepo 的构建流程**
在 tasktrove-zh 中使用了 Turborepo 管理 monorepo。请解释 turbo.json 中的任务依赖配置、构建缓存的工作原理、`turbo prune` 命令在 Docker 构建中的作用，以及如何在本地开发时只构建特定的 workspace。

**17. 解释任务数据的持久化机制**
在 tasktrove-zh 中，任务数据如何在服务端持久化？请解释数据存储的格式和位置、Server Actions 如何读写数据、数据备份功能的实现原理，以及如何在不同部署环境（Docker/本地）中配置数据目录。

---

## DevOps

**18. 编写 GitHub Actions 自动构建流水线**
为 tasktrove-zh 编写 `.github/workflows/docker-build.yml`，实现推送 main 分支时自动构建 Docker 镜像。由于是 monorepo 结构，需要正确配置 turbo prune 步骤，支持多架构构建（amd64/arm64）并推送到 Docker Hub。

**19. 编写 Kubernetes 部署配置**
为 tasktrove-zh 编写 Kubernetes 部署配置文件，包含：Deployment（2 副本，资源限制）、Service（ClusterIP）、Ingress（支持 HTTPS）、PersistentVolumeClaim（数据持久化）、ConfigMap（环境变量配置）。

**20. 编写性能监控和告警配置**
为 tasktrove-zh 添加 Prometheus 指标暴露接口 `/api/metrics`，收集：请求响应时间、任务 CRUD 操作次数、活跃用户数、错误率。编写对应的 Grafana 仪表盘配置和告警规则。
