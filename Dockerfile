FROM python:3.9

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt .
# install python dependencies

#Prueba By Emanuell Gelves
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*
    
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# running migrations
RUN python manage.py migrate

# gunicorn
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "core.wsgi"]
