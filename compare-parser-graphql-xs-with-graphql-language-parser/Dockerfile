FROM perl:5.38.2-bullseye

RUN apt-get update \
    && apt-get install -y wget gcc g++ cmake make python2\
    && rm -rf /var/lib/apt/lists/*

# Parser::GraphQL::XS requires libgraphqlparser
RUN wget "https://github.com/graphql/libgraphqlparser/archive/refs/tags/v0.7.0.tar.gz" \
    && tar -xzvf v0.7.0.tar.gz \
    && cd libgraphqlparser-0.7.0 \
    && cmake . && make && make install

WORKDIR /usr/src/app/

COPY cpanfile .
RUN cpm install --show-build-log-on-failure

COPY . .
ENV PERL5LIB=/usr/src/app/local/lib/perl5
ENV PATH=/usr/src/app/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["bash"]
