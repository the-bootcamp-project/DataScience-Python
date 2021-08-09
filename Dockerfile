FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

ARG KAGGLE_USERNAME
ARG KAGGLE_KEY
ARG KAGGLE_PROXY

RUN apt update && \
    apt install -y --no-install-recommends apt-utils && \
    apt upgrade -y && apt install -y \
        build-essential gcc make cmake \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        python3 python3-pip python3-psycopg2 \
        zip wget curl llvm git sudo

RUN apt autoremove -y

RUN adduser --disabled-password --gecos '' bootcamp && \
    adduser bootcamp sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chown -R bootcamp /home/bootcamp

USER bootcamp

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:/usr/local/bin/python3:/usr/local/bin/pip3:$PATH

WORKDIR /home/bootcamp

RUN python3 -m pip install --upgrade --user \
        pip \
        requests \
        kaggle \
        fasttext \
        pandas \
        # Development Dependencies
        pytest pylint \
        # Recommended dependencies
        numexpr bottleneck h5py \
        # Visualization
        matplotlib Jinja2 tabulate \
        # Computation
        SciPy numba xarray \
        # Excel files
        xlrd xlwt xlsxwriter openpyxl pyxlsb \
        # HTML / XML
        BeautifulSoup4 html5lib lxml \
        # SQL databases
        SQLAlchemy pymysql \
        # Other data sources
        tables blosc fastparquet pyarrow pyreadstat \
        # Access data in the cloud
        fsspec gcsfs pandas-gbq s3fs
        # Clipboard
        # PyQt5 qtpy xclip xsel

RUN mkdir -p /home/bootcamp/.kaggle

# Uncommand if run Docker with kaggle.json file
# COPY kaggle.json /home/bootcamp/.kaggle

ENV KAGGLE_USERNAME=${KAGGLE_USERNAME}
ENV KAGGLE_KEY=${KAGGLE_KEY}
ENV KAGGLE_PROXY=${KAGGLE_PROXY}
