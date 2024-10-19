# Use the official Ruby image
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install bundler and gems
RUN gem install bundler -v 2.3.6 && bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (if applicable)
RUN bundle exec rake assets:precompile

# Expose the port Rails runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
