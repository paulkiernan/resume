FROM debian:stretch-slim
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install \
        --yes \
        --no-install-recommends \
            make \
            git \
            ca-certificates \
            lmodern \
            texlive-latex-base \
            # texlive-generic-extra \
            # texlive-fonts-extra \
            texlive-fonts-recommended \
            texlive-generic-recommended \
            texlive-lang-english \
            latex-xcolor \
            texlive-math-extra \
            texlive-latex-extra \
            texlive-bibtex-extra \
            biber \
            fontconfig \
            texlive-xetex

RUN apt-get autoclean && \
    apt-get --purge --yes autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /root/texmf/tex/latex/local/
COPY fonts/resume-openfont.cls /root/texmf/tex/latex/local/

WORKDIR /src
VOLUME ["/src"]
