![](https://img.shields.io/badge/Rstudio-Server-blue.svg?style=plastic)
[![](https://img.shields.io/travis/linzeyan/rstudio.svg?style=plastic)](https://travis-ci.org/linzeyan/rstudio)

build          | pulls        | size      | tag         |    license
-------------- | ------------ | --------- | ----------- | --------------
[![](https://img.shields.io/docker/automated/zeyanlin/rstudio.svg?style=plastic)](https://hub.docker.com/r/zeyanlin/rstudio/builds)   | [![](https://img.shields.io/docker/pulls/zeyanlin/rstudio.svg?style=plastic)](https://hub.docker.com/r/zeyanlin/rstudio/)  |[![](https://images.microbadger.com/badges/image/zeyanlin/rstudio.svg)](https://microbadger.com/images/zeyanlin/rstudio)| [![](https://images.microbadger.com/badges/version/zeyanlin/rstudio.svg)](https://microbadger.com/images/zeyanlin/rstudio) |  [![](https://images.microbadger.com/badges/license/zeyanlin/rstudio.svg)](https://microbadger.com/images/zeyanlin/rstudio)| 




# *[zeyanlin/rstudio](https://hub.docker.com/r/zeyanlin/rstudio/)*

Visit localhost:8787 in your browser and log in with username:password as rstudio:rstudio or customize.

    docker run -d -p 8787:8787 -e USER=username -e PASSWORD=password zeyanlin/rstudio
