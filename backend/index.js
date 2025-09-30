const app = require('./app');
const connectDB = require('./config/db');

const port = 3000;

// connect db first
connectDB();

// start server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});