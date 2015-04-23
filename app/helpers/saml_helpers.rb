require 'ruby-saml'

module SAMLHelpers

  def saml_url(env)
    request = OneLogin::RubySaml::Authrequest.new
    request.create saml_settings(env)
  end


  def parse_saml_payload(saml_payload, env)
    response = OneLogin::RubySaml::Response.new(saml_payload, allowed_clock_drift: 1)
    response.settings = saml_settings(env)
    if response.is_valid?
      {
        external_id: saml_attribute(response, 'workforceID'),
        username: response.name_id.downcase,
        name: [saml_attribute(response, 'givenName'), saml_attribute(response, 'sn')].join(' '),
        email: saml_attribute(response, 'mail').downcase
      }
    else
      nil
    end
  end

  private

  def saml_settings(env)
    settings = OneLogin::RubySaml::Settings.new
    settings.assertion_consumer_service_url = "https://#{env.HTTP_HOST}/saml_callback"
    settings.issuer = env.saml[:issuer]
    settings.idp_sso_target_url = env.saml[:target_url]
    settings.idp_cert_fingerprint = env.saml[:cert_fingerprint]

    settings
  end

  def saml_attribute(response, att_name)
    response.attributes["/UserAttribute[@ldap:targetAttribute=\"#{att_name}\"]"]
  end

end
