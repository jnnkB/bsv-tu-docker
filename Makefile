.DEFAULT_GOAL := build

bsc: 
	rm -rf bsc
	git clone \
		--recurse-submodules \
		--depth 1 \
		--branch ${shell curl --silent "https://api.github.com/repos/B-Lang-org/bsc/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"([^"]+)".*/\1/'} \
		https://github.com/B-Lang-org/bsc.git

BSVTools:
	wget https://github.com/esa-tu-darmstadt/BSVTools/archive/refs/heads/master.zip
	unzip master.zip
	rm master.zip
	mv BSVTools-master BSVTools

download: bsc BSVTools

clean:
	rm -f master.zip
	rm -rf bsc
	rm -rf BSVTools

build: download
	docker build -t bsv_tu_docker .
