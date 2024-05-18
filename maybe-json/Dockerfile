FROM perl:5.38.2

RUN cpm install -g Carton

WORKDIR /app

COPY cpanfile cpanfile.snapshot ./

CMD ["/bin/bash"]
