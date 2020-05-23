FROM rust:1.43-slim-buster AS builder

WORKDIR /src
COPY boringtun .
RUN cargo build --release \
    && strip ./target/release/boringtun

FROM debian:buster-slim

WORKDIR /app
COPY --from=builder /src/target/release/boringtun /app

ENV WG_LOG_LEVEL=info \
    WG_THREADS=4

RUN apt-get update && apt-get install -y --no-install-suggests wireguard iproute2 iptables tcpdump
CMD ["wg-quick", "up", "$1"]
