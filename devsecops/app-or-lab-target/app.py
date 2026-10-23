from flask import Flask, request
import os
import subprocess

app = Flask(__name__)

# Intentional Hardcoded Secret for Semgrep/Trivy to catch
API_KEY = "sk_live_12345abcdef987654321"

@app.route("/")
def home():
    return "Welcome to the DevSecOps Lab Target App!"

@app.route("/ping")
def ping():
    # Intentional Command Injection vulnerability for SAST demonstration
    target = request.args.get("host", "127.0.0.1")
    output = subprocess.check_output(f"ping -c 1 {target}", shell=True)
    return f"<pre>{output.decode()}</pre>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
