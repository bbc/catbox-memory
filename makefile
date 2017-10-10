.PHONY: clean test test-docker publish
VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

################
# Dependencies #
################

$(PYTHON) $(PIP):
	virtualenv $(VENV)

#################
# Make commands #
#################

NODE_VERSION=$(shell cat .nvmrc | tr -d '[[:space:]]')
COMPONENT=$(shell node -p -e "require('./package.json').name.replace(/@/,'').replace(/\//,'-')")
COMPONENT_VERSION=$(shell node -p -e "require('./package.json').version")
DOCKER_IMAGE_NAME="$(COMPONENT)-test"
ETC_PKI_PATH=$(shell if [ "$${OSTYPE//[0-9.]/}"  == "darwin" ]; then echo "/private";fi)/etc/pki

clean:
	rm -rf node_modules

test:
	npm set registry https://npm.toolshed.tools.bbc.co.uk \
		&& npm config set cert -- "$$(openssl x509 -in /etc/pki/tls/certs/client.crt)" \
		&& npm config set key -- "$$(openssl rsa -in /etc/pki/tls/private/client.key)" \
		&& npm config set strict-ssl false \
		&& npm install \
		&& npm test

test-docker:
	docker run -t --rm --name $(DOCKER_IMAGE_NAME) -v $(PWD):/usr/src/app -v $(ETC_PKI_PATH):/etc/pki -w /usr/src/app node:$(NODE_VERSION) bash -c "make test"