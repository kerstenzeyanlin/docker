FROM zeyanlin/rstudio:latest
## Work-around to make Docker Hub use the Dockerfile 
## from https://github.com/linzeyan/rstudio
MAINTAINER Lin ZeYan

RUN apt-get update

EXPOSE 8787

## automatically link a shared volume for kitematic users
VOLUME /home/rstudio/kitematic

CMD ["/init"]
