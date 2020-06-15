FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# get rid of all the stuff in the previous step, copy the stuff that matters into the right spot for nginx
FROM nginx

# you have to put this in so that elastic beanstalk knows what port to expose (i think - it seems to work without this)
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
