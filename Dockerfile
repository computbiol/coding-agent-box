FROM nvidia/cuda:12.6.0-cudnn-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_MAJOR=20
ARG USERNAME=agent
ARG USER_UID=1000
ARG USER_GID=1000

ENV TZ=Asia/Shanghai \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    HOME=/home/${USERNAME} \
    PIXI_HOME=/opt/pixi \
    NPM_CONFIG_PREFIX=/usr/local \
    PATH=/home/${USERNAME}/.local/bin:/home/${USERNAME}/.npm/bin:/opt/pixi/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin

SHELL ["/bin/bash", "-o", "pipefail", "-lc"]

RUN printf 'Acquire::Retries "5";\nAcquire::http::Timeout "30";\nAcquire::https::Timeout "30";\n' > /etc/apt/apt.conf.d/80-retries \
  && apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg \
    lsb-release \
    software-properties-common \
    sudo \
    unzip \
    wget \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list \
  && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
  && apt-get update && apt-get install -y --no-install-recommends \
    gh \
    nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p "${PIXI_HOME}" \
  && curl -fsSL https://pixi.sh/install.sh | env HOME=/root PIXI_HOME=${PIXI_HOME} bash \
  && ln -sf "${PIXI_HOME}/bin/pixi" /usr/local/bin/pixi

RUN groupadd --gid ${USER_GID} ${USERNAME} \
  && useradd --uid ${USER_UID} --gid ${USER_GID} --create-home --shell /bin/bash ${USERNAME} \
  && usermod -aG sudo ${USERNAME} \
  && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
  && chmod 0440 /etc/sudoers.d/${USERNAME} \
  && mkdir -p /home/${USERNAME}/projects \
  && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN curl -fsSL https://claude.ai/install.sh | bash

USER root

RUN npm install -g opencode-ai@latest @openai/codex @mariozechner/pi-coding-agent \
  && npm cache clean --force

RUN mkdir -p /home/${USERNAME}/projects \
  && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}/projects

CMD ["bash"]
