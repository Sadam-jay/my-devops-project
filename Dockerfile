# Use a lightweight Node image
FROM node:18-alpine
# Set the working directory
WORKDIR /app
# Copy package files and install dependencies
COPY package*.json ./
RUN npm install
# Copy the rest of the code
COPY . .
# Expose the port and run the app
EXPOSE 3000
CMD ["node", "server.js"]