const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// serve static frontend
app.use(express.static(path.join(__dirname, 'public')));

app.get('/health', (req, res) => res.json({ status: 'UP' }));

// SPA fallback - catch-all handler (avoid path-to-regexp issues)
app.use((req, res) => {
	res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
