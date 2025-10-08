FROM ruby:3.2

WORKDIR /app

RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/fonts/noto && \
    cd /tmp && \
    wget https://github.com/notofonts/noto-cjk/releases/download/Sans2.004/02_NotoSansCJK-TTF-VF.zip && \
    unzip 02_NotoSansCJK-TTF-VF.zip -d /usr/share/fonts/noto/ && \
    rm 02_NotoSansCJK-TTF-VF.zip

COPY Gemfile ./
RUN bundle install

COPY . .

RUN mkdir -p output
