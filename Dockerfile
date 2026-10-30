# ---- Этап 1: сборка приложения ----
FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY CMakeLists.txt .
COPY include ./include
COPY src ./src

RUN cmake -S . -B build -DBUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --target my_app --config Release

# ---- Этап 2: минимальный образ для запуска ----
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home appuser

WORKDIR /home/appuser
COPY --from=builder /app/build/my_app .
USER appuser

CMD ["./my_app"]

