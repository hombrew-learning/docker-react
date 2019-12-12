# Build Phase
FROM node:alpine as builder

RUN mkdir -p /package
WORKDIR '/app'

COPY package.json /package/package.json
RUN npm install --prefix /package

COPY . .

RUN npm run build

# Run Phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
