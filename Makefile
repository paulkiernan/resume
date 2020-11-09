TEX = xelatex

.PHONY: all clean

all : cleanall resume clean

clean:
	rm -f *.toc *.aux *.log *.out

cleanall:
	rm -f *.toc *.pdf *.aux *.log *.out


resume: tex/resume.tex
	$(TEX) tex/resume.tex
