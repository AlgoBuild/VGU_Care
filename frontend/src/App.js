import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Login from "./pages/Login";


function App() {
  return (

    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/dashboard" element={<h2>Student Dashboard</h2>} />
        <Route path="/nurse" element={<h2>Nurse Dashboard</h2>} />
        <Route path="/admin" element={<h2>Admin Dashboard</h2>} />
      </Routes>
    </Router>
  );
}

export default App;
