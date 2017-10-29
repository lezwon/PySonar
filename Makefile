.PHONY: test import-abi

test:
	pytest --flake8

import-abi:
	npm install && \
	cp node_modules/@openmined/sonar/build/*.abi abis/
    
docker:
	if [ "$(sudo docker images -q capsule_notebook 2> /dev/null)" == "" ]; then \
		if [ ! -d ~/Capsule ]; then git clone "https://github.com/lezwon/Capsule.git" ~/Capsule; fi; \
		echo "hello" \
		sudo docker build ~/Capsule -t capsule_notebook; \
	fi
	sudo docker-compose up
