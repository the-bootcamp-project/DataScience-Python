FROM tbcp/python:latest

ENV DEBIAN_FRONTEND noninteractive

ARG KAGGLE_USERNAME
ARG KAGGLE_KEY
ARG KAGGLE_PROXY

ENV KAGGLE_USERNAME=${KAGGLE_USERNAME}
ENV KAGGLE_KEY=${KAGGLE_KEY}
ENV KAGGLE_PROXY=${KAGGLE_PROXY}

USER bootcamp

RUN python3 -m pip install --upgrade --user \
    requests \
    kaggle \
    fasttext

RUN python3 -m pip install --upgrade --user pandas
#   # Recommended dependencies
#   numexpr bottleneck \
#   # Visualization
#   matplotlib Jinja2 tabulate \
#   # Computation
#   SciPy numba xarray \
#   # Excel files
#   xlrd xlwt xlsxwriter openpyxl pyxlsb \
#   # HTML / XML
#   BeautifulSoup4 html5lib lxml \
#   # SQL databases
#   SQLAlchemy pymysql \
#   # Other data sources
#   tables blosc fastparquet pyarrow pyreadstat
#   # Access data in the cloud
#   # fsspec gcsfs pandas-gbq s3fs

RUN mkdir -p /home/bootcamp/.kaggle

# Uncommand if run Docker with kaggle.json file
# COPY kaggle.json /home/bootcamp/.kaggle

# tbcp/datascience-python:latest
