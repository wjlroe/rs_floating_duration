FROM ruby:3.3

WORKDIR /usr/bin/src

RUN apt-get update && apt-get install build-essential
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN ls -lhtra ~/.cargo/bin
RUN echo "${PATH}"
RUN echo $PATH
RUN which -a cargo

COPY . ./
RUN bundle install

# RUN bundle exec rake native gem
