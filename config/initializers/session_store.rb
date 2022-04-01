# frozen_string_literal: true

if Rails.env == 'production'
  Rails.application.config.session_store :cookie_store, key: '_basecamp_app', domain: 'localhost'
else
  Rails.application.config.session_store :cookie_store, key: '_basecamp_app'
end