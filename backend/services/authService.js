exports.createUser = async (email, password) => {
  if (!email.includes('@vgu.edu.vn')) throw new Error('Invalid VGU email');
  return { id: 'stub-user-id' };
};

exports.authenticate = async (email, password) => {
  if (email !== 'test@vgu.edu.vn' || password !== 'password') {
    throw new Error('Invalid credentials');
  }
  return 'stub-jwt-token';
};