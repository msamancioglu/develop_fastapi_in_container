# pull official base image
FROM python:3.9.6-slim-buster

# set working directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat gcc postgresql \
  && apt-get clean

# install python dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
COPY ./fastapi_limiter-0.1.5-py3-none-any.whl .
RUN pip install -r requirements.txt
RUN pip install fastapi_limiter-0.1.5-py3-none-any.whl

# add app
COPY . .

# RUN uvicorn main:app --reload

# add entrypoint.sh
# COPY ./entrypoint.sh .
# RUN chmod +x /usr/src/app/entrypoint.sh

# run entrypoint.sh
# ENTRYPOINT ["/usr/src/app/entrypoint.sh"]