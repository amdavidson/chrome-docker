FROM debian:sid-slim

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	hicolor-icon-theme \
	libcanberra-gtk* \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpango1.0-0 \
	libpulse0 \
	libv4l-0 \
	fonts-symbola \
    --no-install-recommends

RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable \
    --no-install-recommends

RUN apt-get purge --auto-remove -y curl \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome/Downloads && mkdir -p /home/chrome/data && chown -R chrome:chrome /home/chrome

COPY local.conf /etc/fonts/local.conf

USER chrome

VOLUME /home/chrome/data

ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/home/chrome/data", "--no-sandbox" ]
