 FROM nginx:1.10.1-alpine
 COPY index.html /usr/share/nginx/html/index.html
 EXPOSE 8081
 CMD ["nginx", "-g", "daemon off;"]