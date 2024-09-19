// Import the Express module
const express = require('express');

// Create an instance of Express
const app = express();

// Define a route that sends 'Hello World' as a response
app.get('/', (req, res) => {
  res.send('Hello World');
});

// Start the server on port 3000
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
