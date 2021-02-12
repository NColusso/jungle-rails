# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.
Goal of the project was to simulate real-world examples of adding additional features and bug fixes to an existing application, in a learn as you go process.

From the pre-existing application, additional features were added such as:

- Correction of inconsistent decimal places on prices
- Sold out badge showing up on item when there is no quantity left of product
- Inventory count updating after purchase of a product
- Login required for admin pages
- Ability for admins to add addtional categories and products
- Testing
  - RSpect testing with Capybara and Poltergeist

## Screenshots

!["Screenshot of home page"](https://github.com/NColusso/jungle-rails/blob/master/public/screenshots/main.png?raw=true)
!["Screenshot of sold out tag"](https://github.com/NColusso/jungle-rails/blob/master/public/screenshots/sold-out.png?raw=true)
!["Screenshot of login"](https://github.com/NColusso/jungle-rails/blob/master/public/screenshots/login.png?raw=true)
!["Screenshot of main admin page"](https://github.com/NColusso/jungle-rails/blob/master/public/screenshots/store-info.png?raw=true)
!["Screenshot of main admin product page"](https://github.com/NColusso/jungle-rails/blob/master/public/screenshots/admin-products.png?raw=true)

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
- PostgreSQL 9.x
- Stripe
