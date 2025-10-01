const app = require('./app');
const connectDB = require('./config/db');

const port = 3000;

// connect db first
connectDB();

// start server
app.listen(port, '0.0.0.0',() => {
  console.log(`Server running on http://localhost:${port}`);
});