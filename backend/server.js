require('dotenv').config();
const express = require('express');
const app = express();

// Middleware
app.use(express.json());

// Basic health check route
app.get('/api/health', (req, res) => {
  res.json({ 
    message: 'VGU Care API is running!',
    database: process.env.DATABASE_URL ? 'Connected' : 'Not configured',
    timestamp: new Date().toISOString()
  });
});

// Routes (to be implemented)
// app.use('/api/auth', require('./routes/authRoutes'));
// app.use('/api/appointments', require('./routes/appointmentRoutes'));
// app.use('/api/users', require('./routes/userRoutes'));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`VGU Care Server running on port ${PORT}`);
});