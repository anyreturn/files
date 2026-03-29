#!/bin/bash
# 多 Agent 群聊模式快速启动脚本

set -e

WORKSPACE="/home/admin/openclaw/workspace"
CONFIG="$WORKSPACE/config/multi-agent-chat.json"

echo "🦞 OpenClaw 多 Agent 群聊模式启动器"
echo "=================================="
echo ""

# 检查配置文件
if [ ! -f "$CONFIG" ]; then
    echo "❌ 配置文件不存在：$CONFIG"
    exit 1
fi

echo "✅ 配置文件已找到"
echo ""

# 显示已配置的 Agent 角色
echo "📋 已配置的 Agent 角色："
echo "  - coordinator (协调员)：任务分配和总结"
echo "  - developer (开发工程师)：代码开发"
echo "  - tester (测试工程师)：质量保障"
echo "  - researcher (研究员)：信息调研"
echo "  - writer (文案专员)：文档撰写"
echo "  - analyst (数据分析师)：数据分析"
echo ""

# 启动子 Agent
echo "🚀 启动多 Agent 群聊模式..."
echo ""

# 启动协调员
echo "  → 启动协调员 Agent..."
openclaw sessions spawn \
    --label "coordinator" \
    --mode "session" \
    --task "你是群聊协调员，负责任务分配、进度跟踪和群聊总结。当用户@你或提到'分配任务'、'总结'、'进度'时响应。" \
    --cleanup "keep"

# 启动开发工程师
echo "  → 启动开发工程师 Agent..."
openclaw sessions spawn \
    --label "developer" \
    --mode "session" \
    --task "你是开发工程师，负责代码开发、技术问题解决。当用户提到'代码'、'开发'、'bug'、'实现'、'功能'时响应。" \
    --cleanup "keep"

# 启动研究员
echo "  → 启动研究员 Agent..."
openclaw sessions spawn \
    --label "researcher" \
    --mode "session" \
    --task "你是研究员，负责信息搜集、调研分析。当用户提到'调研'、'搜索'、'分析'、'资料'、'查询'时响应。" \
    --cleanup "keep"

# 启动测试工程师
echo "  → 启动测试工程师 Agent..."
openclaw sessions spawn \
    --label "tester" \
    --mode "session" \
    --task "你是测试工程师，负责测试、质量保障。当用户提到'测试'、'bug'、'验证'、'检查'时响应。" \
    --cleanup "keep"

echo ""
echo "✅ 多 Agent 群聊模式已启动！"
echo ""
echo "💡 使用方式："
echo "  1. 在群聊中@具体角色，如：@coordinator 分配任务"
echo "  2. 或使用关键词触发，如：'帮我调研一下市场情况'"
echo "  3. 查看活跃 Agent: openclaw sessions list"
echo "  4. 查看子 Agent: openclaw subagents list"
echo ""
echo "📝 配置文件：$CONFIG"
echo "📖 使用文档：$WORKSPACE/config/README-多 Agent 群聊.md"
echo ""
