FROM node:22-alpine AS base

FROM base AS builder

RUN apk update && apk add --no-cache libc6-compat

WORKDIR /app

COPY . .

RUN npm install -g turbo

RUN corepack enable pnpm && \
    pnpm config set registry https://registry.npmjs.org && \
    turbo prune web --docker

FROM base AS installer

RUN apk update && apk add --no-cache libc6-compat

WORKDIR /app

COPY --from=builder /app/out/json/ .

RUN corepack enable pnpm && \
    pnpm config set registry https://registry.npmjs.org && \
    pnpm install --frozen-lockfile

COPY --from=builder /app/out/full/ .

RUN corepack enable pnpm && pnpm run build --filter=web

FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

COPY --from=installer /app/apps/web/public ./public
COPY --from=installer --chown=nextjs:nodejs /app/apps/web/.next/standalone ./
COPY --from=installer --chown=nextjs:nodejs /app/apps/web/.next/static ./.next/static

USER nextjs

ENV TZ=Asia/Shanghai
EXPOSE 3000

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "apps/web/server.js"]
