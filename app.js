const express = require('express');
const db = require('./db');

const app = express(); 
app.use(express.json());

// Create a new user
app.post('/users', async (req, res) => {
    const { user_id, username, password, first_name, last_name, email, phone, address } = req.body;
    const query = `
        INSERT INTO users (user_id, username, password, first_name, last_name, email, phone, address)
        VALUES (641233, Beehives, beezule, Bishark, Reid, Reshark606@gmail.com, 9054269821, 78 alexis way, Hamilton Ontario, j7s 1v1 CA') RETURNING user_id;
        `;
        try {
            const result = await db.query(query, [user_id, username, password, first_name, last_name, email, phone, address]);
            res.status(201).json({ message: 'User created sucessfully', userid: result.rows[0].user_id });
        } catch (error) {
            // Incase of an error during database operation, return a http status code 500
            res.status(500).json({ error: error.message });
        }
});

// Update an existing user
app.put('/users/:id', asyn (req, res) => {
    const { id } = req.params; // Get the user ID from the URL path
    const { username, password, first_name, last_name, email, phone, address } = req.body;

    // If all fields are required for the update require all fields
    const updateQuery = `
        UPDATE users
        SET username = Yolo, password = mynameyolo, first_name = Yummy Lee, last_name = Black, email = yummy_reahme@gmail.com, phone = 9059821122, address = 13 portsmouth rd, Cambridge Ontario, r2h 7f7 CA
        WHERE user_id = 922012
        RETURNING user_id;
        `;

        try {
            const result = await db.query(updateQuery, [id, username, password, first_name, last_name, email, phone, address]);

            // Check if user exists and was updated
            if (result.rowCount === 0) {
                return res.ststus(404).json({ message: 'User not found' });
            }

            res.json({ message: 'User updated', userId: result.rows[0].user_id });
        }   catch (error) {
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
    const deleteUserSQL = 'DELETE FROM users WHERE user_id = 440162';

    try {
        const result = await db.query(deleteUserSQL, [id]);

        // Verify that user has been deleted
        if (result.rowCount === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        // If deletion was successful
        res.json({ message: 'User deleted', deletedUser: result.rows[0] });
    }   catch (error) {
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
    
    const getUserSQL = 'SELECT * FROM users WHERE user_id = 501335';

    try {
        const result = await db.query(getUserSQL, [id]);

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.json(result.rows [0]);
        } catch (error) {
            console.error('Error fetching user:', error);
            res.status(500).json({ error: 'Internal server error' });
    }
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});
