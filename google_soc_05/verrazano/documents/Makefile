all: design.pdf proposal.pdf implementation.pdf soc-endgame.pdf

design.pdf: design.tex
	pdflatex design.tex
	pdflatex design.tex

proposal.pdf: proposal.tex
	pdflatex proposal.tex

implementation.pdf: implementation.tex
	pdflatex implementation.tex

soc-endgame.pdf: soc-endgame.tex
	pdflatex soc-endgame.tex

clean: 
	rm -rf *.aux *.log *.pdf
