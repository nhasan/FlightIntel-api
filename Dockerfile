FROM node:18-alpine

RUN mkdir -p /app/node_modules && chown -R node:node /app

WORKDIR /app

COPY package*.json ./

USER node

RUN npm ci --only=production --omit=dev

COPY --chown=node:node ./ ./

EXPOSE 8000

CMD ["node", "app.js"]

