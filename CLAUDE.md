# 全局编程规范

## 动手前的强制检查清单

每次开始任务前，必须依次确认以下问题，不跳过：

1. **环境**：当前是否在虚拟环境中？（Python 看 `.venv`，JS 看 `node_modules` 是否存在）
2. **归属**：这个功能属于哪个模块？需要新建模块还是修改现有模块？
3. **规模**：改完后目标文件会超过 400 行吗？如果是，先规划拆分方案
4. **配置**：有没有 URL、路径、密钥、魔法数字需要抽离到配置文件？

想清楚再动手。

---

## 环境管理

**Python**
- 检测到项目没有虚拟环境时，动手前先询问是否需要创建，不默认使用全局环境
- 所有包安装使用虚拟环境内的 pip，禁止全局 `pip install`
- 安装新依赖后立即同步到 `requirements.txt` 或 `pyproject.toml`

**JavaScript / TypeScript**
- 优先使用项目已有的包管理器（`package-lock.json` 用 npm，`yarn.lock` 用 yarn，`pnpm-lock.yaml` 用 pnpm），不混用
- 新增依赖区分 `dependencies` 和 `devDependencies`，不全往 `dependencies` 塞

---

## 模块化与解耦

- 单一职责：每个模块/函数只做一件事，职责必须从名称上一目了然
- 模块间通过接口通信，禁止跨层直接依赖具体实现
- 新功能优先新建独立模块，而不是在现有文件末尾追加

---

## 文件规模控制

- 单个文件不超过 400 行（**IMPORTANT**：硬性上限）
- 文件超过 300 行时，主动提出拆分方案并等待确认，不自行决定
- 函数超过 50 行时说明是否可以拆解，给出具体理由

---

## 配置管理

- 所有配置（URL、密钥、端口、路径、魔法数字）统一写入独立配置文件
- 业务代码中禁止出现任何硬编码配置值，包括看起来无害的默认值
- Python 用 `.env` + `python-dotenv`；JS/TS 用 `.env` + `process.env`
- 配置文件按环境区分（`.env.development` / `.env.production`），不混写

---

## Windows 兼容性

- 路径拼接使用 `pathlib.Path`（Python）或 `path.join()`（Node.js），禁止手写 `\`
- 文件读写明确指定 `encoding="utf-8"`，不依赖系统默认编码
- 下载文件默认保存到当前项目目录（如 `./downloads/`），禁止写入 C 盘系统目录

---

## 运行命令规范

**禁止在 `python -c` 内联脚本中使用 `#` 注释**，否则会触发 Claude Code 的安全误报（quoted newline + #-prefixed line 检测）。

正确写法：
```bash
python -c "
import sqlite3
conn = sqlite3.connect('autolnr.db')
cursor = conn.cursor()
cursor.execute(\"SELECT name FROM sqlite_master WHERE type='table'\")
print([t[0] for t in cursor.fetchall()])
conn.close()
"
```

错误写法（触发警告）：
```bash
python -c "
import sqlite3
# 连接数据库
conn = sqlite3.connect('autolnr.db')
"
```

其他规范：
- 需要保留注释的复杂脚本，写入 `.py` 文件后执行，不使用内联形式
- 多条命令用 `&&` 串联时，每条命令保持单行，避免嵌套引号内换行
- Windows 路径在命令行中使用正斜杠 `/` 或转义反斜杠 `\\`