<p align="center">
  <a href="https://glitch.com/edit/#!/pool-sandy-lifeboat">
    <img src="https://img.shields.io/badge/Glitch-View%20Project-brightgreen" alt="Glitch Project">
  </a>
</p>

# Node.js Express Server with JWT Authentication and Salesforce Integration

This Node.js Express server handles authentication with JWT (JSON Web Tokens) and integrates with Salesforce for data forwarding. It provides endpoints for generating JWT tokens, verifying tokens, and forwarding requests to Salesforce.

## Endpoints

### POST `/generateToken`

- Generates a JWT token for authentication.
- Expects a JSON payload with `username` and `password`.
- Returns a JWT token if authentication is successful.

### POST `/forward`

- Forwards requests to Salesforce API.
- Requires authentication with a JWT token in the request headers.
- Forwards the request body to the Salesforce API endpoint using the obtained access token.
- Returns the response from Salesforce.

## Middleware

### `verifyToken`

- Middleware function to verify JWT tokens.
- Extracts the token from the request headers and verifies it using the JWT secret key (`JWT_SECRET`).
- If the token is valid, decodes the user information and attaches it to the request object for future use.

## External Dependencies

- `express`: Web framework for Node.js.
- `body-parser`: Middleware for parsing request bodies.
- `jsonwebtoken`: Library for generating and verifying JWT tokens.
- `axios`: Promise-based HTTP client for making requests to Salesforce API.
- `morgan`: HTTP request logger middleware for Node.js.

## Setup and Configuration

Before running the server, ensure that you have the following:

- Node.js and npm installed on your system.
- Salesforce authentication credentials set as environment variables (`clientId`, `clientSecret`, `username`, `password`, `securityToken`).
- Salesforce API endpoint set as an environment variable (`salesforceApiEndpoint`).
- JWT secret key (`JWT_SECRET`) for token generation.

To install dependencies and run the server:

```bash
npm install
npm start
```
