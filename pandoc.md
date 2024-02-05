% Pandoc Markdown Cheatsheet
% D.Sánchez
% 2024

\pagebreak
# Pandoc

Pandoc allows many standard and non standard attributes to be used in its markdown rendering engine.

## Page and Paragraph Styling 

### Headers

`# Header 1` produces a level 1 (highest) header 

`## Header 2` produces a level 2 header.

`### Header 3` produces a level 3 header.

Headers may have an optional identifier to be able to be referenced by a link locally. This would look like this:
`# Header 1 {#name}`
This identifier is just a label that can be called from a link.

### Page and Line Break

`\pagebreak` inserts a pagebreak in the PDF output.

```
| lined output
| to preserve carriage return
```

Produces an output that preserves line breaks.

### Quotes

```
> Quote
> Multiple Lines
```
Produces a multiline quote.

### Code

~~~
```bash {.numberLines}
#!/bin/bash
echo "Text
```
~~~

Produces a code snippet with numbered lines.


#### Lists

Bullet list:
```
* First
* Second
* Third
```
Renders to:

* First
* Second
* Third

But:
```
* First

* Second

* Third
```
Renders to:

* First

* Second

* Third

Ordered lists:
```
1. First
2. Second
3. Third
```
Renders to:

1. First
2. Second
3. Third

While:
```
1. First

2. Second

3. Third
```
Renders to:

1. First

2. Second

3. Third

A task list ( needs `task_lists` extension ):
```
- [ ] Unchecked tesk 
- [X] Checked task
```
Renders to:

- [ ] Unchecked task 
- [X] Checked task

### Tables

Simple table:
```
-------------------------------------------------------------
 Centered   Default           Right Left
  Header    Aligned         Aligned Aligned
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line 
-------------------------------------------------------------

Table: Here's the caption. It, too, may span
multiple lines.
```

Renders to 1:

-------------------------------------------------------------
 Centered   Default           Right Left
  Header    Aligned         Aligned Aligned
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line 
-------------------------------------------------------------

Table: Here's the caption. It, too, may span
multiple lines.

Complex Table:
```
: Sample grid table 2.

+---------------+---------------+--------------------+
| Fruit         | Price         | Advantages         |
+===============+===============+====================+
| Bananas       | $1.34         | - built-in wrapper |
|               |               | - bright color     |
+---------------+---------------+--------------------+
| Oranges       | $2.10         | - cures scurvy     |
|               |               | - tasty            |
+---------------+---------------+--------------------+
```

Renders to:

: Sample grid table.

+---------------+---------------+--------------------+
| Fruit         | Price         | Advantages         |
+===============+===============+====================+
| Bananas       | $1.34         | - built-in wrapper |
|               |               | - bright color     |
+---------------+---------------+--------------------+
| Oranges       | $2.10         | - cures scurvy     |
|               |               | - tasty            |
+---------------+---------------+--------------------+

Pipe Table 3:
```
| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |
```

Renders to:

| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |


### Horizontal Rules

`- - -` Produces a horizontal rule on the page.

- - -

## Text Styling

### Bold text

`**Text**` produces an **bold** text.

### Italic text

`*Text*` produces an *italic* text segment.

### Underlined text

`[Text]{.underline}` produces an [underlined]{.underline} text.

### Strikethrough

`~~Text~~` produces an ~~struckthrough~~ text.

### Superscript

`Text^2^` produces a superscript^text^ which must not contain any spaces. 

### Subscript

`Text~sub~` produces a subscript^text^ which must not contain any spaces.

### Link

`[Text](http://www.link.com/)` This link would be labelled 'Text' and references to an url.

`[Text](#name)` whereas this would link to a header-label ( as established in the header section )

## Miscellaneous

### Images

Images principally are exactly like links, but preceded by an exclamation mark.
`![Smiley](https://pngimg.com/uploads/smiley/smiley_PNG15.png){width=10%}`

It is possible to apply css styles to the image with the curly braces.

![Smiley](https://pngimg.com/uploads/smiley/smiley_PNG15.png){width=10%}

## Pandoc command line options

### Table of Contents

If we need a clickable table of contents to be generated on the first page, the `--toc` parameter activates the generation.

### Code block Styling

Code blocks may be styled providing a theme. To know which themes are availabel to us, we may type:
`pandoc --list-highlight-styles`

After we have chosen a theme, we may select it by providing the following parameter to Pandoc.
`pandoc --highlight-style XXX` where XXX is the chosen theme.


