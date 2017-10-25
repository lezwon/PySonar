FROM openmined/pysyft:edge
RUN ["apk", "add", "--no-cache", "python3", "python3-dev", "musl-dev", "linux-headers", "g++", "gfortran", "gmp-dev", "mpfr-dev", "mpc1-dev", "make"]

RUN ["mkdir", "/pysonar"]
COPY requirements.txt /pysonar
RUN ["pip3", "install", "numpy"]
RUN ["pip3", "install", "scipy"]
RUN ["pip3", "install", "-r", "/pysonar/requirements.txt"]

#install capsule
RUN apk add --initdb --no-cache	git && \
git clone https://github.com/lezwon/Capsule.git && \
    cd Capsule/ && \
    git checkout dockerized && \
	pip3 install -r requirements.txt && \
	python3 setup.py install


# install pySonar lib
COPY . /pysonar
WORKDIR /pysonar
RUN ["python3", "setup.py", "install"]

# copy notebook code
RUN ["pip3", "install", "jupyter", "notebook"]
RUN ["mkdir", "/notebooks"]
COPY notebooks /notebooks
COPY jupyter_notebook_config.py /notebooks/

# import abi via NPM module
RUN apk add --update nodejs nodejs-npm git && \
    make import-abi && \
    cp -r /pysonar/abis /abis

EXPOSE 8888
CMD ["jupyter", "notebook", "--config=./jupyter_notebook_config.py", "--allow-root"]
