
# Use the official nginx image as a base image
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY build/ .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

