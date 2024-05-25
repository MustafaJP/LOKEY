import pandas as pd
import joblib


# Load the saved model
loaded_model = joblib.load('random_forest_model.pkl')

#From GES Survey 2023
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

#function to predict emergency fund
def predict_emergency_fund(user_input):
    try:
         # Convert 'Job Stability' to integer using JobStabilityConverter
        user_input['Job Stability (1-10)'] = JobStabilityConverter(user_input['Your Job'])

        # Convert other input fields to integer
        user_input['Income ($)'] = int(user_input['Your Income'])
        user_input['Monthly Expenses ($)'] = int(user_input['Your monthly expenses'])
        user_input['Dependents'] = int(user_input['Number of your dependents'])
        user_input['Lifestyle Cost (1-10)'] = int(user_input['How much do you wish to spend'])

        # Remove extra keys
        user_input.pop('Your Income')
        user_input.pop('Your monthly expenses')
        user_input.pop('Number of your dependents')
        user_input.pop('Your Job')
        user_input.pop('How much do you wish to spend')

        # Convert user input to DataFrame
        user_df = pd.DataFrame([user_input])

        # Make prediction
        predicted_emergency_fund = loaded_model.predict(user_df)

        # Prepare the result
        result = {
            'Predicted Recommended Emergency Fund': float(predicted_emergency_fund[0])
        }

        return result, 200
    except Exception as e:
        return {'error': str(e)}, 400


# user_input = {
#     'Income ($)': int(input("Your Income: \n")),
#     'Monthly Expenses ($)': int(input("Your monthly expenses: \n")),
#     'Dependents': int(input('Number of your dependents: \n')),
#     'Job Stability (1-10)': int(JobStabilityConverter(input('Your Job: '))),
#     'Lifestyle Cost (1-10)': int(input("How much do you wish to spend: \n"))
# }

# # Converting
# user_df = pd.DataFrame([user_input])

# # Make a prediction
# predicted_emergency_fund = loaded_model.predict(user_df)

# # Prepare the result in a dictionary
# result = {
#     'Predicted Recommended Emergency Fund': float(predicted_emergency_fund[0])
# }

# # Convert the result to a JSON file
# with open('predicted_emergency_fund.json', 'w') as json_file:
#     json.dump(result, json_file)


# print(f"Predicted Recommended Emergency Fund: ${predicted_emergency_fund[0]:,.2f}")