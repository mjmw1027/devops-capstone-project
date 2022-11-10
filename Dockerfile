# 5. FROM python image
FROM python:3.9-slim

# 6. workdir
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 7. copy service package
COPY service/ ./service/

# 8. create user theia
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# 9. expose port 8080 + statemens
EXPOSE 8080
cmd ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]




