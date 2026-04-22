FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install \
        --yes \
        --no-install-recommends \
            make \
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

RUN mkdir -p /root/texmf/tex/latex/local/
COPY fonts/resume-openfont.cls /root/texmf/tex/latex/local/
COPY fonts/dnd-resume.cls /root/texmf/tex/latex/local/

WORKDIR /src
VOLUME ["/src"]
