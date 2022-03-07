########### BASE STAGE ###########
FROM python:3.8-alpine AS base

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# copy base requirements
COPY ./requirements.txt /app/

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

WORKDIR /app


########### PRODUCTION STAGE ###########
FROM base AS prod

# create a app user
RUN addgroup -S appuser && adduser -S appuser -G appuser

# copy project
COPY ./app/ /app/

# chown all the files to the app user
RUN chown -R appuser:appuser /app/

# change to the app user
USER appuser