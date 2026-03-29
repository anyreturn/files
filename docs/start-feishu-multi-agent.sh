#!/bin/bash
# 飞书多 Agent 群聊模式启动脚本

set -e

WORKSPACE="/home/admin/openclaw/workspace"
CONFIG="$WORKSPACE/config/feishu-channel.json"
FEISHU_GUIDE="$WORKSPACE/config/飞书配置指南.md"

echo "🦞 OpenClaw 飞书多 Agent 群聊启动器"
echo "=================================="
echo ""

# 检查配置文件
if [ ! -f "$CONFIG" ]; then
    echo "❌ 配置文件不存在：$CONFIG"
    echo ""
    echo "📖 请先参考配置指南："
    echo "   $FEISHU_GUIDE"
    echo ""
    echo "配置步骤："
    echo "  1. 访问飞书开放平台：https://open.feishu.cn/"
    echo "  2. 创建自建应用"
    echo "  3. 配置机器人权限和事件订阅"
    echo "  4. 获取 App ID、App Secret、Verification Token、Encrypt Key"
    echo "  5. 填写配置文件：$CONFIG"
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

# 检查飞书凭证是否已填写
APP_ID=$(grep -o '"appId": "[^"]*"' "$CONFIG" | cut -d'"' -f4)
if [ "$APP_ID" == "cli_xxxxxxxxxxxxx" ]; then
    echo "⚠️  飞书凭证尚未配置！"
    echo ""
    echo "请编辑配置文件：$CONFIG"
    echo "填写以下凭证（从飞书开放平台获取）："
    echo "  - appId"
    echo "  - appSecret"
    echo "  - verificationToken"
    echo "  - encryptKey"
    echo ""
    echo "详细步骤请参考：$FEISHU_GUIDE"
    exit 1
fi

echo "✅ 飞书凭证已配置"
echo ""

# 启动飞书 Channel
echo "🚀 启动飞书 Channel..."
openclaw channels start feishu --config "$CONFIG" || {
    echo ""
    echo "⚠️  飞书 Channel 启动失败，可能是插件未安装"
    echo ""
    echo "尝试安装飞书插件："
    echo "  npm install @openclaw/channel-feishu"
    echo ""
    echo "或者使用通用 webhook 模式启动"
    exit 1
}

echo ""
echo "✅ 飞书 Channel 已启动"
echo ""

# 启动子 Agent
echo "🤖 启动多 Agent 系统..."
echo ""

# 启动协调员
echo "  → 启动协调员 Agent..."
openclaw sessions spawn \
    --label "feishu-coordinator" \
    --mode "session" \
    --thread true \
    --task "你是飞书群聊协调员，负责任务分配、进度跟踪和群聊总结。当用户@你或提到'分配任务'、'总结'、'进度'时响应。" \
    --cleanup "keep"

# 启动开发工程师
echo "  → 启动开发工程师 Agent..."
openclaw sessions spawn \
    --label "feishu-developer" \
    --mode "session" \
    --thread true \
    --task "你是开发工程师，负责代码开发、技术问题解决。当用户提到'代码'、'开发'、'bug'、'实现'、'功能'时响应。" \
    --cleanup "keep"

# 启动研究员
echo "  → 启动研究员 Agent..."
openclaw sessions spawn \
    --label "feishu-researcher" \
    --mode "session" \
    --thread true \
    --task "你是研究员，负责信息搜集、调研分析。当用户提到'调研'、'搜索'、'分析'、'资料'、'查询'时响应。" \
    --cleanup "keep"

# 启动测试工程师
echo "  → 启动测试工程师 Agent..."
openclaw sessions spawn \
    --label "feishu-tester" \
    --mode "session" \
    --thread true \
    --task "你是测试工程师，负责测试、质量保障。当用户提到'测试'、'bug'、'验证'、'检查'时响应。" \
    --cleanup "keep"

# 启动文案专员
echo "  → 启动文案专员 Agent..."
openclaw sessions spawn \
    --label "feishu-writer" \
    --mode "session" \
    --thread true \
    --task "你是文案专员，负责文档撰写、内容创作。当用户提到'文档'、'写作'、'文案'、'报告'、'总结'时响应。" \
    --cleanup "keep"

# 启动数据分析师
echo "  → 启动数据分析师 Agent..."
openclaw sessions spawn \
    --label "feishu-analyst" \
    --mode "session" \
    --thread true \
    --task "你是数据分析师，负责数据分析、图表生成。当用户提到'数据'、'分析'、'统计'、'图表'时响应。" \
    --cleanup "keep"

echo ""
echo "✅ 飞书多 Agent 群聊模式已启动！"
echo ""
echo "💡 使用方式："
echo "  1. 在飞书开放平台发布应用（或开发版本测试）"
echo "  2. 将机器人添加到飞书群聊"
echo "  3. 在群中@具体角色，如：@协调员 分配任务"
echo "  4. 或使用关键词触发，如：'帮我调研一下市场情况'"
echo ""
echo "📊 管理命令："
echo "  - 查看活跃 Agent: openclaw sessions list"
echo "  - 查看子 Agent: openclaw subagents list"
echo "  - 查看消息日志：openclaw channels logs feishu"
echo ""
echo "📝 配置文件：$CONFIG"
echo "📖 使用文档：$FEISHU_GUIDE"
echo ""
echo "🎉 现在可以在飞书群聊中与多 Agent 协作了！"
echo ""
