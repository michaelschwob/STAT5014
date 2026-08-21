# STAT 5014 — Lecture 4: LaTeX Figures, Tables & Citations

In the previous lecture, we learned how to structure a document and add math. This week, we'll add the pieces that turn a
document into a paper: cross-references, floats, algorithms, and a bibliography. Feel free to follow along with `paper_example.tex` (with `paper_example.bib` and its figures), which uses everything below.

## Cross-References

Cross-references allow us to automatically update references as the document evolves. For example, if we type "Equation 3," then add two equations before Equation 3 at a later date, our reference number needs to be updated. However, with cross-references, we never have to explicitly type numbers; LaTeX handles that for us.
We can cross-reference with the following:

```latex
\section{Introduction}
\label{sec:intro}

\begin{equation}\label{eq:slr}
  y_i = \beta_0 + \beta_1 x_i + \varepsilon_i
\end{equation}
... as shown in Equation~\eqref{eq:slr} and Section~\ref{sec:intro}...
```

- `\ref{key}` inserts the number, `\eqref{key}` adds the parentheses for equations, and
  `\pageref{key}` gives the page.
- The `~` is a non-breaking space, so "Figure~3" never splits across a line break.
- I recommend prefixing labels by type (`sec:`, `eq:`, `tab:`, `fig:`, `alg:`) so that you can
  tell what you're referencing.

Importantly, you must compile twice. The first pass records where every label lives and the
second fills in the numbers. If you see `??` in the output, you didn't compile enough times
(or you mistyped a key). Loading `hyperref` also makes every reference clickable, which is
free and worth doing.

## Figures

Load `graphicx`, then place an image inside a `figure` float:

```latex
\begin{figure}[ht!]
  \centering
  \includegraphics[width=0.7\textwidth]{figures/scatter.pdf}
  \caption{Simulated data with an OLS fit.}
  \label{fig:scatter}
\end{figure}
```

- I highly recommend that size width is relative to `\textwidth` (e.g., `0.7\textwidth`) so that figures scale with the
  page instead of a fixed inch count.
- A figure's caption goes *below* it.
- Try to stick to vector formats (SVG, PDF, or PNG) so that figures stay crisp
  when someone zooms in. Some journals have very specific formatting guidelines that may specify a particular file type.
- The figure file is the exception to "don't push generated files" because it's an input
  that is needed to compile. Even better, push the script that makes it, so that the figure is
  reproducible.

### Float Placement

LaTeX treats figures and tables as **floats** and
moves them wherever they fit best, which is why "the figure below" is a promise you cannot
keep. Always refer to figures with `\ref`.

The placement options are `h` (here), `t` (top), `b` (bottom), and `p` (its own page), and `!`
means "try harder, ignore your usual aesthetic rules." I use `[ht!]` for nearly everything.

If a float drifts too far, `\clearpage` forces everything pending to print before continuing, but resist the urge to
fight placement until you're finalizing your manuscript. LaTeX is usually right, and rearranging floats
early is a world-class way to procrastinate.

### Subfigures

Side-by-side panels, which statistics papers are made of, come from `subcaption`:

```latex
\usepackage{subcaption}
...
\begin{figure}[ht!]
  \centering
  \begin{subfigure}[b]{0.48\textwidth} % 48% of page width, aligned at the "b"ottom
    \includegraphics[width=\textwidth]{figures/scatter.pdf} % this textwidth is actually .48\textwidth
    \caption{Fitted model.}\label{fig:panel-a}
  \end{subfigure}
  \hfill % adds horizontal space between the subfigures to push them apart
  \begin{subfigure}[b]{0.48\textwidth} % 48% of page width, aligned at the "b"ottom
    \includegraphics[width=\textwidth]{figures/residuals.pdf} % this textwidth is actually .48\textwidth
    \caption{Residuals.}\label{fig:panel-b}
  \end{subfigure}
  \caption{Model fit and diagnostics.}\label{fig:diagnostics} % MEGA caption
\end{figure}
```

That gives you Figure 1a and Figure 1b, each individually referenceable. Keep the two widths
summing to a bit under 1.0 to leave room for LaTeX to work its magic.

### Figures From R and Python

A few things make generated figures look "at home" in a paper. The big one: size the figure where
you make it, not in LaTeX. If you save a plot at 3 inches wide and then blow it up with
`width=\textwidth`, every label scales up with it and your fonts end up mismatched with your
body text. Save at roughly the width it will appear.

```r
ggsave("figures/scatter.pdf", width = 6, height = 4) # R
```

```python
fig.savefig("figures/scatter.pdf", bbox_inches="tight") # Python
```

Aim for roughly 10pt text in the final PDF so that figure labels match the surrounding text. Though, this may require trial and error.

## Tables

Tables are built with `tabular`, where the column spec sets alignment (`l`/`c`/`r`), `&`
separates cells, and `\\` ends a row. Wrap it in a `table` float for a caption and label.

