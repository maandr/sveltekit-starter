# compile application
FROM node:22.4.0-alpine@sha256:1e847ddc61d073787aaca688e2a6568d77688b4eae561c806efeb39617caa53f AS builder

WORKDIR /app

RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build
RUN pnpm prune --prod

# bundle application
FROM node:22.4.0-alpine@sha256:1e847ddc61d073787aaca688e2a6568d77688b4eae561c806efeb39617caa53f AS bundle

WORKDIR /app

# copy compiled sources from builder layer
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY package.json .

EXPOSE 80

ENV NODE_ENV=production
ENV PORT 80

CMD [ "node", "build" ]
