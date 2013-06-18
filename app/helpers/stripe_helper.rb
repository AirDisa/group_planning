module StripeHelper

  def set_creator_api(code, event)

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

    event.update_attributes(:creator_api => JSON.parse(res.body)['stripe_publishable_key'])
  end
end
