# InterSection

InterSection is a Rails neighbourhood guide for a property's guest iPad. Guests choose a property, filter published places by category, tag or neighbourhood, and open places in Google Maps.

Run with Ruby and Bundler:

```sh
bundle install
ruby bin/rails db:prepare
ruby bin/rails server
```

Set DEMO_DATA=1 and run ruby bin/rails db:seed to load demo records. Run bundle exec rspec to check the catalogue and guest guide.
