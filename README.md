# TaskTrove

## 功能特性

- 任务与子任务管理
- 项目与标签分类
- 看板/列表/日历多视图
- 重复任务
- 优先级与截止日期
- 快速添加（智能解析）
- 多语言支持（默认中文）

## 快速部署

```bash
docker run -d \
  -p 3000:3000 \
  -v $(pwd)/data:/app/data \
  --name tasktrove-zh \
  wsng911/tasktrove-zh:latest
```

访问 `http://localhost:3000`
