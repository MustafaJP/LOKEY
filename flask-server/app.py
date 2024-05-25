from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app) #accept CORS API requesting

# Default route
@app.route("/")
def home():
    return "Hello, World!"

# Members API Route
@app.route("/members")
def members():
    return {"members": ["Member1", "Member2", "Member3"]}

if __name__ == "__main__":
    app.run(debug=True)