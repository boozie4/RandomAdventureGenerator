const express = require('express');
const cors = require('cors');
const pool = require('./db');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// Health
app.get('/health', (req, res) => res.json({ status: 'ok' }));

// Get all adventures (optionally filter by category)
app.get('/api/adventures', async (req, res) => {
  const { category } = req.query;
  try {
    if (category) {
      const [rows] = await pool.query('SELECT id, text, categories FROM adventures WHERE JSON_CONTAINS(categories, JSON_ARRAY(?))', [category]);
      return res.json(rows.map(r => ({ id: r.id, text: r.text, categories: JSON.parse(r.categories) })));
    }
    const [rows] = await pool.query('SELECT id, text, categories FROM adventures');
    return res.json(rows.map(r => ({ id: r.id, text: r.text, categories: JSON.parse(r.categories) })));
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB error' });
  }
});

// Simple add adventure endpoint (for future use)
app.post('/api/adventures', async (req, res) => {
  const { text, categories } = req.body;
  if (!text) return res.status(400).json({ error: 'Missing text' });
  try {
    const [result] = await pool.query('INSERT INTO adventures (text, categories) VALUES (?, ?)', [text, JSON.stringify(categories || [])]);
    res.json({ id: result.insertId, text, categories: categories || [] });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB error' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server listening on ${PORT}`));
