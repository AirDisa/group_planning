module StripeHelper

  def set_creator_api(code, event)
  # fix indentation
  stripe_params = { 'client_secret' => ENV['STRIPE_SECRET_KEY'],
    'code' => code,
    'scope' => 'read_write',
    'grant_type' => 'authorization_code'}

    uri = URI.parse('https://connect.stripe.com/oauth/token')
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(stripe_params)
    res = https.request(req)

    # might be worth taking a gander at http://stackoverflow.com/questions/2778522/rails-update-attribute-vs-update-attributes
    event.update_attributes(:creator_api => JSON.parse(res.body)['stripe_publishable_key'])
  end
end