```latex
\begin{table}[ht!]
  \centering
  \caption{Simulation settings.}
  \label{tab:settings}
  \begin{tabular}{lrr} % 3 columns: "l"eft aligned, "r"ight aligned, "r"ight aligned
    \toprule % adds a horizontal line at the top of the table
    Scenario & Sample size $n$ & Noise SD $\sigma$ \\ % math in tables!
    \midrule % a thinner horizontal line
    Baseline & 60  & 1.0 \\
    Noisier  & 60  & 2.5 \\
    \bottomrule % adds a horizontal line at the bottom
  \end{tabular}
\end{table}
```

- Optional: use the `booktabs` package (`\toprule`, `\midrule`, `\bottomrule`) instead of `\hline` and
  vertical lines everywhere. Vertical rules in tables are the Comic Sans of typesetting...
- A table's caption goes *above* it, which is the opposite of figures. Nobody knows why. Okay, some people do. I don't.
- Note that `p{3cm}` (in place or "l" or "r") gives a fixed-width column that wraps text, which is good for a
  description column that would otherwise run off the page.
- For papers, don't spend too much time styling tables. Most journals will have a specific style in their "style files." More on that later.

### Spanning Cells

```latex
\usepackage{multirow} % let's a single cell span multiple rows
...
\begin{tabular}{llrr}
  \toprule
  & & \multicolumn{2}{c}{Estimates} \\   % one "c"entered cell spanning "2" columns
  \cmidrule(lr){3-4} % a partial horizontal line under columns 3 and 4 only with a small left/right margin (lr)
  Model & Prior & Mean & SD \\
  \midrule
  \multirow{2}{*}{GP} & Flat   & 1.02 & 0.11 \\   % one cell spanning two rows; "*" let's LaTeX pick the width
                      & Ridge  & 0.98 & 0.09 \\
  \bottomrule
\end{tabular}
```

`\cmidrule(lr){3-4}` is a partial rule under just the spanned columns and makes a grouped header look professional rather than homemade.

### Decimal Alignment

Numbers in a right-aligned column look fine until the decimals don't line up. The `siunitx`
package fixes this with `S` columns:

```latex
\usepackage{siunitx}
...
\begin{tabular}{l S[table-format=2.3] S[table-format=1.2]}
  \toprule
  {Model} & {Estimate} & {SE} \\
  \midrule
  Baseline & 12.345 & 0.11 \\
  Ridge    &  1.200 & 0.09 \\
  \bottomrule
\end{tabular}
```

`table-format=2.3` says "two digits before the decimal, three after." The one gotcha is that
header cells in an `S` column need `{braces}` around them. The result aligns on the decimal
point automatically.

### Tables That Don't Fit

If a table is too wide, wrap it in `\resizebox{\textwidth}{!}{ ... }` (this shrinks the fonts
too, so use it sparingly) or rotate the whole page with the `pdflscape` package's `landscape`
environment. If it's too long, `longtable` lets a table break across pages with repeating
headers, though note it is *not* a float, so it goes exactly where you put it.

### Generating Tables From Code

- In R, `knitr::kable(df, format = "latex", booktabs = TRUE)` handles a data frame, `xtable`
  gives more control, and `modelsummary` or `stargazer` produce a publication-ready
  coefficient table straight from a fitted model.
- In Python, `df.to_latex()` in pandas or the `tabulate` package.

