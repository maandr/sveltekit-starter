# compile application
FROM node:23.1.0-alpine@sha256:1467ea23cce893347696b155b9e00e7f0ac7d21555eb6f27236f1328212e045e AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:23.1.0-alpine@sha256:1467ea23cce893347696b155b9e00e7f0ac7d21555eb6f27236f1328212e045e AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
