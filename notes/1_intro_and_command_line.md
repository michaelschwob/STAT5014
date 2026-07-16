# STAT 5014 — Lecture 1: Introduction & the Command Line

## Welcome

This is an interactive one-credit course on the computing tools you'll use throughout your
studies: the command line, Git/GitHub, LaTeX, R, and Python. It's deliberately broad
rather than deep because we need to make each tool familiar enough that you can pick it
up and keep teaching yourself (or have AI help you). This is not a programming course nor an R course;
it's a "get comfortable with the toolkit" course.

A few logistics worth highlighting:

- Course materials will be on GitHub: `michaelschwob/STAT5014`. Announcements and grades
  will be posted on Canvas.
- Homeworks will be submitted through your own GitHub repository (details in **Homework 0**).
- This course is **pass/fail**; you pass by passing at least 5 of the 6 graded
  assignments. Attendance isn't graded but it wouldn't hurt!
- The internet and (increasingly) AI are your best resources. We'll
  talk about how to use them well.

The overall goal of this course is to have you be a competent user of the typical statistical workflow.

## So, What Is a Typical Workflow, Michael?

Great question:

- **Shell/command line** (today): the foundation that everything else runs on.
- **Git & GitHub**: version control (what is this?!) and how you'll turn-in work.
- **LaTeX**: typesetting math, papers, and presentations.
- **R & Quarto**: need I defend R? Quarto helps make nice documents that combines code,
  text, and math.
- **Python**: the other workhorse; we'll set up **VS Code** (a popular IDE) when we get here.

I'm writing these notes and you'll write your assignments in Markdown with LaTeX. Conveniently, GitHub renders
LaTeX equations inside Markdown, so equations can go right in your writing (e.g.,
$\bar{x} = \frac{1}{n}\sum_{i=1}^{n} x_i$). Once we reach R, we'll use Quarto for notes and submissions, 
which is the same as Markdown+LaTeX, but with runnable code!

## Why Bother with the Command Line?

Because we instantly look more impressive.

And because understanding the command line is a foundational, transferable skill. During your PhD you
may need it for remote workstations, bash scripting, parallel computing, or supercomputing
resources. And most immediately, for **Git**. Graphical Git clients exist, but I strongly
encourage you to use Git from the command line because you "git" full control and full
functionality.

## Opening a Terminal

The OS-dependent "terminal" is the app where you type commands:

- **macOS:** the built-in **Terminal** app.
- **Windows:** install **Git for Windows**, which includes **Git Bash**; this will be your
  terminal for this course. Git Bash gives you the same Unix-style commands that Mac and
  Linux users have.
- **Linux:** *if you use Linux, you already know, nerd...*

From here on, the commands are identical across every OS unless stated otherwise.

## Essential Commands

*NOTE: Uppercase words are placeholders that you'll replace with your own names*

| Command | What it does |
|:---|:---|
| `cd` or `cd ~` | change to your home directory |
| `cd ..` | go up to the parent directory |
| `cd FOLDERNAME` | move into a folder within your current directory |
| `pwd` | print the current (working) directory |
| `ls` | list files; `ls -a` also lists hidden ones |
| `mkdir FOLDERNAME` | make a folder/directory |
| `rmdir FOLDERNAME` | remove an empty folder/directory |
| `rm FILE` | remove a file; can't be undone! |
| `rm -r FOLDERNAME` | remove a folder and everything in it, so be careful! |
| `cp SOURCE DEST` | copy a file from `SOURCE` to `DEST` |
| `mv SOURCE DEST` | move (or rename) a file |
| `grep "TEXT" FILE` | search for text inside a file |
| `top` (or `htop`) | show running processes |
| `kill JOBID` | stop the process with that ID |

**IMPORTANT**: There is no undo for `rm`. Read the command twice before you press enter.

Most commands take optional flags that modify their behavior. Rather than list them all,
here are good references:

- <https://www.codecademy.com/article/command-line-commands>
- <https://developer.mozilla.org/en-US/docs/Learn_web_development/Getting_started/Environment_setup/Command_line>

## Editing Files in the Terminal via Vim

You'll occasionally need to edit a file without leaving the terminal. **Vim** is available
almost everywhere (along with **Nano**). There is so much to Vim, but the essentials are:

- `vim FILENAME` — open (or create) a file.
- Press `i` to enter **INSERT** mode, where you can type.
- You can only move with the arrow keys, not the mouse.
- Press `Esc` to leave INSERT mode.
- Type `:wq` then Enter to save and quit. (`:q` quits; `:q!` quits *without* saving.)

Handy cheat sheet: <https://vim.rtorr.com/>

## Personalize Your Shell via dotfiles

A hidden startup file in your home directory runs every time you open a terminal, which is a great
place for personal shortcuts and settings. The file is:

- **`.zshrc`** on modern macOS,
- **`.bashrc`** on Git Bash (Windows) and Linux.

Create or edit it with `cd ~`, then `vim .zshrc` (or `.bashrc`). You can define shortcuts
with `alias`. For example, to make `rm` ask for confirmation every time:

```
alias rm="rm -i"
```

Try it! Add that line, reopen your terminal, and `rm` now prompts before deleting :)

## Using AI Tools Well

This course **allows** AI assistants (e.g., ChatGPT, Claude, Copilot, etc.). Part of
your training is learning to use them like a professional rather than a mindless monkey. Here are the main tenets to follow:

- Understand everything you turn-in. If you can't explain a line, don't hand it in.
- Verify LLM output, don't just blindly trust it. These tools can be confidently wrong. Run it, test it,
  and check it.
- Disclose any AI use by providing a sentence noting when and how you used it.
- In a foundations course, the whole point is that *you* can
  do these things. Feel free to use AI to aid learning, but do not skip the part where you build your skills. If you do, you're no more valuable than my ten-year old cousin with ChatGPT access.

## Before Next Week

- Complete **Homework 0** before our next session. This is an ungraded homework (hence, the "0") but is required for you to follow along in future lectures.
