# Use Node.js LTS as base image
FROM node:18

# Set the working directory
WORKDIR /

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the entire frontend codebase
COPY . .

# Build the frontend
RUN npm run build

# Serve the static files using a lightweight server
RUN npm install -g serve
CMD ["serve", "-s", "dist"]

# Expose the port used for serving the frontend
EXPOSE 3000
