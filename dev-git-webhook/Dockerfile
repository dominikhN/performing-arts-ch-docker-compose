FROM staticfloat/docker-webhook@sha256:b9e49f1473497df08993a1059b8356064aae6c5bcb735b0287161258ee8a59d0

RUN mkdir /code
COPY ./code /code

RUN chmod -R u+x /code
WORKDIR /app

CMD ["sh", "-c", "/code/init.sh && python webhook_listener.py"]
EXPOSE 8000
