# compile application
FROM node:22.3.0-alpine@sha256:df46071ae175bc2c0468ae58e32f00ed6c9779eb70112cdf0d2ccf85035bc7ff AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:22.3.0-alpine@sha256:df46071ae175bc2c0468ae58e32f00ed6c9779eb70112cdf0d2ccf85035bc7ff AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
