TARGET: install

install: ./bin/puppet

./bin/puppet:
	bundle install --binstubs --path .bundle/vendor

