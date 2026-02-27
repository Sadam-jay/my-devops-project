const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => res.send("Hello DevOps! Version 2.0"));
app.get("/health", (req, res) => res.status(200).send("OK")); // For step 8 & 10

app.listen(PORT, () => console.log(`App running on port ${PORT}`));
