<div align="center">

# 🚀 Djesaja LiveBackstage AI Hub

**The AI-powered automation platform for TikTok Live agencies**

[![Django](https://img.shields.io/badge/Django-6.0-green?logo=django)](https://www.djangoproject.com/)
[![DRF](https://img.shields.io/badge/DRF-3.16-orange)](https://www.django-rest-framework.org/)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

</div>

---

## 📋 Table of Contents

1. [Project Overview](#-project-overview)
2. [Architecture](#-architecture)
3. [Features](#-features)
4. [Tech Stack](#-tech-stack)
5. [Folder Structure](#-folder-structure)
6. [Prerequisites](#-prerequisites)
7. [Environment Setup](#-environment-setup)
8. [Development Setup (Local)](#-development-setup-local)
9. [Docker Deployment](#-docker-deployment)
10. [Production Deployment (VPS)](#-production-deployment-ubuntu-vps)
11. [API Overview](#-api-overview)
12. [Database Schema](#-database-schema)
13. [Authentication & Roles](#-authentication--roles)
14. [Background Jobs & Cron](#-background-jobs--cron)
15. [AI Service Integration](#-ai-service-integration)
16. [Security](#-security)
17. [Monitoring & Logging](#-monitoring--logging)
18. [Backup & Restore](#-backup--restore)
19. [Troubleshooting](#-troubleshooting)
20. [Known Issues & Improvement Roadmap](#-known-issues--improvement-roadmap)
21. [Contributing](#-contributing)
22. [License](#-license)

---

## 📌 Project Overview

**Djesaja LiveBackstage AI Hub** is a production-grade, AI-driven backend system built specifically for **TikTok Live talent agencies**. It automates the full workflow from data collection to AI-generated performance insights:

- **Scrapes** creator and manager performance data from the TikTok Live Backstage dashboard using a headless Chromium browser (Playwright)
- **Stores** structured creator/manager/reporting-month data in a relational database
- **Calls an external AI microservice** to generate daily and monthly performance summaries, targets, scenarios, and alerts for every creator and manager
- **Serves** all data through a RESTful JWT-authenticated API consumed by a **Flutter mobile app**

---

## 🏗️ Architecture

```
┌────────────────────────────────────────────────────────────────┐
│                   Djesaja LiveBackstage System                 │
│                                                                │
│   ┌──────────────────┐         ┌──────────────────────────┐   │
│   │  Flutter Mobile  │  ←JWT→  │  Django REST API         │   │
│   │  (iOS / Android) │         │  Port: 8000              │   │
│   └──────────────────┘         │  /auth/  /api/  /swagger/│   │
│                                └────────────┬─────────────┘   │
│                                             │                  │
│                          ┌──────────────────┼───────────┐     │
│                          │                  │           │     │
│                  ┌───────┴──────┐   ┌───────┴──────┐   │     │
│                  │  PostgreSQL  │   │  External AI  │   │     │
│                  │  Database    │   │  Microservice │   │     │
│                  └─────────────┘   │  :8026        │   │     │
│                                    └───────────────┘   │     │
│                                                         │     │
│   ┌─────────────────────────────────────────────────┐  │     │
│   │  Background Worker (Cron — every hour at :10)   │  │     │
│   │  1. Playwright scrapes TikTok Live Backstage     │  │     │
│   │  2. Saves managers + creators to DB              │  │     │
│   │  3. Sends data to AI microservice                │  │     │
│   │  4. Saves AI insights back to DB                 │  │     │
│   └─────────────────────────────────────────────────┘  │     │
└────────────────────────────────────────────────────────────────┘
```

### Dependency Flow

```
TikTok Backstage Portal
        ↓ (Playwright scraper)
  scripts/scraper.py
        ↓
  scripts/load_data.py      →  accounts / managers / creators (DB)
        ↓
  ai_insights/ai_requests.py →  External AI Service (:8026)
        ↓
  AITarget, AIManagerTarget, AIDailySummary, AIScenario, AIMetric (DB)
        ↓
  REST API (Django)
        ↓
  Flutter Mobile App
```

---

## ✨ Features

| Feature | Description |
|---|---|
| **Automated Scraping** | Playwright-based headless Chromium scrapes TikTok Live Backstage hourly |
| **AI-Driven Insights** | Daily and monthly AI summaries, targets, scenarios, and alerts per creator/manager |
| **JWT Authentication** | Secure token-based auth with 7-day access tokens |
| **Role-Based Access** | `SUPER_ADMIN`, `MANAGER`, `CREATOR` roles with fine-grained permission control |
| **Multi-Auth Login** | Login via username, email, OR TikTok UID |
| **OTP Email System** | 6-digit OTP for email verification and password reset |
| **Dashboard APIs** | Separate dashboards for Admin, Manager, and Creator |
| **Swagger / Redoc Docs** | Interactive API documentation at `/swagger/` and `/redoc/` |
| **Flutter Mobile App** | Cross-platform iOS/Android app with role-based navigation |
| **Docker-Ready** | Full production containerization with PostgreSQL, Gunicorn, and cron worker |

---

## 🛠️ Tech Stack

### Backend
| Layer | Technology |
|---|---|
| Framework | Django 6.0.1 |
| API | Django REST Framework 3.16.1 |
| Auth | SimpleJWT 5.5.1 |
| Database (Dev) | SQLite |
| Database (Prod) | PostgreSQL 16 |
| Scraping | Playwright 1.57.0 (Chromium) |
| WSGI Server | Gunicorn 21.2.0 |
| Static Files | WhiteNoise 6.11.0 |
| API Docs | drf-yasg (Swagger + Redoc) |
| Config Management | python-decouple |
| Image Processing | Pillow 12.1.0 |

### Mobile (Flutter)
| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart 3.10+) |
| HTTP Client | `http` package |
| Charts | `fl_chart` |
| Image Picker | `image_picker` |
| SVG Support | `flutter_svg` |
| Localization | `easy_localization` |
| Splash Screen | `flutter_native_splash` |

### Infrastructure
| Component | Technology |
|---|---|
| Containerization | Docker + Docker Compose |
| Reverse Proxy | Nginx |
| Process Manager | Gunicorn |
| OS | Ubuntu 22.04 LTS |

---

## 📁 Folder Structure

```
project_27_djesaja_llive-backstage_ai_hub/
│
├── backend/                          # Django REST API backend
│   ├── Djesaja_LiveBackstage/        # Project config (settings, urls, wsgi)
│   │   ├── settings.py               # All settings (env-driven in production)
│   │   ├── urls.py                   # Root URL routing
│   │   ├── wsgi.py                   # WSGI entry point
│   │   └── asgi.py                   # ASGI entry point
│   │
│   ├── accounts/                     # User model, auth, OTP, profile
│   │   ├── models.py                 # User, OTP models
│   │   ├── views.py                  # Login, profile, password reset views
│   │   ├── urls.py                   # /auth/ routes
│   │   ├── auth_backends.py          # Login by username OR email OR UID
│   │   └── utils.py                  # OTP generate/verify, email sender
│   │
│   ├── managers/                     # Manager profile data per reporting month
│   │   ├── models.py                 # Manager model
│   │   ├── views.py                  # Manager list + detail API
│   │   └── urls.py                   # /api/managers/ routes
│   │
│   ├── creators/                     # Creator profile data per reporting month
│   │   ├── models.py                 # Creator model
│   │   ├── views.py                  # Creator list + detail API
│   │   └── urls.py                   # /api/creators/ routes
│   │
│   ├── api/                          # Shared models, permissions, routing hub
│   │   ├── models.py                 # ReportingMonth model
│   │   ├── permissions.py            # IsAdmin, IsManager, IsCreator
│   │   └── urls.py                   # Aggregates all api/ sub-routes
│   │
│   ├── dashboard/                    # Role-specific dashboard data endpoints
│   │   ├── views.py                  # AdminDashboard, ManagerDashboard, CreatorDashboard
│   │   ├── utils.py                  # Dashboard query helpers
│   │   └── urls.py                   # /api/dashboard/ routes
│   │
│   ├── ai_insights/                  # AI data models, views, and request logic
│   │   ├── models.py                 # AITarget, AIDailySummary, AIScenario, AIMetric, AIMessage
│   │   ├── ai_requests.py            # Calls external AI microservice, saves responses
│   │   ├── views.py                  # AI response API (role-based)
│   │   └── urls.py                   # /api/ai-response/ routes
│   │
│   ├── scripts/                      # Data pipeline scripts
│   │   ├── scraper.py                # Playwright TikTok Backstage scraper
│   │   ├── load_data.py              # Parse + save scraped data to DB
│   │   └── state.json                # Playwright browser auth state (session cookies)
│   │
│   ├── jobs/                         # Scheduled job runners
│   │   ├── run_scrape_and_daily.py   # Master runner: scrape → daily AI
│   │   ├── scrape_job.py             # Run scraper only
│   │   ├── daily_ai_job.py           # Run daily AI analysis only
│   │   ├── monthly_ai_job.py         # Run monthly AI analysis (runs on day 1)
│   │   └── crontab_cmnd.txt          # Cron schedule reference
│   │
│   ├── Dockerfile                    # Multi-stage production Docker image
│   ├── docker-entrypoint.sh          # Container startup: migrate → collectstatic → gunicorn
│   ├── .dockerignore                 # Docker build exclusions
│   ├── requirements.txt              # Python dependencies
│   └── manage.py                     # Django management CLI
│
├── app-codebase/                     # Flutter mobile application
│   ├── lib/
│   │   ├── app/                      # App entry, MaterialApp config
│   │   ├── core/                     # Role definitions (UiUserRole enum)
│   │   ├── common/                   # Shared widgets (AppShell, CustomButton, etc.)
│   │   └── features/                 # Feature modules
│   │       ├── auth/                 # Login, forgot password, OTP verify screens
│   │       ├── home/                 # Home screen
│   │       ├── manager/              # Manager dashboard screens + widgets
│   │       ├── creator/              # Creator dashboard screens
│   │       ├── alert/                # Alert screens
│   │       ├── target/               # Target screens
│   │       └── more/                 # Settings, profile, edit screens
│   ├── assets/                       # Images, SVGs, fonts
│   └── pubspec.yaml                  # Flutter dependencies
│
├── docker-compose.yml                # Base Docker Compose (all services)
├── docker-compose.dev.yml            # Dev override (hot reload, SQLite, console email)
├── docker-compose.prod.yml           # Prod override (PostgreSQL, Gunicorn, logging)
├── .env.example                      # Environment variable reference template
└── README.md                         # This file
```

---

## ✅ Prerequisites

### For Docker Deployment
- Docker Engine ≥ 24.0
- Docker Compose ≥ 2.20
- A `.env` file copied from `.env.example` and filled in

### For Local Development
- Python 3.11+
- pip / virtualenv
- Node.js (optional, for tooling)
- Flutter SDK 3.10+ (for mobile app)
- Git

---

## ⚙️ Environment Setup

```bash
# 1. Clone the repository
git clone <your-repo-url>
cd project_27_djesaja_llive-backstage_ai_hub

# 2. Copy and configure the environment file
cp .env.example .env
# Edit .env with your values — especially SECRET_KEY, email settings, AI_SERVICE_BASE_URL
```

### Minimum Required Variables for Development

```env
SECRET_KEY=any-random-string-at-least-50-chars
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
EMAIL_BACKEND=django.core.mail.backends.console.EmailBackend
AI_SERVICE_BASE_URL=http://your-ai-service-ip:8026
```

---

## 💻 Development Setup (Local)

```bash
cd backend

# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate         # Linux / macOS
.venv\Scripts\activate            # Windows

# Install dependencies
pip install -r requirements.txt

# Install Playwright browser binaries
playwright install chromium

# Create .env in the backend directory
cp ../.env.example .env
# Edit .env as needed

# Apply database migrations
python manage.py migrate

# Create a superuser
python manage.py createsuperuser

# Start the development server
python manage.py runserver
```

The API will be live at: http://127.0.0.1:8000/
- Swagger UI: http://127.0.0.1:8000/swagger/
- Redoc: http://127.0.0.1:8000/redoc/
- Admin Panel: http://127.0.0.1:8000/admin/

---

## 🐳 Docker Deployment

### Development (SQLite + hot reload)

```bash
# Start only the backend in dev mode (uses docker-compose.dev.yml override)
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build

# The API is available at: http://localhost:8000/
```

### Staging / Production (PostgreSQL + Gunicorn)

```bash
# 1. Create your .env file from the template
cp .env.example .env
# Fill in: SECRET_KEY, DB_*, EMAIL_*, AI_SERVICE_BASE_URL

# 2. Build and start all services (backend + db + worker)
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build

# 3. View logs
docker compose logs -f backend

# 4. Check container health
docker compose ps
```

### Useful Docker Commands

```bash
# Run a management command inside the container
docker compose exec backend python manage.py createsuperuser
docker compose exec backend python manage.py migrate

# Run the scraper manually
docker compose exec backend python jobs/scrape_job.py

# Run daily AI job manually
docker compose exec backend python jobs/daily_ai_job.py

# Access the database (PostgreSQL)
docker compose exec db psql -U livebackstage_user -d livebackstage_db

# Rebuild only the backend image
docker compose build backend

# Stop all services
docker compose down

# Stop and remove all volumes (DANGER: deletes database data)
docker compose down -v
```

---

## 🖥️ Production Deployment (Ubuntu VPS)

### 1. Server Preparation

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker

# Install Docker Compose
sudo apt install docker-compose-plugin -y

# Verify
docker --version
docker compose version
```

### 2. Deploy the Application

```bash
# Clone repository
git clone <repo-url> /opt/livebackstage
cd /opt/livebackstage

# Configure environment
cp .env.example .env
nano .env  # Fill in all production values

# Start services
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
```

### 3. Nginx Reverse Proxy (Port 80 / 443)

Install Nginx on the host:

```bash
sudo apt install nginx -y
```

Create `/etc/nginx/sites-available/livebackstage`:

```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    # Redirect to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;

    ssl_certificate     /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    # Security headers
    add_header X-Frame-Options "DENY" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

    client_max_body_size 50M;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 60s;
        proxy_read_timeout 120s;
    }

    location /media/ {
        alias /opt/livebackstage/media/;
        expires 30d;
    }

    location /static/ {
        alias /opt/livebackstage/staticfiles/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/livebackstage /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

### 4. SSL with Let's Encrypt

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
# Certbot automatically renews via systemd timer
```

### 5. Firewall Setup

```bash
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 80/tcp    # HTTP
sudo ufw allow 443/tcp   # HTTPS
sudo ufw deny 8000       # Block direct backend access
sudo ufw enable
```

---

## 📡 API Overview

Base URL: `https://yourdomain.com`

All protected endpoints require: `Authorization: Bearer <access_token>`

### Authentication (`/auth/`)

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | `/auth/login/` | ❌ | Login with username/email/UID → JWT tokens |
| POST | `/auth/token/refresh/` | ❌ | Refresh access token |
| GET | `/auth/me/` | ✅ | Get authenticated user profile |
| PATCH | `/auth/me/update/` | ✅ | Update profile (name, image) |
| POST | `/auth/me/change-password/` | ✅ | Change password |
| POST | `/auth/me/send-email-otp/` | ✅ | Send OTP to email for verification |
| POST | `/auth/me/verify-email-otp/` | ✅ | Verify email OTP |
| POST | `/auth/forgot-password/` | ❌ | Send password reset OTP to email |
| POST | `/auth/verify-otp/` | ❌ | Verify password reset OTP |
| POST | `/auth/reset-password/` | ❌ | Set new password after OTP verification |
| POST | `/auth/resend-otp/` | ❌ | Resend OTP (30s cooldown) |

### Managers (`/api/managers/`)

| Method | Endpoint | Auth | Roles | Description |
|--------|----------|------|-------|-------------|
| GET | `/api/managers/` | ✅ | Any | List managers (filter by `?month=YYYYMM`) |
| GET | `/api/managers/{id}/` | ✅ | Any | Get single manager details |

### Creators (`/api/creators/`)

| Method | Endpoint | Auth | Roles | Description |
|--------|----------|------|-------|-------------|
| GET | `/api/creators/` | ✅ | Any | List creators |
| GET | `/api/creators/{id}/` | ✅ | Any | Get single creator details |

### Dashboard (`/api/dashboard/`)

| Method | Endpoint | Auth | Roles | Description |
|--------|----------|------|-------|-------------|
| GET | `/api/dashboard/admin/` | ✅ | SUPER_ADMIN | Full agency overview (all managers + stats) |
| GET | `/api/dashboard/manager/` | ✅ | MANAGER, SUPER_ADMIN | Manager's own team data |
| GET | `/api/dashboard/creator/` | ✅ | CREATOR, MANAGER, SUPER_ADMIN | Creator performance data |
| GET | `/api/dashboard/creator/rank/` | ✅ | CREATOR | Creator's rank within their manager's team |

### AI Insights (`/api/`)

| Method | Endpoint | Auth | Roles | Description |
|--------|----------|------|-------|-------------|
| GET | `/api/ai-response/` | ✅ | Any | Get AI dashboard data (role-based) |
| GET | `/api/ai-response/admin-overview/` | ✅ | SUPER_ADMIN | All creators' daily AI summary |
| GET | `/api/ai-response/manager-overview/` | ✅ | MANAGER, SUPER_ADMIN | Manager's creators' AI summaries |
| GET | `/api/ai-response/alerts` | ✅ | Any | Active AI alerts for current user |

### Documentation

| Endpoint | Description |
|----------|-------------|
| `/swagger/` | Swagger UI (interactive API explorer) |
| `/redoc/` | Redoc UI (readable API documentation) |
| `/admin/` | Django Admin panel |

---

## 🗄️ Database Schema

### `accounts_user`
| Column | Type | Notes |
|--------|------|-------|
| id | INTEGER PK | Auto |
| username | VARCHAR(250) UNIQUE | Primary login identifier |
| uid | VARCHAR(100) | TikTok UID (indexed) |
| email | EMAIL UNIQUE | Optional |
| name | VARCHAR(255) | Display name |
| profile_image | IMAGE | Upload to `profiles/` |
| email_verified | BOOLEAN | Default: False |
| role | VARCHAR(20) | `SUPER_ADMIN`, `MANAGER`, `CREATOR` |
| is_active | BOOLEAN | Default: True |
| is_staff | BOOLEAN | Django admin access |
| created_at | DATETIME | Auto |
| updated_at | DATETIME | Auto |

### `accounts_otp`
| Column | Type | Notes |
|--------|------|-------|
| id | INTEGER PK | |
| user_id | FK → accounts_user | Cascade delete |
| code | VARCHAR(6) | 6-digit OTP |
| purpose | VARCHAR(30) | `verify_email`, `forgot_password` |
| created_at | DATETIME | Expires after 5 minutes |

### `api_reportingmonth`
| Column | Type | Notes |
|--------|------|-------|
| id | INTEGER PK | |
| code | VARCHAR(6) UNIQUE | Format: `YYYYMM` e.g. `202601` |
| year | INTEGER | Auto-extracted from code |
| month | INTEGER | Auto-extracted from code |
| created_at | DATETIME | Auto |

### `managers_manager`
| Column | Type | Notes |
|--------|------|-------|
| id | INTEGER PK | |
| user_id | FK → accounts_user | |
| report_month_id | FK → api_reportingmonth | |
| manager_uid | VARCHAR(100) | TikTok agent ID (indexed) |
| eligible_creators | INTEGER | |
| estimated_bonus_contribution | FLOAT | |
| diamonds | INTEGER | |
| M_0_5, M1, M2, M1R | INTEGER | Milestone counts |
| created_at, updated_at | DATETIME | |
| UNIQUE | (user, report_month) | No duplicate per month |

### `creators_creator`
| Column | Type | Notes |
|--------|------|-------|
| id | INTEGER PK | |
| user_id | FK → accounts_user | |
| manager_id | FK → managers_manager | |
| report_month_id | FK → api_reportingmonth | |
| creator_uid | VARCHAR(100) | TikTok creator ID (indexed) |
| group_name | VARCHAR(255) | |
| estimated_bonus_contribution | FLOAT | |
| achieved_milestones | JSON | List of milestone strings |
| diamonds | INTEGER | |
| valid_go_live_days | INTEGER | |
| live_duration | FLOAT | Hours |
| UNIQUE | (creator_uid, report_month) | No duplicate per month |

### `ai_insights_*` Tables

| Table | Purpose |
|-------|---------|
| `ai_insights_aitarget` | Per-creator monthly target (milestone + diamonds) |
| `ai_insights_aimanagertarget` | Per-manager team diamond target |
| `ai_insights_aidailysummary` | Daily AI summary, reason, actions, alert |
| `ai_insights_aiscenario` | JSON scenario data per creator/month |
| `ai_insights_aimetric` | JSON metric data per creator/month |
| `ai_insights_aimessage` | Welcome/notification messages |

---

## 🔐 Authentication & Roles

### Login Flow

```
POST /auth/login/
Body: { "username": "john_doe", "password": "secret" }

→ 200 OK: { "access": "eyJ...", "refresh": "eyJ..." }
```

The `UsernameEmailUIDBackend` allows login with any of:
- `username` field
- `email` field
- TikTok `uid` field

### JWT Token Usage

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

Access token lifetime: **7 days**

### Roles & Permissions

| Role | Code | Access Level |
|------|------|-------------|
| Super Admin | `SUPER_ADMIN` | Full access to all data for all managers/creators |
| Manager | `MANAGER` | Access to own team's creators only |
| Creator | `CREATOR` | Access to own data only |

---

## ⏰ Background Jobs & Cron

The system runs 3 scheduled jobs orchestrated by `jobs/run_scrape_and_daily.py`:

### Job Schedule (Hourly at :10)

```
┌──── Every hour at minute 10 ─────────────────────────────────┐
│                                                               │
│  1. jobs/scrape_job.py                                        │
│     → Playwright opens TikTok Live Backstage (headless)       │
│     → Scrapes all manager rows + creator details via XHR      │
│     → Calls save_manager_chunk() for each manager             │
│     → Creates/updates User, Manager, Creator records in DB    │
│                                                               │
│  2. (On day 1 of month only) jobs/monthly_ai_job.py           │
│     → Sends previous month data to AI service                 │
│     → Saves targets, welcome messages to DB                   │
│                                                               │
│  3. jobs/daily_ai_job.py                                      │
│     → Sends current month data to AI service (per manager)    │
│     → Saves AIDailySummary, AIScenario, AIMetric to DB        │
│                                                               │
└──────────────────────────────────────────────────────────────┘
```

### Playwright Auth State

The scraper requires a valid TikTok session. The authenticated browser state is stored in `scripts/state.json`. **This file must be refreshed when the TikTok session expires.**

To refresh the session state:
1. Run Playwright in headed mode (change `headless=True` to `headless=False` in `scraper.py`)
2. Log in to TikTok Live Backstage manually
3. Save the browser context state to `scripts/state.json`

---

## 🤖 AI Service Integration

The system integrates with an external AI microservice at the URL configured in `AI_SERVICE_BASE_URL`.

### Endpoints Called

| Mode | Endpoint | Trigger |
|------|----------|---------|
| `daily` | `{AI_SERVICE_BASE_URL}/v1/daily/run` | Every hour |
| `month_start` | `{AI_SERVICE_BASE_URL}/v1/month-start/run` | Day 1 of each month |

### Request Payload (Daily)

```json
{
  "snapshot_time": "202601",
  "managers": [{ "id": 1, "user": {...}, "diamonds": 50000, ... }],
  "creators": [{ "id": 5, "manager": 1, "diamonds": 8000, ... }]
}
```

### Response Saved

The AI service returns creator-level summaries, scenarios, metrics, and alerts which are persisted to `AIDailySummary`, `AIScenario`, `AIMetric` models.

---

## 🔒 Security

### Current Status

| Check | Status | Notes |
|-------|--------|-------|
| SECRET_KEY from env | ✅ Fixed | Was hardcoded in original settings.py |
| DEBUG=False in prod | ✅ Fixed | Now env-controlled |
| ALLOWED_HOSTS restriction | ✅ Fixed | Now env-controlled (was `*`) |
| Non-root Docker user | ✅ | `appuser` (UID 1000) |
| JWT authentication | ✅ | All API routes protected |
| Password hashing | ✅ | Django PBKDF2 |
| CORS | ⚠️ | `CORS_ALLOW_ALL_ORIGINS=True` by default — restrict in production |
| debug_toolbar in prod | ✅ Fixed | Now only loaded when `DEBUG=True` |
| Hardcoded AI IP | ✅ Fixed | Now in `AI_SERVICE_BASE_URL` env var |
| OTP brute force | ⚠️ | No rate limiting on OTP verify endpoints |
| SQL injection | ✅ | Django ORM used throughout |
| CSRF | ✅ | CSRF middleware enabled |
| HTTPS | ✅ | Via Nginx + Let's Encrypt |
| Security headers | ✅ | Enabled in production via settings |

### Production Security Checklist

- [ ] Set `DEBUG=False`
- [ ] Set a long random `SECRET_KEY`
- [ ] Set `ALLOWED_HOSTS` to your domain only
- [ ] Set `CORS_ALLOW_ALL_ORIGINS=False` and list your domains in `CORS_ALLOWED_ORIGINS`
- [ ] Use PostgreSQL (not SQLite) in production
- [ ] Enable Nginx with HTTPS / Let's Encrypt
- [ ] Configure UFW firewall
- [ ] Never commit `.env` to git

---

## 📊 Monitoring & Logging

### Docker Logs

```bash
# Follow all service logs
docker compose logs -f

# Backend only
docker compose logs -f backend

# Worker only
docker compose logs -f worker
```

Logs are configured with `max-size: 10m, max-file: 5` in production compose.

### Healthcheck

The backend container has a built-in healthcheck:

```bash
# Check container health status
docker compose ps
# HEALTHY / UNHEALTHY is shown in the STATUS column
```

---

## 💾 Backup & Restore

### PostgreSQL Backup

```bash
# Create a backup
docker compose exec db pg_dump -U livebackstage_user livebackstage_db > backup_$(date +%Y%m%d).sql

# Restore from backup
docker compose exec -T db psql -U livebackstage_user -d livebackstage_db < backup_20260101.sql
```

### Media Files Backup

```bash
# Backup uploaded media (profile images)
docker run --rm -v livebackstage_media_data:/data -v $(pwd):/backup alpine \
    tar czf /backup/media_$(date +%Y%m%d).tar.gz -C /data .

# Restore media
docker run --rm -v livebackstage_media_data:/data -v $(pwd):/backup alpine \
    tar xzf /backup/media_20260101.tar.gz -C /data
```

### Automated Backups (Cron on Host)

Add to host crontab (`crontab -e`):

```
0 2 * * * cd /opt/livebackstage && docker compose exec -T db pg_dump -U livebackstage_user livebackstage_db > /opt/backups/db_$(date +\%Y\%m\%d).sql
```

---

## 🔧 Troubleshooting

### Container won't start

```bash
# Check entrypoint logs
docker compose logs backend

# Common cause: missing .env variables
# Run: docker compose config  to see resolved config
```

### Migrations fail

```bash
# Run migrations manually inside container
docker compose exec backend python manage.py migrate --noinput

# Check current migration state
docker compose exec backend python manage.py showmigrations
```

### Playwright / Scraper fails

1. Check `scripts/state.json` exists and is valid (TikTok session not expired)
2. Run scraper manually: `docker compose exec backend python jobs/scrape_job.py`
3. Check for "Session expired" or "Login required" in logs

### AI Service connection fails

```bash
# Verify AI_SERVICE_BASE_URL is correct
docker compose exec backend env | grep AI_SERVICE

# Test connectivity
docker compose exec backend curl http://<ai-service-ip>:8026/health
```

### Database connection refused

```bash
# Check PostgreSQL container is running
docker compose ps db

# Check DB logs
docker compose logs db

# Verify DB env vars match in .env
```

---

## 🚀 Known Issues & Improvement Roadmap

### Known Issues

| Issue | Severity | Status |
|-------|----------|--------|
| Flutter app has no real API integration (UI only with mock data) | 🔴 Critical | Open |
| OTP endpoints have no rate limiting (brute-force risk) | 🟠 High | Open |
| `debug_toolbar` was loaded in production | 🟠 High | ✅ Fixed |
| `SECRET_KEY` was hardcoded in source | 🔴 Critical | ✅ Fixed |
| `ALLOWED_HOSTS = ["*"]` in production | 🟠 High | ✅ Fixed |
| Hardcoded AI service IP in source code | 🟠 High | ✅ Fixed |
| `scripts/state.json` contains live TikTok session cookies | 🔴 Critical | Manual rotation needed |
| Default password `"1234"` set for auto-created users | 🔴 Critical | Change after first sync |
| No Playwright health check before scraper runs | 🟡 Medium | Open |
| No retry/backoff for AI service calls | 🟡 Medium | Open |
| `CORS_ALLOW_ALL_ORIGINS=True` by default | 🟠 High | Set to False in prod |

### Improvement Roadmap

1. **Flutter API Integration** — Connect screens to the Django REST API using proper service classes and state management (Provider/Riverpod)
2. **Rate Limiting** — Add `django-ratelimit` or Nginx rate limiting on OTP and login endpoints
3. **Task Queue** — Replace the cron-based worker with Celery + Redis for reliable async job execution
4. **Playwright Auth Rotation** — Automate TikTok session refresh or add Playwright login automation
5. **Monitoring** — Add Sentry for error tracking, Prometheus + Grafana for metrics
6. **Testing** — Add unit tests and integration tests (currently test files are empty)
7. **CI/CD** — GitHub Actions pipeline for automated testing and deployment
8. **PostgreSQL Migration** — Add `psycopg2-binary` to requirements for PostgreSQL support
9. **Admin Dashboard** — Build a web-based admin dashboard in addition to the Flutter app

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'feat: add my feature'`
4. Push to branch: `git push origin feature/my-feature`
5. Open a Pull Request

### Coding Standards

- Python: Follow PEP 8, use type hints where appropriate
- Django: Use class-based views, keep business logic in `utils.py` not views
- Dart/Flutter: Follow official Flutter style guide
- Commits: Use Conventional Commits format (`feat:`, `fix:`, `docs:`, etc.)

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](backend/LICENSE) file for details.

---

<div align="center">

Built with ❤️ by **[Arif](https://www.linkedin.com/in/aru01/)**

</div>
