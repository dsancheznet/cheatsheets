# Makefile to recompile all MD files in current directory
# PANDOC : Find executable of pandoc on this system
PANDOC=$(shell which pandoc)
#Specify options to pass into pandoc
OPTS=--toc --highlight-style breezedark --number-sections --listings  -V papersize:a4
#Read source files from current directories
SRC = $(wildcard *.md)
#Convert to list of destination files
DST = $(SRC:.md=.pdf)
#Create a phony rule
.PHONY: all clean
#Source all destination files
all: $(DST)
#Rule to create those files
%.pdf : %.md 
	$(PANDOC) $< $(OPTS) -o $@
#Delete all old pdf files
clean:
	rm *.pdf
