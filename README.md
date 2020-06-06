# Set up dev environment

- Install Ruby (e.g. see instructions in https://gorails.com/setup/osx/10.15-catalina)
- Install PostgreSQL (e.g. see instructions in https://gorails.com/setup/osx/10.15-catalina)
- Install Rails and dependencies. Run `bundle install` in project directory.

# Set up database
- `bundle exec rake db:reset`
- `bundle exec rake db:fixtures:load`

# Run servers

- Run backend server: `rails s`
- Open `http://localhost:3000/` in a browser.
