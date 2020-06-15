FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# get rid of all the stuff in the previous step, copy the stuff that matters into the right spot for nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
