const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    const podName = process.env.K8S_POD_NAME || 'Unknown';
    res.json({ podName: podName });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});