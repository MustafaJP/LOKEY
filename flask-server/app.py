from prediction import predict_emergency_fund
from flask import Flask, request, jsonify
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

# Predict emergency fund
@app.route("/predict_emergency_fund", methods=['POST'])
def predict_emergency_fund_route():
    user_input = request.json
    result, status_code = predict_emergency_fund(user_input)
    return jsonify(result), status_code

if __name__ == "__main__":
    app.run(debug=True)