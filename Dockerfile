FROM registry.scc.suse.de/ruby

RUN zypper  --non-interactive --gpg-auto-import-keys ar \
	http://download.opensuse.org/repositories/devel:/libraries:/c_c++/SLE_12/devel:libraries:c_c++.repo
RUN zypper --non-interactive --gpg-auto-import-keys ref

RUN zypper --non-interactive install make gcc gcc-c++ zlib-devel tar patch

RUN mkdir /app
WORKDIR /app

COPY . /app/
RUN bundle install --deployment

EXPOSE 9000
CMD bundle exec ruby application.rb -s -e prod

