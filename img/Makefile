convert:
	# convert -density 600 ${name}-crop.pdf ${name}.png
	pdftoppm -png -r 300 ${name}-crop.pdf ${name}
	mv ${name}-1.png ${name}.png

mm_ln.png: mm_ln.tex
	pdflatex -shell-escape mm_ln.tex
	pdfcrop mm_ln.pdf
	make convert name=mm_ln
	make clean

intermediate.png: intermediate.tex
	pdflatex -shell-escape intermediate.tex
	pdfcrop intermediate.pdf
	make convert name=intermediate
	make clean

selfout.png: selfout.tex
	pdflatex -shell-escape selfout.tex
	pdfcrop selfout.pdf
	make convert name=selfout
	make clean

output.png: output.tex
	pdflatex -shell-escape output.tex
	pdfcrop output.pdf
	make convert name=output
	make clean

layernorm.png: layernorm.tex
	pdflatex -shell-escape layernorm.tex
	pdfcrop layernorm.pdf
	make convert name=layernorm
	make clean

bertpy.png: bertpy.tex
	pdflatex -shell-escape bertpy.tex
	pdfcrop bertpy.pdf
	make convert name=bertpy
	make clean

clean:
	rm -Rf *.fls *.gz *.*texmk *.out *.snm *.log *.toc *aux *.nav *-crop.pdf *.pdf _minted*

reallyclean:
	rm systolic.png head.png head_mm.png head_compute.png
