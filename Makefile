TEX = xelatex

.PHONY: all clean

all : resume clean

clean:
	rm -f *.toc *.aux *.log *.out

resume: tex/resume.tex
	$(TEX) tex/resume.tex
