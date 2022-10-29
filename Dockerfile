
# Install Operating system and dependencies
FROM python:3.9


# Copy files to container and build
RUN mkdir /app/
COPY ./build/web/ /app/
COPY ./server/ /app/
WORKDIR /app/

# Record the exposed port
EXPOSE 8000

# make server startup script executable and start the web server
RUN ["chmod", "+x", "/app/server.sh"]

ENTRYPOINT [ "/app/server.sh"]