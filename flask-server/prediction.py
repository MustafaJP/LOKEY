import pandas as pd
import joblib


# Load the saved model
loaded_model = joblib.load('random_forest_model.pkl')

# From GES Survey 2023
# Function is to convert job type to a job stability number ranging from 1-10
def JobStabilityConverter(department):
    if department == "Arts":
        return 4
    elif department == "Social Science":
        return 6
    elif department == "Dental":
        return 10
    elif department == "Medicine":
        return 9
    elif department == "Law":
        return 9
    elif department == "Sciences":
        return 6
    elif department == "Business":
        return 6
    elif department == "Computing":
        return 8
    elif department == "Engineering":
        return 7
    elif department == "Music":
        return 1
    elif department == "Real estate":
        return 7
    else:
        return 5

# function to predict emergency fund from trained synthetic model
# function called by main function
def predict_emergency_fund(user_input):
    try:
        # Convert 'Job Stability' to integer using JobStabilityConverter
        user_input['Job Stability (1-10)'] = JobStabilityConverter(user_input['Your Job'])

        # Convert other input fields to integer
        user_input['Income ($)'] = int(user_input['Your Income'])
        user_input['Monthly Expenses ($)'] = int(user_input['Your monthly expenses'])
        user_input['Dependents'] = int(user_input['Number of your dependents'])
        user_input['Lifestyle Cost (1-10)'] = int(user_input['How much do you wish to spend'])

        # Prepare the user input for prediction in the correct order
        prepared_input = {
            'Income ($)': user_input['Income ($)'],
            'Monthly Expenses ($)': user_input['Monthly Expenses ($)'],
            'Dependents': user_input['Dependents'],
            'Job Stability (1-10)': user_input['Job Stability (1-10)'],
            'Lifestyle Cost (1-10)': user_input['Lifestyle Cost (1-10)']
        }

        # Convert user input to DataFrame
        user_df = pd.DataFrame([prepared_input])

        # Make prediction
        predicted_emergency_fund = loaded_model.predict(user_df)

        # Prepare the result
        result = {
            'Predicted Recommended Emergency Fund': float(predicted_emergency_fund[0])
        }

        return result, 200
    except Exception as e:
        return {'error': str(e)}, 400

