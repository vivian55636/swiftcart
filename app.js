const express = require('express');
const db = require('./db'); // Ensure this path is correct

const app = express(); 
const port = 3000;
app.use(express.json()); // Use middleware to parse JSON

// Create a new user
app.post('/users', async (req, res) => {
    const { username, password, first_name, last_name, email, phone, address } = req.body;
    const query = `
        INSERT INTO users (username, password, first_name, last_name, email, phone, address)
        VALUES ($2, $3, $4, $5, $6, $7) RETURNING user_id;
        `;
    try {
        const result = await db.query(query, [username, password, first_name, last_name, email, phone, address]);
        res.status(201).json({ message: 'User created successfully', userid: result.rows[0].user_id });
    } catch (error) {
        // In case of an error during database operation, return a http status code 500
        res.status(500).json({ error: error.message });
    }
});

// Update an existing user
app.put('/users/:id', async (req, res) => {
    const { id } = req.params; // Get the user ID from the URL path
    const { username, password, first_name, last_name, email, phone, address } = req.body;

    // If all fields are required for the update require all fields
    const updateQuery = `
        UPDATE users
        SET username = $2, password = $3, first_name = $4, last_name = $5, email = $6, phone = $7, address = $8
        WHERE user_id = $1
        RETURNING user_id;
        `;

    try {
        const result = await db.query(updateQuery, [id, username, password, first_name, last_name, email, phone, address]);

        // Check if user exists and was updated
        if (result.rowCount === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.json({ message: 'User updated', userId: result.rows[0].user_id });
    } catch (error) {
        console.error('Error updating user:', error);
        res.status(500).json({ error: error.message });
    }
});

// Delete an existing user  
app.delete('/users/:id', async (req, res) => {
    const { id } = req.params;
    if (!Number.isInteger(parseInt(id))) {
        return res.status(400).json({ error: 'Invalid ID format' });
    }
    const deleteUserSQL = 'DELETE FROM users WHERE user_id = $1';

    try {
        const result = await db.query(deleteUserSQL, [id]);

        // Verify that user has been deleted
        if (result.rowCount === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        // If deletion was successful
        res.json({ message: 'User deleted' });
    } catch (error) {
        console.error('Error deleting user:', error);
        res.status(500).json({ error: 'Internal Server error' });
    }
});

// Get a user information
app.get('/users/:id', async (req, res) => {
    const { id } = req.params;

    // Input Validation: Ensure the ID is an integer 
    if (!Number.isInteger(parseInt(id))) {
        return res.status(400).json({ error: 'Invalid ID format' });
    }
    
    const getUserSQL = 'SELECT * FROM users WHERE user_id = $1';

    try {
        const result = await db.query(getUserSQL, [id]);

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error fetching user:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
