const authService = require('../services/authService');

exports.signup = async (req, res) => {
  try {
    const user = await authService.createUser(req.body.email, req.body.password);
    res.status(201).json({ message: 'User created', userId: user.id });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

exports.login = async (req, res) => {
  try {
    const token = await authService.authenticate(req.body.email, req.body.password);
    res.json({ message: 'Login successful', token });
  } catch (err) {
    res.status(401).json({ error: err.message });
  }
};
