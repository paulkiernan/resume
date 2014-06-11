TEX = xelatex

.PHONY: all view clean cleanall

all : resume clean

view :
	open resume.pdf

clean:
	rm -f *.toc *.aux *.log *.out

cleanall:
	rm -f *.toc *.pdf *.aux *.log *.out

resume: resume.tex
	$(TEX) resume.tex
