 FROM nginx:1.10.1-alpine
 COPY /var/lib/jenkins/workspace/pipeline/index.html /usr/share/nginx/html/index.html
 EXPOSE 8080
 CMD ["nginx", "-g", "daemon off;"]