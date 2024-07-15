# compile application
FROM node:22.4.1-alpine@sha256:ba898e86c2cc720c8cf2ae05f8d2d4697fe0c8ca3e920d6fbf14a6cbf50bb9ca AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:22.4.1-alpine@sha256:ba898e86c2cc720c8cf2ae05f8d2d4697fe0c8ca3e920d6fbf14a6cbf50bb9ca AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
