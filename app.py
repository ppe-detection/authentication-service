# app.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(title="authentication-service")

class LoginRequest(BaseModel):
    email: str
    password: str

@app.get("/health")
def health():
    return {"ok": True, "service": "authentication-service"}

@app.post("/login")
def login(req: LoginRequest):
    # TEMP stub logic — replace with Firebase/Auth later
    if req.email == "test@example.com" and req.password == "secret":
        return {"token": "fake-jwt-123", "user": {"email": req.email}}
    raise HTTPException(status_code=401, detail="invalid credentials")
