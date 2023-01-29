FROM node:14.20.0-buster as builder

WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run server:build

FROM node:16-alpine
WORKDIR /app
COPY package* ./
RUN npm install --production
COPY --from=builder ./app/public ./public
COPY --from=builder ./app/build ./build
EXPOSE 8000
ENTRYPOINT ["npm", "server:start"]
