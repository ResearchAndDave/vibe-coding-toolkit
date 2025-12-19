# AGENTS.md - Python FastAPI Project Example

This is a filled-in example of AGENTS.md for a Python FastAPI backend with PostgreSQL.

---

## NEVER Do

### Security
- Never put credentials in code — use environment variables
- Never commit `.env` files — use `.env.example`
- Never use `eval()` or `exec()` on user input
- Never disable SQL injection protection — always use parameterized queries
- Never log sensitive data (passwords, tokens, PII)

### Code Quality
- Never use `type: ignore` without a comment explaining why
- Never use mutable default arguments (e.g., `def foo(items=[])`)
- Never catch bare `Exception` — catch specific exceptions
- Never leave `print()` statements — use the logger
- Never use `import *`

### Database
- Never write raw SQL — use SQLAlchemy ORM
- Never make schema changes without a migration
- Never delete migrations that have been applied to production

### Process
- Never commit to `main` directly
- Never skip type checking with mypy
- Never merge with failing tests

---

## ALWAYS Do

### Before Coding
- Always activate the virtual environment: `source venv/bin/activate`
- Always check `requirements.txt` for existing utilities before adding dependencies
- Always read existing code in the module before adding new code

### During Coding
- Always use type hints on function signatures
- Always use Pydantic models for request/response validation
- Always use dependency injection for database sessions
- Always use the custom `APIException` for error responses
- Always use async/await for I/O operations

### After Coding
- Always run `mypy .` before committing
- Always run `pytest` before pushing
- Always run `ruff check . --fix` to auto-fix linting

---

## Project Conventions

### File Organization
```
app/
├── api/                 # Route handlers
│   └── v1/
│       ├── users.py
│       └── orders.py
├── core/                # Configuration, security
│   ├── config.py
│   └── security.py
├── db/                  # Database setup
│   ├── base.py
│   └── session.py
├── models/              # SQLAlchemy models
├── schemas/             # Pydantic schemas
├── services/            # Business logic
├── utils/               # Utility functions
└── main.py              # Application entry

tests/
├── conftest.py          # Pytest fixtures
├── api/                 # API tests
└── services/            # Service tests

migrations/              # Alembic migrations
```

### Naming Conventions
- Modules: `snake_case.py`
- Classes: `PascalCase`
- Functions: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`
- Private: `_leading_underscore`

### API Route Structure
```python
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.schemas.user import UserCreate, UserResponse
from app.services.user_service import UserService

router = APIRouter(prefix="/users", tags=["users"])

@router.post("/", response_model=UserResponse)
async def create_user(
    user_data: UserCreate,
    db: Session = Depends(get_db),
) -> UserResponse:
    service = UserService(db)
    return await service.create(user_data)
```

### Pydantic Schema Pattern
```python
from pydantic import BaseModel, EmailStr

# Input schema
class UserCreate(BaseModel):
    email: EmailStr
    name: str

# Output schema
class UserResponse(BaseModel):
    id: int
    email: str
    name: str

    class Config:
        from_attributes = True
```

---

## Build Commands

```bash
# Environment
source venv/bin/activate   # Activate virtualenv
pip install -r requirements.txt  # Install dependencies
pip install -r requirements-dev.txt  # Install dev dependencies

# Development
uvicorn app.main:app --reload  # Start dev server (port 8000)

# Testing
pytest                     # Run all tests
pytest -v                  # Verbose output
pytest tests/api/          # Run specific directory
pytest -k "test_create"    # Run tests matching pattern
pytest --cov=app           # Run with coverage

# Quality
mypy .                     # Type checking
ruff check .               # Linting
ruff check . --fix         # Auto-fix linting
ruff format .              # Format code

# Database
alembic upgrade head       # Apply migrations
alembic revision --autogenerate -m "description"  # Create migration
alembic downgrade -1       # Rollback one migration
```

---

## Key Files

```
# Configuration
pyproject.toml           # Project config, dependencies
requirements.txt         # Production dependencies
requirements-dev.txt     # Development dependencies
.env.example             # Required environment variables
alembic.ini              # Migration config

# Entry Points
app/main.py              # FastAPI application
app/core/config.py       # Settings (from environment)
```

---

## Error Handling Pattern

```python
from app.core.exceptions import APIException

# Raise like this:
raise APIException(
    status_code=404,
    error_code="USER_NOT_FOUND",
    message="User with id {id} not found"
)

# Response format:
{
    "error_code": "USER_NOT_FOUND",
    "message": "User with id 123 not found",
    "details": null
}
```

---

## Notes From Past Sessions

- Database sessions are request-scoped via `Depends(get_db)` — don't create manual sessions
- The `BaseModel` in `app/db/base.py` has `created_at` and `updated_at` — don't add them to models
- Use `app.core.security.get_current_user` for authenticated routes
- Background tasks go in `app/tasks/` and use Celery
- All datetime fields are UTC — convert to local time only in responses

---

*Last updated: 2024-01-15*
*Stack: Python 3.11, FastAPI, SQLAlchemy 2.0, PostgreSQL, Alembic, Pydantic v2*
