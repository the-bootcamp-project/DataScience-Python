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
        python3 python3-pip \
        zip wget curl git git-flow sudo util-linux

RUN apt autoremove -y

RUN adduser --disabled-password --gecos '' bootcamp && \
    adduser bootcamp sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chown -R bootcamp /home/bootcamp

USER bootcamp

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:/usr/local/bin/python3:/usr/local/bin/pip3:$PATH

WORKDIR /home/bootcamp

RUN python3 -m pip install --upgrade --user pip && \
    python3 -m pip install --upgrade --user \
        requests \
        kaggle \
        fasttext \
        # Development Dependencies
        mypy pylint pytest bandit

# RUN python3 -m pip install --upgrade --user pandas \
#         # Recommended dependencies
#         numexpr bottleneck \
#         # Visualization
#         matplotlib Jinja2 tabulate \
#         # Computation
#         SciPy numba xarray \
#         # Excel files
#         xlrd xlwt xlsxwriter openpyxl pyxlsb \
#         # HTML / XML
#         BeautifulSoup4 html5lib lxml \
#         # SQL databases
#         SQLAlchemy pymysql \
#         # Other data sources
#         tables blosc fastparquet pyarrow pyreadstat
#         # Access data in the cloud
#         # fsspec gcsfs pandas-gbq s3fs

RUN mkdir -p /tmp/semver/ && \
    git clone https://github.com/fsaintjacques/semver-tool.git /tmp/semver/ && \
    cp /tmp/semver/semver /usr/local/bin/ && \
    chmod +x bootcamp:bootcamp /usr/local/bin/semver

RUN mkdir -p /home/bootcamp/.kaggle

# Uncommand if run Docker with kaggle.json file
# COPY kaggle.json /home/bootcamp/.kaggle

ENV KAGGLE_USERNAME=${KAGGLE_USERNAME}
ENV KAGGLE_KEY=${KAGGLE_KEY}
ENV KAGGLE_PROXY=${KAGGLE_PROXY}
