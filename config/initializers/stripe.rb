if Rails.env.production?
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key => ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_pT3t5iWU7OmHhVbiVe0dhjBZ',
    :secret_key => 'sk_test_fddryjKpXxC9l6TE6rSC5eLE'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
