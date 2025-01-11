# Use Node.js LTS as base image
FROM node:18

# Set the working directory
WORKDIR /

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the entire backend codebase
COPY . .

# Expose the port used by the backend
EXPOSE 5001

# Start the application
CMD ["node", "index.js"]
