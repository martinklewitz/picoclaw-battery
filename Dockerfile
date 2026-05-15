FROM docker.io/sipeed/picoclaw:v0.2.7-launcher AS picoclaw

FROM node:24-alpine3.23

RUN apk add --no-cache \
  ca-certificates \
  curl \
  git \
  python3 \
  py3-pip \
  chromium \
  jq

# Install Playwright browsers for agent-browser
# ENV PLAYWRIGHT_BROWSERS_PATH=/opt/playwright-browsers
# RUN npm install -g agent-browser && \
#    npx playwright install chromium && \
#    chmod -R o+rx $PLAYWRIGHT_BROWSERS_PATH

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
  ln -s /root/.local/bin/uv /usr/local/bin/uv && \
  ln -s /root/.local/bin/uvx /usr/local/bin/uvx && \
  uv --version \


RUN wget -O /etc/apk/keys/claude-code.rsa.pub \
  https://downloads.claude.ai/keys/claude-code.rsa.pub \
  echo "https://downloads.claude.ai/claude-code/apk/stable" >> /etc/apk/repositories \
  apk add claude-code


# Copy binaries
COPY --from=picoclaw /usr/local/bin/picoclaw /usr/local/bin/picoclaw
COPY --from=picoclaw /usr/local/bin/picoclaw-launcher /usr/local/bin/picoclaw-launcher

# Create picoclaw home directory
RUN /usr/local/bin/picoclaw onboard

ENTRYPOINT ["picoclaw-launcher"]
CMD ["-console", "-public", "-no-browser"]
