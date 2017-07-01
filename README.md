[![](https://travis-ci.org/linzeyan/docker_Rstudio_server.svg?branch=master)](https://travis-ci.org/linzeyan/docker_Rstudio_server)
[![](https://img.shields.io/docker/pulls/zeyanlin/rstudio.svg)](https://hub.docker.com/r/zeyanlin/rstudio/)
[![](https://img.shields.io/docker/automated/zeyanlin/rstudio.svg)](https://hub.docker.com/r/zeyanlin/rstudio/builds)
# Book about Docker
```
01.:https://www.gitbook.com/book/philipzheng/docker_practice/details
02.:https://www.gitbook.com/book/joshhu/docker_theory_install/details
03.:https://www.gitbook.com/book/peihsinsu/docker-note-book/details
```

# Site about R server
```
01.:http://kanchengzxdfgcv.blogspot.tw/2017/02/
https://github.com/kancheng/rsloan-environment.git
```


# Base on [rocker/rstudio](https://hub.docker.com/r/rocker/rstudio/) and install some pakeages.

Visit localhost:8787 in your browser and log in with username:password as rstudio:rstudio.
(e.g：http://rstudio:rstudio@162.158.10.119:8787/)
#### Customize：
```docker run -d -p 8787:8787 -e USER=username -e PASSWORD=password zeyanlin/rstudio```
