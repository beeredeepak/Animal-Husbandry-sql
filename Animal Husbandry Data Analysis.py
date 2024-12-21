import pandas as pd
import numpy as np

# Load data from CSV or SQL database
data = pd.read_csv('animal_data.csv')

# Handle missing values
data.fillna(method='ffill', inplace=True)

# Convert categorical variables to numerical
data = pd.get_dummies(data, columns=['AnimalType', 'Breed', 'Illness', 'FeedType'])

# Feature engineering
data['Age'] = (pd.to_datetime('today') - pd.to_datetime(data['BirthDate'])).dt.days / 365

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score

# Split data into features and target variable
X = data.drop('Weight', axis=1)  # Assuming 'Weight' is the target variable
y = data['Weight']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train a linear regression model
model = LinearRegression()
model.fit(X_train, y_train)

# Make predictions
y_pred = model.predict(X_test)

# Evaluate the model
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
print(f"Mean Squared Error: {mse}")
print(f"R-squared: {r2}")

from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)
model = joblib.load('model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    # Preprocess data
    # Make prediction using the model
    prediction = model.predict([data])
    return jsonify({'prediction': prediction[0]})

if __name__ == '__main__':
    app.run(debug=True)