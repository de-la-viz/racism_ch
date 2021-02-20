# SOURCES:
# - https://u.group/thinking/how-to-put-jupyter-notebooks-in-a-dockerfile/
# - https://www.codementor.io/@aviaryan/writing-your-first-dockerfile-7e0rjhuals

# Linux base, but using a slimmer environment
# FROM ubuntu:latest
FROM python:3.7.0-slim
RUN apt-get update && apt-get -y update
# RUN apt-get install -y build-essential python3.7 python3-pip python3-dev
# RUN pip3 -q install pip --upgrade

# create an src working directory and copy the entire directory over to it —data, code, and all.
# Once it is started, the container will have an exact copy of what we have locally
RUN mkdir src
WORKDIR src/
COPY . .

# install the libraries required for the project in the container
RUN pip3 install -r requirements.txt
RUN pip3 install jupyter

# start the notebook (not sure if this is working or useful?)
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]


# to build the Docker container: docker build -t delavyz/scrap-antiracism .
# to launch the Docker image: run -p 8888:8888 delavyz/scrap-antiracism
