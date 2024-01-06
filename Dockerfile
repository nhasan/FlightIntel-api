FROM node:18-alpine

ARG PM2_PUBLIC_KEY
ARG PM2_SECRET_KEY

RUN mkdir -p /app/node_modules && chown -R node:node /app

WORKDIR /app

COPY package*.json ./

RUN npm install pm2 --location=global
ENV PM2_PUBLIC_KEY $PM2_PUBLIC_KEY
ENV PM2_SECRET_KEY $PM2_SECRET_KEY

USER node

RUN npm ci --only=production --omit=dev

COPY --chown=node:node ./ ./

EXPOSE 8000

CMD ["pm2-runtime", "app.js"]

