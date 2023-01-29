FROM node:14.20.0-buster as builder

WORKDIR /app

COPY services/core ./services/core
COPY services/validation ./services/validation
COPY services/verification ./services/verification
COPY src ./src
COPY *.json ./
RUN npm install
COPY . .
RUN npm run server:build

FROM node:16-alpine
WORKDIR /app
COPY package* ./
RUN npm install --production
COPY --from=builder ./app/public ./public
COPY --from=builder ./app/dist ./dist
EXPOSE 8000
ENTRYPOINT ["npm", "server:start"]
