#!/bin/sh
# ==============================================================================
# docker-entrypoint.sh
# Runs database migrations, collects static files, then starts Gunicorn.
# ==============================================================================
set -e

echo "============================================"
echo " Djesaja LiveBackstage – Container Startup"
echo "============================================"

# ----------------------------------------------------------------
# 1. Run database migrations
# ----------------------------------------------------------------
echo "[1/3] Applying database migrations..."
python manage.py migrate --noinput

# ----------------------------------------------------------------
# 2. Collect static files (for WhiteNoise)
# ----------------------------------------------------------------
echo "[2/3] Collecting static files..."
python manage.py collectstatic --noinput --clear

# ----------------------------------------------------------------
# 3. Start the application server
# ----------------------------------------------------------------
echo "[3/3] Starting Gunicorn..."

WORKERS=${GUNICORN_WORKERS:-3}
TIMEOUT=${GUNICORN_TIMEOUT:-120}

exec gunicorn Djesaja_LiveBackstage.wsgi:application \
    --bind 0.0.0.0:${PORT:-8000} \
    --workers $WORKERS \
    --timeout $TIMEOUT \
    --access-logfile - \
    --error-logfile - \
    --log-level info
