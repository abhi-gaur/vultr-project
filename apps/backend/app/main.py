from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Backend is running"}

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/ready")
def ready():
    return {"status": "ready"}

@app.get("/db")
def db():
    return {
        "postgres_host": os.getenv("POSTGRES_HOST", "not-set"),
        "mongo_host": os.getenv("MONGO_HOST", "not-set")
    }

