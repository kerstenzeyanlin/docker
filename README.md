![](https://img.shields.io/badge/Rstudio-Server-blue.svg?style=plastic)
[![](https://img.shields.io/travis/linzeyan/rstudio.svg?style=plastic)](https://travis-ci.org/linzeyan/rstudio)
![](https://img.shields.io/docker/build/zeyanlin/rstudio.svg?style=plastic)


build | [![](https://img.shields.io/docker/automated/zeyanlin/rstudio.svg?style=plastic)](https://hub.docker.com/r/zeyanlin/rstudio/) 
-------------- | ------------
pulls |  ![](https://img.shields.io/docker/pulls/zeyanlin/rstudio.svg?style=plastic) 
size |  [![](https://images.microbadger.com/badges/image/zeyanlin/rstudio.svg)](https://microbadger.com/images/zeyanlin/rstudio) 
tag |  ![](https://images.microbadger.com/badges/version/zeyanlin/rstudio.svg) 
license |  ![](https://images.microbadger.com/badges/license/zeyanlin/rstudio.svg)

# Install Docker & pull rstudio image

    curl -sSL https://linzeyan.github.io/linzeyan.github.io/install_docker.sh | sudo sh
    
# Run rstudio

> Visit localhost:8787 in your browser and log in with username:password as rstudio:rstudio or customize.

    docker run -d -p 8787:8787 -e USER=username -e PASSWORD=password zeyanlin/rstudio:latest

# Source

* [Docker commands tutorial](https://github.com/linzeyan/rstudio/blob/master/01.docker_tutorial.md#常用的-docker-命令)
* [Docker commands diagram](https://linzeyan.github.io/rstudio/Docker commands diagram.png)
* Book about Docker
  * [《Docker —— 從入門到實踐》正體中文版](https://www.gitbook.com/book/philipzheng/docker_practice/details)
  - [最完整的Docker聖經 - Docker原理圖解及全環境安裝](https://www.gitbook.com/book/joshhu/docker_theory_install/details)
  - [Docker學習筆記](https://www.gitbook.com/book/peihsinsu/docker-note-book/details)
