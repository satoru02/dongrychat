class AuthController < ApplicationController
  def create
    if params[:provider] = 'google'
      google_token_uri = 'https://accounts.google.com/o/oauth2/token'
      tok_res = Faraday.post(google_token_uri) do |req|
        req.headers['Content-Type'] = "application/x-www-form-urlencoded"
        req.params['code'] = "#{params[:code]}"
        req.params['client_id'] = "#{ENV['GOOGLE_CLIENT_ID']}"
        req.params['client_secret'] = "#{ENV['GOOGLE_CLIENT_SECRET']}"
        req.params['redirect_uri'] = "#{params[:redirectUri]}"
        req.params['grant_type'] = 'authorization_code'
        req.params['access_type'] = "offline"
      end

      # Fix? => google api resourceを叩かず, authorization code flowで取得したid_tokenをデコードして処理を行っている。
      parsed_id_jwt = JSON.parse(tok_res.body)["id_token"]
      decoded_token = JWT.decode parsed_id_jwt, nil, false
      fetched_email = decoded_token[0]["email"]
    elsif params[:provider] = 'instagram'
    elsif params[:provider] = 'twitter'
    end

    unless User.find_by(email: fetched_email)
      user = User.create(
        email: fetched_email,
        password: SecureRandom.urlsafe_base64,
      )
      user.activate
    else
      user = User.find_by(email: fetched_email)
    end

    payload = { user_id: user.id, aud: [user.role] }
    session = JWTSessions::Session.new(
      payload: payload,
      refresh_by_access_allowed: true,
      namespace: "user_#{user.id}"
    )
    tokens = session.login
    response.set_cookie(
      JWTSessions.access_cookie,
      value: tokens[:access],
      httponly: true,
      path: "/"
    )
    render json: { csrf: tokens[:csrf], access_token: tokens[:access], user: user }
  end
end
