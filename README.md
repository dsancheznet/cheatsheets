# cheatsheets

I have collected these cheatsheets over time. Whenever I'm learning a new programming language or software, 
I usually take notes and put it into a cheatsheet. These cheatsheets help me to get into the topic again 
after long periods of not working with that software/language. It serves me as a reference to kickstart my memory

:smile:

## Available cheatsheets

1. Pandoc

2. Shell

3. PHP

## Converting the cheatsheets to PDF with Pandoc

I use the following parameters to call pandoc to generate these cheatsheets:

```
pandoc input-filename.md --toc --highlight-style breezedark --pdf-engine=xelatex -V papersize:a4 -o output-filename.pdf
```

Furthermore, I have added a make file which compiles the MD files automatically. Just issue a  `make` and the PDF
files will be rebuilt ( if neccessary ). 

## Links

* [Pandoc: colors, styles and tricks](https://girondi.net/post/pandoc_notes/)
