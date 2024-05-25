import './App.css';
import ReactDOM from 'react-dom';
import { useState, React } from "react";

function App() {
  const [inputs, setInputs] = useState({});

  const handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setInputs(values => ({...values, [name]: value}))
  }

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log(inputs);
  }

  return (
    <div className='center-form'>
      <form onSubmit={handleSubmit}>
        <label>
          Enter your annual income:
          <input 
            type="number" 
            name="annualincome" 
            value={inputs.annualincome || ""} 
            onChange={handleChange}
            placeholder="Annual Income"
          />
        </label>
        <label>
          Enter your monthly expense:
          <input 
            type="number" 
            name="expense" 
            value={inputs.expense || ""} 
            onChange={handleChange}
            placeholder="Monthly Expense"
          />
        </label>
        <label>
          Enter your job type:
          <input 
            type="text" 
            name="job" 
            value={inputs.job || ""} 
            onChange={handleChange}
            placeholder="Job Type"
          />
        </label>
        <label>
          Enter your dependencies:
          <input 
            type="number" 
            name="dependencies" 
            value={inputs.dependencies || ""} 
            onChange={handleChange}
            placeholder="Dependencies"
          />
        </label>
        <input type="submit" value="Submit" />
      </form>
    </div>
  );
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);

export default App;
