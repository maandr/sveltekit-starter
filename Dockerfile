# compile application
FROM node:22.0.0-alpine@sha256:9459e243f620fff19380c51497493e91db1454f5a30847efe5bc5e50920748d5 AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:22.0.0-alpine@sha256:9459e243f620fff19380c51497493e91db1454f5a30847efe5bc5e50920748d5 AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
