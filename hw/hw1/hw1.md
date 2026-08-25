# Homework 1 — Typesetting w/ LaTeX

**Due:** Wednesday, September 23 by 9:05 am.

In this assignment, you will practice writing and compiling a LaTeX document from scratch,
typesetting the kind of math your other courses will ask for, using
cross-references, floats, and BibTeX, and keeping a `.tex` project under
version control.


---

## Submission Instructions

In your personal class repository, create a folder titled `hw1` containing `hw1.tex` (your
primary submission file), `hw1.bib` (your bibliography), and a `figures/` folder holding the
two figures provided with this assignment. Do **not** push the compiled `hw1.pdf` or any
build files; your `.gitignore` should handle that. Add, commit, and push everything before
class on September 23rd.

To grade your submission, I will clone your repository, `cd` into `hw1`, and run:

```
latexmk -pdf hw1.tex
```

To pass, your document must compile on my machine with no missing files, `??`, or
`[?]`. Note that a `.tex` file that only builds on your laptop is
a `.tex` file your coauthor can't use, so pretend I'm your coauthor.

There is a trap in this assignment. I am telling you that there is a trap. I am not telling
you where... May the odds be ever in your favor.

---

## Part 1: Set Up Your Folder

1. Download the four starter files from the class repository (`hw1_target.pdf`, `hw1.bib`,
   `figures/scatter.pdf`, and `figures/residuals.pdf`) and put them in your `hw1` folder,
   keeping the `figures/` subfolder structure. I highly recommend you do all this via `git` for practice.
2. Make sure your `.gitignore` covers LaTeX build junk. Think carefully about how you write
   the rule for your compiled PDF.

---

## Part 2: Reproduce the Target PDF

`hw1_target.pdf` is a three-page problem set. Your job is to write a `hw1.tex` that compiles
to a document matching it, with your own name in the author field.

The match doesn't have to be *perfect*, just good enough to show that you know what you're doing. The numbering, structure, and mathematics should
match; if your margins are a millimeter off, that's ok. I recommend working through it
section by section rather than typing the whole thing and compiling once at the end. That
way, when it breaks, you know what broke it.

Everything you need appears in the Lecture 3 and Lecture 4 notes, as well as
`example.tex` and `paper_example.tex`.

---

## Part 3: Requirements Checklist

Some of these are visible in the target PDF and some aren't because you can't tell from a PDF
whether I used a macro. Regardless, all of them are required. Here's a checklist to help you out.

Preamble and structure:

- [ ] A complete preamble: `\documentclass`, the packages you need, and title/author/date
- [ ] At least one macro defined with `\newcommand` and used in the body
- [ ] At least one operator defined with `\DeclareMathOperator` and used in the body
- [ ] Numbered `\section` headings

Math:

- [ ] Inline math and displayed math
- [ ] One numbered `equation`, referenced later with `\eqref`
- [ ] One multi-line derivation in an `align` environment
- [ ] A `theorem` and a `proof` environment via `amsthm`
- [ ] A matrix (`pmatrix`) and a piecewise definition (`cases`)
- [ ] Statistical notation: iid and convergence in distribution

Other fun things:

- [ ] A `table` float using `booktabs` rules, captioned **above**, labeled and referenced
- [ ] A two-panel `figure` float using `subcaption`, captioned **below**, labeled and
      referenced
- [ ] At least one `\citet` and one `\citep` plus a formatted bibliography

Version control:

- [ ] Everything needed to compile is pushed, and the PDF and build files are not

---

## Part 4: Add a Reference of Your Own

Find a paper that's actually relevant to your interests, grab its BibTeX entry from Google
Scholar (**Cite → BibTeX**), and add it to `hw1.bib`. Cite it somewhere sensible in your
document in a sentence of your own writing.

Check the entry before you trust it. Scholar's entries are frequently wrong, and titles with
proper nouns in them need `{braces}` to survive the bibliography style.

---

## Part 5: Commit as You Go

Your commit history should show at least three commits with descriptive messages, made at
points where you had actually finished something. Three commits pushed at 8:55 am on the due
date is not a commit history; it's an alibi.

---

## Part 6: AI Disclosure

At the end of your document, add a short unnumbered section titled "AI use" stating whether
and how you used an AI assistant on this assignment. One or two sentences is plenty. If you
didn't use one, say that.

To be clear about the standard, "I used Claude" is a disclosure. "I used Claude to draft the
align block; it produced `\Var` without declaring the operator, which I fixed by adding
`\DeclareMathOperator` to the preamble" is a disclosure that tells me you were paying
attention. Aim for the second kind.

---

## Grading

To pass:

1. Your repo contains `hw1.tex`, `hw1.bib`, and the figures, and does not contain the
   compiled PDF or build files.
2. `latexmk -pdf hw1.tex` builds cleanly from a fresh clone.
3. The output matches the target PDF, and every box in Part 3 is ticked.
4. Parts 4, 5, and 6 are completed.
5. Be able to explain your submission during a homework check-up.