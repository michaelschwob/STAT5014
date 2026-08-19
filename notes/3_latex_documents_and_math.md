# STAT 5014 — Lecture 3: LaTeX Documents & Math

## Why LaTeX?

LaTeX is a typesetting system. You write plain-text source with markup, then compile
it into a polished PDF. Unlike a word processor, you describe *structure* and let LaTeX
handle the layout, which is why LaTeX documents look consistently professional (and impressive).

For statisticians, the killer feature is math typesetting, which is why LaTeX is the standard for statistics
papers. As a bonus, `.tex` is plain text, so it plays perfectly with the version control we learned
from last week.

The (simple) workflow is that you write the source (`example.tex`), run a compiler (`pdflatex`), and get a PDF (`example.pdf`). You'll compile either in the cloud
(**Overleaf**) or locally (with the **TinyTeX**/**MiKTeX** that you have installed). More on these compilers in a bit.

```
example.tex   --(pdflatex)-->   example.pdf
```



## Anatomy of a `.tex` Document

Every document has a **preamble** (settings and structure) and a **body** (the main text in the document with figures and tables):

```latex
\documentclass[11pt]{article}   % overall document type

\usepackage{amsmath}            % essential math package
\usepackage{amssymb}            % more math symbols

\title{My First Document}
\author{Your Name}
\date{\today}

\begin{document}
\maketitle                      % prints the title block

Hallo, world.
I'm sentient.

\end{document}
```

- `\documentclass{...}` sets the type (`article`, `report`, `beamer`, ...).
- `\usepackage{...}` loads add-ons. Always load `amsmath` and `amssymb` for math. You'll likely develop your go-to list of packages.
- Everything that appears in the PDF goes between `\begin{document}` and `\end{document}`.
- `%` starts a comment, so the rest of that line is ignored.
- A blank line starts a new paragraph; a single line break does *not*. The PDF would print "Hallo, world. I'm sentient." as one line.


| You want | You write |
|:--|:--|
| italic / bold | `\emph{text}`, `\textbf{text}` |
| typewriter (code) | `\texttt{text}` |
| quotation marks | ``` ``like this'' ``` (backticks open, apostrophes close) |
| a footnote | `\footnote{text}` |
| a hyperlink | `\url{https://...}` or `\href{URL}{text}` (needs `hyperref` package) |
| a forced line break | `\\` |
| unbreakable space | `~` (as in `Figure~1`) |

Quotes trip up everyone at least once; typing `"text"` gives you two wrong-facing marks. Use two
backticks to open and two apostrophes to close.

Special characters must be prefixed with a backslash: `\% \$ \& \_ \# \{ \}`. Typing a bare
`%` silently comments out the rest of the line rather than printing the percentage symbol.

### Structuring a Document

```latex
\section{Introduction}
\subsection{Background}
\subsubsection{A Detail}
\section*{Unnumbered Section}   % the star suppresses numbering
\tableofcontents                % auto-built from your sections
\begin{abstract} ... \end{abstract}
```

Sections number themselves automatically, unless programmed otherwise. Note that `\tableofcontents` is an excellent example of how LaTeX can automate an incredibly annoying task with ease.

## Math Mode

There are essentially three types of "math mode":

1. **Inline math** sits between dollar signs inside a line of text:
```latex
The sample mean is $\bar{x} = \frac{1}{n}\sum_{i=1}^{n} x_i$.
```
which gives: "The sample mean is $\bar{x} = \frac{1}{n}\sum_{i=1}^{n} x_i$."

2. **Displayed math** is centered on its own line. Use `\[ ... \]` or `$$ ... $$` (unnumbered) or the
`equation` environment (numbered):
```latex
\[ \hat{\beta} = (X^\top X)^{-1} X^\top y \]

\begin{equation}
  f(x) = \frac{1}{\sqrt{2\pi}\,\sigma}
         \exp\!\left(-\frac{(x-\mu)^2}{2\sigma^2}\right)
\end{equation}
```

3. **Aligned, multi-line equations** are constructed with the `align` environment, where `&` marks the alignment point and
`\\` ends a line:

```latex
\begin{align}
  \operatorname{Var}(X) &= \mathbb{E}[(X-\mu)^2] \\
                        &= \mathbb{E}[X^2] - \mu^2
\end{align}
```

Use `align*` to suppress the equation numbers, or `\nonumber` on any single line you want
skipped. Related environments from `amsmath`:

- **`gather`**: several centered equations, each numbered, with no alignment.
- **`split`**: one *single* numbered equation broken across lines. Use this when a
  derivation is logically one equation.
- **`cases`**: piecewise definitions.

Never leave a blank line inside a math environment. LaTeX reads it as a new
paragraph and produces a cryptic error message.


### Common Math Symbols

| You want | You write |
|:--|:--|
| superscript / subscript | `x^2`, `x^{22}`, `x_i`, `x_{ij}` |
| fraction | `\frac{a}{b}` |
| square root | `\sqrt{x}`, `\sqrt[3]{x}` |
| Greek letters | `\alpha \beta \sigma \mu \theta \Sigma` |
| sum / product / integral | `\sum_{i=1}^{n}`, `\prod`, `\int_a^b` |
| hats / bars / tildes | `\hat{\beta}`, `\bar{x}`, `\tilde{y}` |
| blackboard / script | `\mathbb{R}`, `\mathbb{E}`, `\mathcal{N}` |
| bold vectors / matrices | `\mathbf{x}`, `\boldsymbol{\beta}` |
| relations | `\leq \geq \neq \approx \sim \to \in \subset` |
| operators | `\times \cdot \pm \cup \cap` |
| binomial coefficient | `\binom{n}{k}` |
| text inside math | `\text{if } x > 0` |
| scaling delimiters | `\left( ... \right)`, `\left[ ... \right]`, `\left\{ ... \right\}` |

Note that multi-character sub/superscripts must be grouped. `x^{10}` gives
$x^{10}$, but `x^10` gives $x^{1}0$. Same idea for `x_{ij}` versus `x_ij`.

### Statistics-Specific Notation


| You want | You write |
|:--|:--|
| distributed as | `X \sim \mathcal{N}(\mu, \sigma^2)` |
| iid, over the tilde | `X_i \overset{\text{iid}}{\sim} F` |
| converges in distribution / probability | `\xrightarrow{d}`, `\xrightarrow{p}` |
| converges almost surely | `\xrightarrow{a.s.}` |
| independence | `X \perp Y`, or `X \perp\!\!\!\perp Y` for the wide version |
| limits | `\lim_{n \to \infty}` |
| conditional | `f(y \mid x)` (use `\mid`, not a bare `|`, for correct spacing) |
| evaluation bar | `\left. F(x) \right|_{x=0}` |
| stacked subscript | `\max_{\substack{i \in S \\ j \neq i}}` |
| defined as | `:=` or `\coloneqq` (needs `mathtools`) |
| approximately / proportional | `\approx`, `\propto` |

### Operators

Type `Var(X)` in math mode and LaTeX reads it as $V \cdot a \cdot r \cdot (X)$: four
italic variables multiplied together. Real operators are upright
and correctly spaced. Some are built in (`\log`, `\exp`, `\min`, `\max`, `\sin`), but the ones
statisticians need mostly aren't. Here are two fixes that you can generalize to whatever you need:

```latex
\operatorname{Var}(X)                      % one-off

\DeclareMathOperator{\Var}{Var}            % in the preamble
\DeclareMathOperator*{\argmin}{arg\,min}   % the * puts limits underneath
...
\Var(X)   \qquad   \argmin_{\theta} L(\theta)
```

So, you can declare `\Var`, `\Cov`, `\Bias`, `\MSE`, `\argmin`, and `\argmax` once in your preamble and
never think about it again.

### Matrices and Piecewise Functions

`pmatrix` gives parentheses, `bmatrix` gives square brackets, `vmatrix` gives the vertical
bars of a determinant, and `cases` handles piecewise definitions:

```latex
\[ \Sigma = \begin{pmatrix} \sigma_1^2 & \rho\sigma_1\sigma_2 \\
                            \rho\sigma_1\sigma_2 & \sigma_2^2 \end{pmatrix} \]

\[ \mathbf{1}\{x>0\} = \begin{cases} 1 & \text{if } x > 0 \\
                                     0 & \text{otherwise} \end{cases} \]
```


### Spacing and Delimiters

LaTeX's default math spacing is usually right, but two situations benefit from your input. First, `\left(`
and `\right)` grow to fit their contents; plain `(` and `)` don't:

```latex
( \frac{a}{b} )                 % sad, undersized parentheses
\left( \frac{a}{b} \right)      % correct
```

Second, manual spacing: `\,` (thin), `\;` (medium), `\quad` and `\qquad` (wide), and `\!`
(negative, for pulling things together). You may use `\,` before a differential
(`\int f(x)\,dx`) and `\quad` between an equation and a condition.

## Theorem and Proof Environments

Your theory courses may want theorems and proofs; `amsthm` makes them look like a
textbook. In the preamble, add:

```latex
\usepackage{amsthm}
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}[theorem]{Lemma}      % shares numbering with theorem
\theoremstyle{definition}
\newtheorem{definition}{Definition}
```

Then, in the body, you may use them as follows:

```latex
\begin{theorem}[Central Limit Theorem]
  Let $X_1, \ldots, X_n$ be iid with mean $\mu$ and finite variance $\sigma^2$. Then
  $\sqrt{n}(\bar{X}_n - \mu) \xrightarrow{d} \mathcal{N}(0, \sigma^2)$.
\end{theorem}

\begin{proof}
  Beyond the scope of these notes... which is a phrase you should get comfortable writing.
\end{proof}
```

The `proof` environment even puts the little tombstone at the end for you.

## Macros: Teach LaTeX *Your* Notation

This is the single biggest quality-of-life upgrade in this lecture. `\newcommand` defines
your own shorthand:

```latex
\newcommand{\E}{\mathbb{E}}       % \E -> E
\newcommand{\R}{\mathbb{R}}       % \R -> R
\newcommand{\bx}{\mathbf{x}}      % \bx -> bold x
\newcommand{\norm}[1]{\left\lVert #1 \right\rVert}   % \norm{x} -> ||x||
\newcommand{\inner}[2]{\langle #1, #2 \rangle}       % \inner{x}{y}
```

For the last two commands, `[1]` says the command takes one argument, and `#1` is where it lands.

One benefit in defining your own commands is if your advisor
decides in month four that the design matrix should be $\mathbf{X}$ instead of $X$, you change
one line in your preamble instead of 200 lines in your paper. Boom, the notation changes. Macros make
that free.

I recommend that you keep your favorites in a personal preamble file and carry it between projects.

## Lists

```latex
\begin{enumerate}
  \item Show that the estimator is unbiased.
  \item Derive its variance.
    \begin{enumerate}
      \item Start from the definition.
    \end{enumerate}
\end{enumerate}
```

Use `itemize` for bullets, `enumerate` for numbers, and `description` for term-and-definition
lists. They nest, and the numbering style changes automatically as you go deeper.

## Compiling Your Document

Everything above appears in `example.tex`, posted alongside these notes. Compile it, then play around. There are generally two ways people compile. I prefer Option A for collaborations and convenience.

**Option A: Overleaf.** <https://www.overleaf.com/> is browser-based, needs nothing
installed, and recompiles as you type. No install, no excuses. It's great for getting going
today and for collaborating; the downsides are that it needs internet and the free tier
limits some features. Create a project, paste your source, and hit **Recompile**.

**Option B: locally.** This is what you'd use with version control. With TinyTeX/MiKTeX
installed, open a terminal in the file's folder and run:

```
pdflatex example.tex
```

This produces `example.pdf` plus a few helper files. If your document uses cross-references
(we'll get to this next week), run it twice so that the references resolve. Better yet, use `latexmk -pdf
example.tex`, which figures out how many passes you need. RStudio also has a **Compile PDF**
button that handles all of this for you.

## Writing `.tex` for Version Control

Since `.tex` is plain text, it belongs in Git. Push your `.tex` and any figure files, but not
the compiled PDF or the build files.

One habit worth adopting: start each sentence on a new line in the source.
LaTeX doesn't care because it reflows paragraphs anyway, but Git works line by line. If a
paragraph is one enormous line, every typo fix shows up as "this entire paragraph changed"
and merge conflicts become unresolvable. One sentence per line makes your diffs readable and
your conflicts small.

## Hitting an Error?

- LaTeX errors are famously cryptic, but they aren't
  personal. The reported line is usually at or just above the problem. The usual suspects: a
  missing `$`, a mismatched `\begin`/`\end`, an unescaped special character, a blank line
  inside a math environment, or a math command used in text mode.
- If you can't find your error, comment out half the document and
  recompile. Repeat. You'll corner it in a few rounds, and this works when reading doesn't.
- Missing package? `! LaTeX Error: File 'foo.sty' not found` means install it. TinyTeX
  usually does this for you; otherwise `tinytex::tlmgr_install("foo")` from R.
- Overleaf's guides are excellent; start with
  [Learn LaTeX in 30 minutes](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes).
  For a symbol you can draw but can't name, [Detexify](https://detexify.kirelabs.org/) is
  stupid fun.
- LaTeX is a great place to ask an AI assistant for the syntax of an equation, but
  paste it in and confirm that it compiles. LLMs happily invent commands that don't
  exist, or they'll forget the package you needed.

## Before Next Week

- Practice by typesetting a page from a current problem set in another course. This is
  exactly what Homework 1 will ask.
- Next week: figures, tables, cross-references, and citations with BibTeX.
