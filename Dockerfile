FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install \
        --yes \
        --no-install-recommends \
            curl \
            git \
            ca-certificates \
            lmodern \
            texlive-latex-base \
            texlive-fonts-recommended \
            texlive-latex-recommended \
            texlive-lang-english \
            texlive-latex-extra \
            texlive-bibtex-extra \
            texlive-pictures \
            biber \
            fontconfig \
            texlive-xetex

RUN apt-get autoclean && \
    apt-get --purge --yes autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# go-task runs the build (see Taskfile.yaml `compile`); the .cls files
# resolve from the mounted repo via TEXINPUTS, so nothing is baked into a
# texmf tree. Pinned version, matching .tool-versions on the host.
ARG TASK_VERSION=v3.38.0
RUN curl -sSL \
        "https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_$(dpkg --print-architecture).tar.gz" \
    | tar -xz -C /usr/local/bin task

WORKDIR /src
VOLUME ["/src"]
