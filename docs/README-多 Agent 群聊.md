# 多 Agent 群聊模式配置指南

## 📋 概述

多 Agent 群聊模式允许多个专用 Agent 在同一个群聊中协作，每个 Agent 负责不同的角色和任务。

## 🎯 已配置的 Agent 角色

| 角色 | 名称 | 职责 | 触发关键词 |
|------|------|------|------------|
| **coordinator** | 协调员 | 群聊协调、任务分配和总结 | 分配任务、总结、进度 |
| **developer** | 开发工程师 | 代码开发、技术问题解决 | 代码、开发、bug、实现、功能 |
| **tester** | 测试工程师 | 测试、质量保障 | 测试、bug、验证、检查 |
| **researcher** | 研究员 | 信息搜集、调研分析 | 调研、搜索、分析、资料、查询 |
| **writer** | 文案专员 | 文档撰写、内容创作 | 文档、写作、文案、报告、总结 |
| **analyst** | 数据分析师 | 数据分析、图表生成 | 数据、分析、统计、图表 |

## 🚀 启用方式

### 方式 1：通过配置文件

配置文件已创建在：
```
/home/admin/openclaw/workspace/config/multi-agent-chat.json
```

### 方式 2：命令行启用

```bash
# 查看当前配置
openclaw config get multi-agent-chat

# 启用多 Agent 模式
openclaw agents spawn --role coordinator --label "群聊协调员"
openclaw agents spawn --role developer --label "开发工程师"
openclaw agents spawn --role researcher --label "研究员"
```

### 方式 3：使用 agent-cluster

```bash
# 使用现有的 agent-cluster 配置
cd /home/admin/openclaw/workspace/agent-cluster
# 启动集群模式
```

## 💡 使用示例

### 示例 1：任务分配

```
@协调员 请分配一个任务：帮我开发一个用户登录功能
```

**响应流程**：
1. 协调员接收任务
2. 分配给开发工程师
3. 开发工程师开始编码
4. 完成后分配给测试工程师
5. 测试通过后总结

### 示例 2：多 Agent 协作

```
@developer @tester @researcher 我们一起完成这个功能：
1. 调研竞品登录功能
2. 开发我们的登录模块
3. 测试所有边界情况
```

**响应流程**：
1. researcher 开始调研竞品
2. developer 根据调研结果开发
3. tester 编写测试用例并验证

### 示例 3：自动触发

当群聊中出现关键词时，对应的 Agent 会自动响应：

- 用户："这个 **bug** 怎么修复？"
- → **测试工程师** 和 **开发工程师** 自动响应

- 用户："帮我 **调研** 一下市场情况"
- → **研究员** 自动响应

- 用户："写一份项目 **报告**"
- → **文案专员** 自动响应

## ⚙️ 配置说明

### 核心参数

```json
{
  "maxConcurrentAgents": 3,        // 最多同时响应的 Agent 数量
  "responseOrder": "priority",     // 响应顺序：按优先级
  "avoidDuplicateResponses": true, // 避免重复响应
  "summarizeAfterMessages": 10     // 每 10 条消息自动总结
}
```

### 路由策略

```json
{
  "strategy": "smart",             // 智能路由
  "fallback": "coordinator",       // 默认回退到协调员
  "loadBalancing": true            // 负载均衡
}
```

## 📊 监控与管理

### 查看活跃 Agent

```bash
openclaw agents list
```

### 查看子 Agent 状态

```bash
openclaw subagents list
```

### 停止特定 Agent

```bash
openclaw subagents kill --target <agent-id>
```

## 🔧 自定义配置

### 添加新角色

编辑 `/home/admin/openclaw/workspace/config/multi-agent-chat.json`：

```json
"roles": {
  "designer": {
    "name": "设计师",
    "model": "qwen3.5-plus",
    "thinking": "on",
    "description": "负责 UI/UX 设计",
    "priority": "medium",
    "autoTrigger": ["设计", "UI", "界面", "原型"],
    "maxTasks": 10
  }
}
```

### 调整触发关键词

修改 `autoTrigger` 数组来定制触发条件。

## ⚠️ 注意事项

1. **避免过多 Agent**：建议同时活跃的 Agent 不超过 3-5 个
2. **明确任务分配**：复杂任务建议@具体角色
3. **定期检查进度**：协调员会定期总结群聊进度
4. **资源管理**：每个 Agent 都会消耗 token，注意监控用量

## 📝 快速启动脚本

创建启动脚本 `/home/admin/openclaw/workspace/scripts/start-multi-agent.sh`：

```bash
#!/bin/bash
cd /home/admin/openclaw/workspace

# 启动协调员
openclaw sessions spawn --label "coordinator" --task "你是群聊协调员，负责任务分配和总结"

# 启动开发工程师
openclaw sessions spawn --label "developer" --task "你是开发工程师，负责代码开发和技术问题"

# 启动研究员
openclaw sessions spawn --label "researcher" --task "你是研究员，负责信息搜集和调研"

echo "多 Agent 群聊模式已启动！"
```

---

**配置文件位置**：
- 主配置：`/home/admin/openclaw/workspace/config/multi-agent-chat.json`
- agent-cluster：`/home/admin/openclaw/workspace/agent-cluster/config.json`

**下次更新**：根据实际使用情况调整 Agent 角色和触发关键词
