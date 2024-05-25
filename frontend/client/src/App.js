// 6mths of monthly expense
// option of annual income
// new input box with current money in emergency fund
import './App.css';
import { useState, React } from "react";
import logo from './logo.png'; // Ensure your logo image is in the src folder

function App() {
  const [inputs, setInputs] = useState({});
  const [numMonths, setNumMonths] = useState(0);
  const [emergencyFund, setEmergencyFund] = useState(null);

  const handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setInputs(values => ({ ...values, [name]: value }));
  };

  const handleMonthChange = (event) => {
    setNumMonths(Number(event.target.value));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    const totalExpenses = Array.from({ length: numMonths }).reduce((sum, _, index) => {
      return sum + Number(inputs[`month${index + 1}`] || 0);
    }, 0);
    const annualIncome = Number(inputs.annualincome || 0);
    const averageMonthlyExpense = totalExpenses / numMonths;
    const neededFund = averageMonthlyExpense * 6; // Assuming 6 months of expenses as emergency fund
    setEmergencyFund({
      neededFund,
      currentFund: Number(inputs.currentFund || 0)
    });
  };

  const getZone = (neededFund, currentFund) => {
    if (currentFund < neededFund * 0.5) return 'Too Little';
    if (currentFund < neededFund * 0.8) return 'Bit Low';
    if (currentFund < neededFund * 1.2) return 'Perfect';
    if (currentFund < neededFund * 1.5) return 'Bit High';
    return 'Too High';
  };

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h1>Lokey Emergency Fund Predictor</h1>
      </header>
      <main>
        <div className="form-container">
          <form onSubmit={handleSubmit}>
            <div className="form-group">
              <label>Enter your annual income:</label>
              <input
                type="number"
                name="annualincome"
                value={inputs.annualincome || ""}
                onChange={handleChange}
                placeholder="Annual Income"
              />
            </div>
            <div className="form-group">
              <label>Select number of months (1-12):</label>
              <select value={numMonths} onChange={handleMonthChange}>
                <option value="0">Select Months</option>
                {[...Array(12).keys()].map(month => (
                  <option key={month + 1} value={month + 1}>{month + 1}</option>
                ))}
              </select>
            </div>
            {Array.from({ length: numMonths }, (_, index) => (
              <div className="form-group" key={index}>
                <label>Month {index + 1} Expense:</label>
                <input
                  type="number"
                  name={`month${index + 1}`}
                  value={inputs[`month${index + 1}`] || ""}
                  onChange={handleChange}
                  placeholder={`Month ${index + 1} Expense`}
                />
              </div>
            ))}
            <div className="form-group">
              <label>Enter your current emergency fund:</label>
              <input
                type="number"
                name="currentFund"
                value={inputs.currentFund || ""}
                onChange={handleChange}
                placeholder="Current Fund"
              />
            </div>
            <div className="form-group">
              <label>Enter your job type:</label>
              <input
                type="text"
                name="job"
                value={inputs.job || ""}
                onChange={handleChange}
                placeholder="Job Type"
              />
            </div>
            <div className="form-group">
              <label>Enter your dependencies:</label>
              <input
                type="number"
                name="dependencies"
                value={inputs.dependencies || ""}
                onChange={handleChange}
                placeholder="Dependencies"
              />
            </div>
            <div className="form-group">
              <input type="submit" value="Submit" />
            </div>
          </form>
        </div>
        {emergencyFund && (
          <div className="result-container">
            <h2>Your Emergency Fund Status</h2>
            <div className={`fund-zone ${getZone(emergencyFund.neededFund, emergencyFund.currentFund)}`}>
              <p>You have</p>
              <p className="fund-amount">${emergencyFund.currentFund.toLocaleString()}</p>
              <p>in Emergency Fund</p>
            </div>
            <div className="fund-meter">
              <div className="zone" style={{ backgroundColor: '#ff6b6b', width: '20%' }}>Too Little</div>
              <div className="zone" style={{ backgroundColor: '#ffaf60', width: '20%' }}>Bit Low</div>
              <div className="zone" style={{ backgroundColor: '#4caf50', width: '20%' }}>Perfect</div>
              <div className="zone" style={{ backgroundColor: '#80cbc4', width: '20%' }}>Bit High</div>
              <div className="zone" style={{ backgroundColor: '#26a69a', width: '20%' }}>Too High</div>
              <div className="indicator" style={{ left: `${(emergencyFund.currentFund / emergencyFund.neededFund) * 100}%` }}></div>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}

export default App;
