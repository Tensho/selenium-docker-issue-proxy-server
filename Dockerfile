FROM ruby:2.7

RUN apt update && apt install jq -y

RUN mkdir /code

WORKDIR /code

COPY Gemfile* .

RUN bundle install

COPY . .

ENTRYPOINT ["./wait-for-selenium.sh"]

CMD ["ruby"]
