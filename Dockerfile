# ---- Builder Stage (Stage 1) ----
# This stage is used to build the application and install all dependencies.
# We use a specific version to ensure consistent builds.
FROM node:24-alpine AS builder

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install all dependencies, including devDependencies needed for building
RUN npm install

# Copy the rest of the application source code
COPY . .


# ---- Final Stage (Stage 2) ----
# This stage creates the lean, production-ready image.
FROM node:24-alpine AS final

LABEL author="Maxat Akbanov"

# Set the environment to production
# This can improve performance for some Node.js applications
ENV NODE_ENV=production

# Create a non-root user and group for better security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory for the new user
WORKDIR /home/appuser

# Copy dependencies from the builder stage
# We also change ownership to the new non-root user
COPY --from=builder --chown=appuser:appgroup /usr/src/app/node_modules ./node_modules
COPY --from=builder --chown=appuser:appgroup /usr/src/app/package.json ./package.json

# Copy only the necessary application files from the builder stage
COPY --from=builder --chown=appuser:appgroup /usr/src/app/app.js ./app.js

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 3000

# The command to run the application
CMD [ "node", "app.js" ]
