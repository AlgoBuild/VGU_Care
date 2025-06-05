const express = require('express');
const router = express.Router();

// This is a test route to confirm it's working
router.get('/', (req, res) => {
  res.json({ message: 'Appointments route is working!' });
});

module.exports = router;
