const express = require("express");
const client = require("prom-client"); // Added: Prometheus library

const app = express();
const PORT = process.env.PORT || 3000;

// Added: Tell Prometheus to collect default server metrics (CPU, RAM, etc.)
client.collectDefaultMetrics();

app.get("/", (req, res) => res.send("Hello DevOps! Version 3.0"));
app.get("/health", (req, res) => res.status(200).send("OK")); // For step 8 & 10

// Added: The secret endpoint where Prometheus will scrape the data
app.get("/metrics", async (req, res) => {
  res.set("Content-Type", client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(PORT, () => console.log(`App running on port ${PORT}`));
