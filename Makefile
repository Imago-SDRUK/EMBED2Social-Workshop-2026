.PHONY: build_site build_jlite serve_jlite

build_site:
	# Render slides
	cd slides && quarto render 01-Lab.qmd
	cd slides && quarto render 01-Lecture_slides.qmd
	cd slides && quarto render 02-Lecture_slides.qmd
	# Render site
	quarto render
	# Post-render provision
	rm -rf docs/slides
	cp -r slides/ docs/slides/
	cp -r jupyter-lite/dist docs/assets/jupyter-lite

build_jlite:
	### To be run inside a fresh container from repo home ###
	# Move assets to landing folder
	rm -rf jupyter-lite/content/*
	cp 02-Lab.ipynb jupyter-lite/content/
	cp -r assets/data jupyter-lite/content/
	# Set up environment
	conda create -yn jlite
	rm -rf jupyter-lite/dist jupyter-lite/.jupyterlite.doit.db
	# Build deployment
	. /opt/conda/etc/profile.d/conda.sh && \
		conda activate jlite && \
		pip install -r jupyter-lite/requirements.txt && \
		cd jupyter-lite && \
		jupyter lite build --contents content --output-dir dist

serve_jlite:
	jupyter lite serve --output-dir assets/jupyter-lite

