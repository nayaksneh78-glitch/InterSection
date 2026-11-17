# InterSection

InterSection is a Rails neighbourhood guide for a property’s guest iPad. Guests choose a property, filter its recommendations by category, tag or neighbourhood, and open each place in Google Maps. Operators maintain the catalogue in Active Admin.

## Run locally

Use Ruby 3.3 or 3.4 with Bundler. On Windows, install RubyInstaller **with Devkit** so Bundler can build native gems.

```sh
bundle install
ruby bin/rails db:prepare
ruby bin/rails server
```

Open http://localhost:3000 for the guest guide and http://localhost:3000/admin for Active Admin. Bookmark `/properties/<id>` on an iPad assigned to one property. A single property automatically opens from the home page.

To preview the guide with optional demo data, set `DEMO_DATA=1` and run `ruby bin/rails db:seed`. The production catalogue starts empty until operators add records or an API client imports them.

To create an operator, set `ADMIN_EMAIL` and `ADMIN_PASSWORD` in the shell environment and run `ruby bin/rails intersection:create_admin`. There is no default account. In PowerShell, set variables using `$env:ADMIN_EMAIL = "operator@example.com"`. Remove the password environment variable once the account is created.

## Configure a database

Development defaults to SQLite. Set `DATABASE_URL` to connect to an existing PostgreSQL or SQLite database. The migrations expect the application table names to be available. If the database already contains matching tables or similar data, compare its schema and reconcile migration history against a copy before running `db:migrate` on it. Test uses its own database by default and can be configured via `TEST_DATABASE_URL`.

For production, set `DATABASE_URL`, `SECRET_KEY_BASE` through the deployment environment. Serve the application over HTTPS. Run `ruby bin/rails db:migrate` and `ruby bin/rails assets:precompile` before starting the server.

## Publish a guide

1. Create the property, tags and categories.
2. Create a neighbourhood and assign a tag.
3. Under **Property assignments**, connect the neighbourhood to the property.
4. Create city gems with a category, tag, neighbourhood, and a street address or other searchable location. Optionally supply a public HTTPS image URL.
5. Publish the city gem, the neighbourhood, and the assignment. To hide a neighbourhood for one property only, unpublish that assignment.

A neighbourhood can be assigned to multiple properties. A gem belongs to one neighbourhood, one category and one tag. The neighbourhood has its own tag. Each published gem appears for all published assignments of its published neighbourhood. Reassign existing references before deleting a tag or category. Deleting a neighbourhood deletes its assignments and gems.
