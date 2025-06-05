
# backend/Dockerfile
FROM node:18-alpine
WORKDIR /app

# STEP 1: Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# STEP 2: Copy app source code
COPY . .

# STEP 3: Start server using nodemon
CMD ["npm", "run", "dev"]

