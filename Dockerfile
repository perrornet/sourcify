FROM node:14.20.0-buster as builder

WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npx lerna bootstrap && npx lerna run build

FROM node:16-alpine
WORKDIR /app
COPY --from=builder ./app/dist ./dist
EXPOSE 8000
ENTRYPOINT ["node", "/app/dist/server/server.js"]
