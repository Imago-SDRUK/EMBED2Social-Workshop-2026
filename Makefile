.PHONY: build_jlite serve_jlite

build_jlite:
	### To be run inside a fresh container from repo home ###
	# Move assets to landing folder
	rm jupyter-lite/content/*
	cp 02-Lab.ipynb jupyter-lite/content/
	cp assets/uk_lsoa_london_embeds_2024.geojson jupyter-lite/content/
	# Set up environment
	conda create -yn jlite
	rm -rf jupyter-lite/dist jupyter-lite/.jupyterlite.doit.db
	. /opt/conda/etc/profile.d/conda.sh && \
		conda activate jlite
	pip install -r jupyter-lite/requirements.txt
	# Build deployment
	cd jupyter-lite && \
		jupyter lite build --contents content --output-dir dist
	cp -r jupyter-lite/dist assets/jupyter-lite

serve_jlite:
	jupyter lite serve --output-dir assets/jupyter-lite

