latest: 
	docker build -t zeyanlin/rstudio .

## Example with build-arg
#	docker build --build-arg RSTUDIO_VERSION=1.0.44 -t zeyanlin/rstudio .

sync: 
	make devel/Dockerfile 3.4.0/Dockerfile

## DO NOT SYNC versions older than 3.4.0, they are frozen to jessie

## FIXME consider locking RSTUDIO_VERSION and/or PANDOC_VERSION based on release date as well


update:
	cp Dockerfile ${R_VERSION}/Dockerfile
	cp userconf.sh ${R_VERSION}/userconf.sh
	cp add_shiny.sh ${R_VERSION}/add_shiny.sh
	sed -i 's/r-ver:latest/r-ver:${R_VERSION}/' ${R_VERSION}/Dockerfile


build:
	docker build -t zeyanlin/rstudio:${R_VERSION} ${R_VERSION}


.PHONY:
	echo "Syncing rstudio images...\n"

clean:
rm 3.*/Dockerfile
