FROM debian:stretch-slim as deployment

ARG MIX_ENV
ENV MIX_ENV ${MIX_ENV:-dev}
ENV DEBIAN_FRONTEND noninteractive
ARG PORT
ENV PORT ${PORT:-4000}

RUN apt-get -y update
RUN apt-get install -y locales libssl1.1 libssl-dev
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
RUN /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8

WORKDIR /app


FROM elixir:1.9.1 as builder

WORKDIR /app

ARG MIX_ENV
ENV MIX_ENV ${MIX_ENV:-dev}
ARG PORT
ENV PORT ${PORT:-4000}

ADD . .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix hex.info
RUN mix clean
RUN mix deps.get
RUN MIX_ENV=$MIX_ENV mix release --overwrite

FROM deployment
COPY --from=builder /app/_build/$MIX_ENV/rel/exkubed/ .
CMD ["./bin/exkubed", "start"]
