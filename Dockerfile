FROM rust:1.43-slim-buster AS builder

WORKDIR /src
COPY boringtun .
RUN cargo build --release \
    && strip ./target/release/boringtun

FROM ubuntu:focal

WORKDIR /app
COPY --from=builder /src/target/release/boringtun /app

ENV WG_LOG_LEVEL=info \
    WG_THREADS=4

RUN apt-get update -y && apt-get install -y --no-install-suggests wireguard iproute2 iptables tcpdump openresolv
CMD ["wg-quick", "up", "$1"]
