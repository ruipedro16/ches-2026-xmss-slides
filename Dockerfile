FROM debian:trixie-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG NIXPKGS_URL=https://nixos.org/channels/nixos-25.05

RUN apt-get --quiet --assume-yes update \
    && apt-get --quiet --assume-yes --no-install-recommends install \
        ca-certificates \
        make \
        nix-bin \
        rubber \
        texlive-fonts-recommended \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-pictures \
        lmodern \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Use Nix directly without a daemon or privileged container. Cache the
# formatter so the Makefile also works when the container has no network.
ENV NIX_REMOTE=local
RUN mkdir -p /etc/nix \
    && printf 'sandbox = false\nbuild-users-group =\n' > /etc/nix/nix.conf \
    && nix-channel --add "$NIXPKGS_URL" nixpkgs \
    && nix-channel --update \
    && nix-shell -p tex-fmt --run 'tex-fmt --version' 

WORKDIR /work
COPY . .

CMD ["make"]
