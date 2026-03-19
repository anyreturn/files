# 小红书文章仓库

用于存储所有生成和发布的小红书文章及相关资源。

## 目录结构

```
xiaohongshu/
├── README.md           # 本说明文件
├── drafts/             # 草稿目录（未发布的文章）
│   └── YYYY-MM-DD-文章标题/
│       ├── article.md  # 文章正文
│       └── notes.md    # 创作笔记/灵感
├── published/          # 已发布文章归档
│   └── YYYY-MM-DD-文章标题/
│       ├── article.md      # 最终发布版本
│       ├── publish-info.json  # 发布信息（时间、链接、数据等）
│       └── screenshots/     # 发布截图/数据截图
└── assets/             # 公共资源库
    ├── images/         # 图片资源
    ├── templates/      # 文章模板
    └── references/     # 参考资料
```

## 使用规范

### 1. 草稿命名
- 格式：`YYYY-MM-DD-文章主题.md`
- 示例：`2026-03-20-Java 项目 AI 友好性指南.md`

### 2. 发布归档
每篇文章发布后，在 `published/` 目录下创建文件夹，包含：
- `article.md` - 最终发布版本
- `publish-info.json` - 发布元数据
- `screenshots/` - 相关截图

### 3. publish-info.json 格式
```json
{
  "title": "文章标题",
  "publishDate": "2026-03-20T10:30:00+08:00",
  "url": "https://www.xiaohongshu.com/explore/xxx",
  "noteId": "xxx",
  "tags": ["标签 1", "标签 2"],
  "stats": {
    "views": 0,
    "likes": 0,
    "collects": 0,
    "comments": 0
  }
}
```

## Git 提交规范

- 草稿创建：`feat: 创建 [文章标题] 草稿`
- 草稿更新：`update: 更新 [文章标题]`
- 文章发布：`publish: 发布 [文章标题]`
- 数据更新：`data: 更新 [文章标题] 统计数据`

## 自动备份

每次生成或发布小红书文章时，会自动在此仓库保存一份副本。
