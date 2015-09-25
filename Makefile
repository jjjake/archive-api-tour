UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	JQ_URL = https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
else
	JQ_URL = https://github.com/stedolan/jq/releases/download/jq-1.5/jq-osx-amd64
endif

all: jq ia-pex ia-python-lib configure-ia

virtualenv:
	@printf "\n--- Creating virtualenv. ---\n\n"
	virtualenv -p python2.7 .venv

jq:
	@printf "\n--- Downloading jq binary. ---\n\n"
	mkdir -p bin
	curl -sL $(JQ_URL) > bin/jq
	chmod +x bin/jq

ia-pex:
	@printf "\n--- Downloading ia binary. ---\n\n"
	mkdir -p bin
	curl -sL https://archive.org/download/ia-pex/ia-0.9.2-py2.pex > bin/ia
	chmod +x bin/ia

ia-python-lib: virtualenv
	@printf "\n--- Installing internetarchive Python lib to virtualenv. ---\n\n"
	virtualenv -q -p python2.7 .venv
	.venv/bin/pip -q install internetarchive

configure-ia:
	@printf "\n--- Configure ia with your credentails. ---\n\n"
	bin/ia configure

clean:
	rm -rf .venv bin downloads
