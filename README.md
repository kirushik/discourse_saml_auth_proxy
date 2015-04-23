# SAML Authentication proxy for Discourse SSO

Built on top of [Grape API framework](https://github.com/intridea/grape/) and [Goliath web server](https://github.com/postrank-labs/goliath/), this tiny API serves Discourse SSO protocol and talks with SAML2 authentication endpoints.

You should point your Discourse instance to SSO API at `https://<host-with-this-API.com>/login`, and set the proper SAML endpoint data in `config/production.rb` (requires restart). Everything else will be handled automatically. The configuration options are rather limited at the moment, but should be pretty self-descriptory.