Read what they produce before you paste it because these tools have opinions about rounding. Another tool worth mentioning is [Tables Generator](https://www.tablesgenerator.com/), which allows you to customize your tables visually (without source code).

## Citations & BibTeX

Keep your references in a `.bib` database, which is a plain-text file of entries, each with a
**key** that you cite:

```bibtex
@article{efron1979bootstrap,
  author = {Efron, Bradley},
  title = {Bootstrap Methods: {A}nother Look at the Jackknife}, % {braces} force LaTeX to capitalize
  journal = {The Annals of Statistics},
  year = {1979}, 
  volume = {7}, 
  number = {1}, 
  pages = {1--26} % don't skip the double hyphen!
}
```

An easy way to get entries is via Google Scholar: click **Cite → BibTeX**. You can also export
from Zotero or Mendeley (yet more software) or copy from some journal pages. Then, with the `natbib` package:

| You want | You write | You get |
|:--|:--|:--|
| textual citation | `\citet{efron1979bootstrap}` | Efron (1979) |
| parenthetical | `\citep{tibshirani1996regression}` | (Tibshirani, 1996) |
| with a note | `\citep[see][Ch.~7]{casella2002statistical}` | (see Casella and Berger, 2002, Ch. 7) |
| author only | `\citeauthor{efron1979bootstrap}` | Efron |
| year only | `\citeyear{efron1979bootstrap}` | 1979 |
| several at once | `\citep{a,b,c}` | (A, 1999; B, 2003; C, 2010) |
| in the reference list but not cited | `\nocite{key}` | *(nothing in text)* |

At the end of the document, choose a style and point to the `.bib` file (excluding the ".bib" extension):

```latex
\bibliographystyle{plainnat} % there are many to choose from but only a few that statisticians use; some journals provide their own
\bibliography{paper_example} % the .bib file without the extension
```

Citations need a four-step compile, which is why `latexmk` exists:

```
pdflatex paper_example.tex   # records which keys are cited
bibtex paper_example         # builds the reference list from the .bib
pdflatex paper_example.tex   # inserts the references
pdflatex paper_example.tex   # resolves the numbers
```

Overleaf runs this automatically, `latexmk -pdf paper_example.tex` runs the whole sequence for
you, and RStudio's **Compile PDF** button handles it, too. If a citation shows up as `[?]`, you
skipped the `bibtex` step or mistyped a key. Don't worry -- this will happen to you for the rest of your
career.

### Managing Your `.bib`

Three things bite everyone eventually:

1. Many styles lowercase titles, turning "Bayesian" into
   "bayesian". Protect words with braces: `title = {A {Bayesian} Approach to {MCMC}}`.
2. Google Scholar's entries can be sloppy. Missing volumes, wrong years, and "Journal of the Royal
   Statistical Society: Series B (Methodological)" spelled four different ways. Fix them once
   in your `.bib` rather than every time you cite.
3. You will accumulate hundreds of these, so I recommend that you use a reference manager. Zotero (free) with the
   Better BibTeX extension keeps a `.bib` file synced automatically with stable citation keys.
   Set it up now and thank yourself (and me) later.

One more decision you'll eventually meet: `natbib` + `bibtex` is what most statistics journals
still expect, and it's what we use. `biblatex` + `biber` is more capable and increasingly
common elsewhere. For now, we'll learn `natbib`.

## Algorithms

Statistics papers are full of pseudocode, and there's (of course) a package for it:

```latex
\usepackage{algorithm}
\usepackage{algpseudocode}
...
\begin{algorithm}[ht!]
  \caption{Nonparametric bootstrap}\label{alg:boot}
  \begin{algorithmic}[1] % "[1]" starts line numbering at 1
    \Require data $x_1,\ldots,x_n$; replicates $B$
    \For{$b = 1$ \textbf{to} $B$}
      \State draw $x_1^*,\ldots,x_n^*$ with replacement from $x_1,\ldots,x_n$
      \State compute $\hat{\theta}^*_b$ from the resample
    \EndFor
    \State \Return the empirical distribution of $\hat{\theta}^*_1,\ldots,\hat{\theta}^*_B$
  \end{algorithmic}
\end{algorithm}
```

`algorithm` is the float (caption, label, `\ref`) and `algorithmic` is the pseudocode inside.

## Appendices

```latex
\appendix
\section{Proofs}          % becomes "Appendix A"
\section{Extra Figures}   % becomes "Appendix B"
```

`\appendix` doesn't print anything; it just tells LaTeX to start lettering your sections from
here on. Everything else keeps working.

## Classes, Packages, and Journal Styles

A **package** (`.sty`) adds features and is loaded with `\usepackage`. The ones you'll reach
for most in this course are `amsmath`, `amssymb`, `amsthm`, `graphicx`, `booktabs`,
`subcaption`, `siunitx`, `natbib`, `hyperref`, `geometry`, `xcolor`, and
`algorithm`. Most of the time, package order mostly doesn't matter. Note that if you're compiling LaTeX documents in `R`, install packages via `tinytex::tlmgr_install("algorithm")`.

A **bibliography style** (`.bst`) controls how references are formatted, and journals provide
their own (e.g., `jasa.bst`); drop it in your folder and set `\bibliographystyle{jasa}`. A
**document class** (`.cls`) controls the whole layout, and journals provide submission classes
(`imsart`, `elsarticle`, and so on); swap `\documentclass{article}` for the journal's.

Honestly, the fastest start for a real submission is a journal's Overleaf template, which
comes with the right class and style already wired up.

## Writing for Version Control

Push everything needed to compile: `.tex`, `.bib`, figure files, and any `.bst`/`.cls` the
journal requires. A collaborator should be able to clone your repo and build. Don't push the
compiled `.pdf` or the build files (`.aux`, `.bbl`, `.blg`, `.log`, `.out`, `.synctex.gz`);
the `.gitignore` from Lecture 2 already handles these.

## Hitting an Error?

- `??` or `[?]` in the output means compile more times, run `bibtex`, or fix a mistyped key.
- "File not found" on a figure means a wrong path or filename. Use forward slashes, even on
  Windows, and check the extension.
- "Extra alignment tab" or "Misplaced `\noalign`" in a table means your `&` count doesn't
  match the number of columns.
- "Undefined control sequence" on a table or figure command usually means a missing
  `\usepackage`.
- AI assistants are handy for debugging and structuring tables/figures. However, LLMs invent citations with total confidence!

## Before Next Week

- Homework 1 asks you to typeset a short problem set using everything from the last two weeks.
  Details are in the assignment.
