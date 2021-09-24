.PHONY: review build default

default: output.zip

review: source
	@./review-draft.sh

build: output

output.zip: output
	cd output/ && 7z a ../output.zip .

output: source
	@echo "Docker requires root (the docker group essentially grants its members"
	@echo "root privileges). Remember to run this as root."
	-mkdir output
	docker run --mount "type=bind,source=$(CURDIR),destination=/whatwg/html,readonly=1" --env "HTML_SOURCE=/whatwg/html" --mount "type=bind,source=$(CURDIR)/output,destination=/whatwg/output" --env "HTML_OUTPUT=/whatwg/output" flyin1501/html-build
