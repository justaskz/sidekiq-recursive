test:
	@ rspec

build: clear
	@ bundle
	@ gem build *.gemspec

release: test build
	@ gem push *.gem

clear:
	@ rm -rf pkg
	@ rm -rf *.gem
