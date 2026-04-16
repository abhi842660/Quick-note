FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

# Copy only inner project folder
COPY quick-notes/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
