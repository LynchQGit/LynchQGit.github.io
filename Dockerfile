FROM docker.io/squidfunk/mkdocs-material:9.4.7

WORKDIR /app

# docs
COPY . /app/docs/LynchQGit.github.io

RUN \
    rm -rf /app/docs/LynchQGit.github.io/.assets \
    && rm -rf /app/docs/LynchQGit.github.io/README.md

# index
COPY .assets /app/docs/.assets
COPY README.md /app/docs/index.md

# config
COPY mkdocs.yml /app
