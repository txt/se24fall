-include ../Makefile


03code.html : 03code.md style.css
	echo "!! $@ ... "
	pandoc $< -o $@ $(Pandoc) --table-of-contents --number-sections  --toc-depth 6
