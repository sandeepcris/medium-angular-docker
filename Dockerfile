# Step 1: Build the app in image 'builder'
FROM node:18.10.0-alpine AS builder

WORKDIR /usr/src/app
COPY . .
RUN yarn && yarn build

# Step 2: Use build output from 'builder'
FROM nginxinc/nginx-unprivileged 
LABEL version="1.0"

COPY nginx.conf /etc/nginx/nginx.conf


WORKDIR /usr/share/nginx/html
COPY --from=builder /usr/src/app/dist/my-angular-app/ .
