---
paths:
  - "**/*.py"
  - "**/*.pyi"
---


## 标准

- 遵循 **PEP 8** 规范
- 所有函数签名使用 **类型注解**

## Immutability

Prefer immutable data structures:

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class User:
    name: str
    email: str

from typing import NamedTuple

class Point(NamedTuple):
    x: float
    y: float
```

## Formatting

- **black** for code formatting
- **isort** for import sorting
- **ruff** for linting

## Reference

See skill: `python-patterns` for comprehensive Python idioms and patterns.
