# Peak
Peak is a Not So Peak RESTful backend API built with FastAPI, PostgreSQL, SQLAlchemy, and JWT authentication, containerized using Docker and Nginx with rate-limiting and security headers.

![fetchpik com-kxtpXeMd8m](https://github.com/user-attachments/assets/fedc238d-f99e-4381-91fc-e4674cf85d22)


## Structure
```bash
Peak/
├── app/
│   ├── main.py            # FastAPI app entrypoint
│   ├── config.py          # Environment configuration
│   ├── database.py        # DB engine & session
│   ├── models.py          # SQLAlchemy models
│   ├── schemas.py         # Pydantic schemas
│   ├── oauth2.py          # JWT auth logic
│   ├── utils.py           # Password hashing
│   ├── calculations.py    # Utility / demo logic
│   └── routers/
│       ├── auth.py        # Authentication routes
│       ├── user.py        # User routes
│       ├── post.py        # Post routes
│       └── vote.py        # Voting routes
│
├── nginx/
│   └── nginx.conf         # Reverse proxy + rate limits
│
├── Dockerfile
├── docker-compose.yml
├── pyproject.toml
├── uv.lock
└── README.md
```
## Architecture
```bash
Client
  │
  ▼
Nginx (80) Nginx handles traffic, rate limits, headers
  │
  ▼
FastAPI (8000) FastAPI handles business logic
  │
  ▼
PostgreSQL PostgreSQL stores users, posts, votes
```

- OAuth2 password flow
- JWT tokens signed with HS256
- Tokens include `user_id`
- Protected routes require `Authorization: Bearer <token>`
## Setup

Setup Postgres with tables and database using `psql` or `PgAdmin`.

`.env` - Create a .env file in the project root:

```bash
python -c "import secrets; print(secrets.token_hex(32))"
```

```bash
DATABASE_HOSTNAME=db
DATABASE_PORT=5432
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=password123
DATABASE_NAME=fastapi

SECRET_KEY=your_super_secret_key
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```
## Running with Docker
Build & start everything:

```bash
docker-compose up --build
```
## API Endpoints:
- `POST /login` – Login and receive JWT token

- `POST /users` – Create a new user

- `GET /users/{id}` – Retrieve user by ID

- `GET /posts` – List posts

- `POST /posts` – Create a new post

- `GET /posts/{id}` – Retrieve a single post

- `PUT /posts/{id}` – Update a post

- `DELETE /posts/{id}` – Delete a post

- `POST /vote` – Add or remove a vote on a post

Payload example:

```json
{
  "post_id": 1,
  "dir": 1  // 1 = upvote, 0 = remove vote
}
```

#### Supports query params:

- limit – number of posts to return

- skip – number of posts to skip (pagination)

- search – filter posts by title

#### Service	URL:

- API	`http://localhost`

- Swagger UI	`http://localhost/docs`

- OpenAPI JSON	`http://localhost/openapi.json`

- Health Check	`http://localhost/health`

## Nginx Protections

- Rate limiting: 10 requests/sec
- Burst (defines the size of a temporary queue for requests that exceed your set rate limit): 20
- Connection limit: 10 per IP
#### Security headers:
- X-Frame-Options
- X-Content-Type-Options
- XSS Protection
- Max upload: 10MB

---
