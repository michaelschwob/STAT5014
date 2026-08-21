# STAT 5014 — Lecture 2: Git & GitHub

## Why Version Control?

Because naming a file `paper_final_v2_ACTUALLY_final_revised.tex` is not good enough.

**Git** is a version control system and **GitHub** is an online platform that hosts Git
repositories (**GitLab** and **Bitbucket** are alternatives if you want to be a rebel). So, Git is the tool, and GitHub is
where your work lives online.

Knowing Git and GitHub helps with:

- Saving your work: you get a full, timestamped history that you can roll back to.
- Capturing the research process: you can see exactly what changed and when.
- Working across machines: you can include remote workstations and computing clusters (e.g., ARC).
- Reproducibility: you get the source that produced a result.
- Collaboration and publication: this is the standard way that code gets shared (within statistics at least).

## The Four Places Your Work Lives

Almost every confusing thing about Git goes away once you know that your work sits in one
of four places, and that each of the following command moves between them:

```
 working directory        staging area          local repository        remote (GitHub)
 (your actual files)      (the next commit)     (your full history)     (public copy)
        |                       |                       |                       |
        |------ git add ------->|                       |                       |
        |                       |----- git commit ----->|                       |
        |                       |                       |------ git push ------>|
        |<---------------------------- git pull --------------------------------|
```

- The **working directory** is the folder that you actually edit in on your local machine. When you save a file here, Git
  notices but does nothing about it.
- The **staging area** (or "index") contains what goes into your next snapshot.
  It exists so that you can commit *some* of your changes and not others; your choice.
- The **local repository** is the hidden `.git` folder that contains your committed history. It's
  on your machine, so it works without WiFi.
- The **remote** is your copy on GitHub. If you're collaborating, every teammate has their own
  working directory, staging area, and local repository, but everyone syncs through this one remote repository.

You can use `git status` to see which location you're currently at in your workflow.

## Starting a Repository

There are two ways to initialize a repository:

- **`git clone <URL>`**: copy an existing repo (from GitHub) onto your machine; this is what
  you should've done in Homework 0.
- **`git init`**: turn the folder you're currently in into a brand-new repo. Then, you can create
  an empty repo on GitHub and connect the two:
  ```
  git init
  git remote add origin git@github.com:USERNAME/REPONAME.git
  git push -u origin main
  ```

A **remote** is just a nickname for a URL. `origin` is the conventional name for "the place
I cloned from." You can see yours with:

```
git remote -v
```

Git commands only work from within a repository folder. If you run a Git command from outside a repo, you'll get `fatal: not a git repository`. That
error means "you're in the wrong folder"; use `pwd` and `ls` to figure out where you are.

## The Everyday Workflow

There's a lot that Git *can* do, but these five commands are the essentials; you could get
through all of graduate school on them alone. The rhythm is **pull → work → add → commit →
push**, coincidentally the name of a Vanilla Ice song.

- **`git pull`**: pull down any changes from the remote. Run this every time you sit down to
  work. If you're the only person in a repo, it feels unnecessary, but build the habit now
  because it's what prevents painful conflicts later. Trust me.
- **`git status`**: your best friend, and unlike your other friends, it's always available.
  It shows where your local work stands relative to the remote: what's changed, what's
  staged, and whether you're ahead or behind. When in doubt, `git status`.
- **`git add FILENAME`**: stage a changed file so that it's included in your next commit. You
  can stage a whole folder with `git add FOLDERNAME/`, but check for hidden files first. I
  don't recommend `git add -A`, which stages *everything* (including the 14GB dataset you
  forgot was in there).
- **`git commit -m "message"`**: bundle your staged changes into a snapshot with a message
  describing what you did. Be descriptive! "changed n from 25 to 50 for satellite simulation"
  will save you in six months; "new n" will not.
- **`git push`**: send your committed snapshots up to the remote. Afterward, GitHub should
  show your commit and your files.

### Commits Should Do One Thing

A commit is something that you might one day want to undo, so it should be about **one**
thing. A commit labeled "fixed bug, added figure, renamed everything, and tried to install
TensorFlow" is a commit you can never cleanly revert, because reverting the bug fix would
also take the figure with it.

This is why the staging area exists. If you changed three files but only two of them
belong to the same idea, stage those two, commit them, then stage and commit the third
separately.

## Looking Around

- **`git log`**: the commit history (press `q` to exit). `git log --oneline` is the readable
  version, and `git log --oneline --graph --all` draws the branch structure.
- **`git diff`**: the exact line-by-line changes you've made but haven't staged yet. This is
  Git's superpower on text files. `git diff --staged` shows what you *have* staged, which is
  worth a look right before you commit.
- **`git show HASH`**: everything that happened in one specific commit.
- **`git blame FILE`**: who last changed each line, and in which commit. It's less accusatory
  than it sounds and it's invaluable on inherited research code, where the question is
  usually "why on earth is this line here?"

Commits are identified by a **hash**, an ugly string like `a3f9c21`. You only ever need the
first seven characters or so.

## Undoing Things

Git's reputation for being terrifying is almost entirely about this section. The good news:
if you have committed your work, it is very hard to truly lose it. The bad news is in the
last two rows of this table.

| I want to... | Command |
|:---|:---|
| discard my changes to a file I haven't staged | `git restore FILE` |
| unstage a file I added but haven't committed | `git restore --staged FILE` |
| fix the message on my last commit (not pushed) | `git commit --amend -m "better message"` |
| undo a commit that I already pushed | `git revert HASH` |
| move my last commit back to the staging area | `git reset --soft HEAD~1` |
| throw away my last commit *and its changes* | `git reset --hard HEAD~1` |
| find a commit I think I lost | `git reflog` |

Three things worth remembering:

- `git revert` is the safe one. It doesn't erase history; it makes a *new* commit that
  undoes an old one. This is what you want for anything you've already pushed because
  rewriting shared history is how you make enemies.
- `git reset --hard` is the `rm` of version control. It is the one command here that can
  actually destroy work because it throws away your uncommitted changes without asking. Be careful!
- `git reflog` is a time machine. It logs every place your branch has pointed, including
  commits you thought you deleted. If you think you've lost work, look here before you panic.

## Best Practices

- **Push frequently**: you only reap the benefits of version control if you commit and push
  regularly. Don't go more than a couple hours of work without pushing. Your history should reflect the
  work you actually did.
- **File names**: please no spaces (they make terminal navigation painful) and no stray periods
  (reserve those for extensions). Use `underscores` and `dashes`.
- **File types**: Git is built for text-based files (`.R`, `.qmd`, `.tex`, `.txt`, `.csv`,
  `.py`, `.sh`), where it can track and display differences. Be deliberate about what you
  push:
  - If a file can be generated by compiling source, push the source and not the output. Push
    your `.qmd`/`.tex`, not the rendered `.html`/`.pdf`, and push the code that makes a
    figure, not the figure. The exception is when a figure is an *input* needed to compile
    something else (like an image in a paper), in which case it must be pushed.
  - Prefer `.csv`/`.txt`/`.dat` for results over binary formats. Avoid `.xlsx`; Git can't see
    inside Excel's extra machinery. Also, it's Excel...
  - Try to keep local junk files out. `.Rhistory`, `.RData`, and `.DS_Store` do not belong on the remote.
- **Documentation**: use `README.md` files (in the home directory and in any substantial
  folder) to explain what things do.
- **Structure**: organize with folders. If one folder has 20+ files, consider if it's worth breaking up.

### Large Files

Git was built for source code, not for your 8GB simulation output. It will happily let you
commit that file... and then it will never let you forget it, because the blob lives in the
history forever even after you delete it. GitHub warns you above 50MB and rejects files above
100MB (unless you have an Enterprise account).

If you really need to push large data files, look at **Git LFS**. But generally, the right answer is: don't
commit the data. Commit the script that generates or downloads it, and `.gitignore` the
output.

## .gitignore?

To avoid pushing files that don't belong, list their names or extensions in a `.gitignore`
file at the top of your repo, and Git will ignore them automatically. A good starting point
for our stack:

```
## rendered output
*.html

## LaTeX build files
*.aux
*.log
*.out
*.toc
*.bbl
*.blg
*.synctex.gz

## OS/editor junk
.DS_Store

## R
.Rhistory
.RData
.Rproj.user/

## Python
__pycache__/
*.pyc
.ipynb_checkpoints/

## example data that is too big for Git
data/raw/*.nc
```

A few notes: entries start at the repo root, `*` is a wildcard, a trailing `/`
means "directory", and a leading `!` un-ignores something (`*.pdf` ignores all PDFs, then `!figures/*.pdf` allows PDFs if they're in the figures directory).

Importantly, `.gitignore` only applies to files Git isn't already tracking. If you've
already committed `main.pdf`, adding it to `.gitignore` does nothing; you have to
`git rm --cached main.pdf` first.

We'll explore `.gitignore` further throughout the semester. You can also start from any of these templates:
<https://github.com/github/gitignore>.

## Branches

A **branch** is a movable label that points at a commit. It essentially lets you work on something without disturbing the main
line of development. Your default branch is `main`.

```
git branch                    # list branches; * marks where you are
git checkout -b try-new-prior # create the branch "try-new-prior" and switch to it
## ... work, add, commit ...
git checkout main             # switch back to the "main" branch
git merge try-new-prior       # bring the work into main
git branch -d try-new-prior   # delete the branch "try-new-prior" once merged
```

(`git switch` and `git switch -c` are the newer, clearer names for the `checkout` versions.
Both work.)

Use a branch whenever you're trying something that might not pan out, which in research is
quite frequent. If your idea fails, delete the branch and `main` will never know. And hopefully, your advisor doesn't either.

## Merge Conflicts

A conflict happens when two changes touch the same lines and Git can't decide which to keep.
Git is not angry with you; it is just refusing to make a judgment call that it isn't qualified to make. If only AI was as principled...

When conflicts happen, Git edits the file to show you both versions:

```
<<<<<<< HEAD
sigma <- sd(x)
=======
sigma <- sqrt(var(x))
>>>>>>> try-new-prior
```

Everything between `<<<<<<< HEAD` and `=======` is in the current version, and everything between
`=======` and `>>>>>>>` is in the incoming version. To resolve it:

1. Open the file and decide what the correct final text is. You may keep either side, both,
   or something new.
2. Delete all three marker lines.
3. `git add FILE` and then `git commit`.

The best defense to conflicts: pull before you work, keep commits small, and
don't edit the same file at the same time as somebody else. For a fun, free, visual approach to learning branching, see
[Learn Git Branching](https://learngitbranching.js.org/).

## Collaborating on GitHub

Here are a few GitHub features that make collaborating a bit easier:

- A **fork** is your own copy of somebody else's repository, living under your account. This
  is how you play around with someone's R package without having "write access" to it.
- A **pull request** (PR) proposes that your branch (or your fork) be merged into their repo.
  It opens a page where people can review the diff, comment on lines, and discuss before
  anything is merged. Fixing a typo in a package's documentation via PR is a genuinely nice
  first contribution to open source, and a surprisingly effective way to meet people in your
  field.
- **Issues** are the bug tracker and to-do list. Even solo, opening issues on your own repo is
  a good way to remember what past-you was worried about.

## Stashing

`git stash` shoves your uncommitted changes onto a shelf and gives you back a clean working
directory. It's perfect for when your advisor asks to see the version from before you broke
everything.

```
git stash        # put changes aside
git stash pop    # bring them back
git stash list   # see what's on the shelf
```

## Using AI Well with Git

Git syntax is an acceptable thing to ask an AI assistant about: "how do I undo my last commit?" However, I want to provide two cautions. First, verify anything destructive *before* you run it because
`git reset --hard`, `git push --force`, and `rm -rf` can lose work permanently. Second, make sure you can explain what a suggested command does.
Running `git status` before and after an unfamiliar command is a cheap safety check.

## Before Next Week

- Finish **Homework 0** if you haven't already. You'll need a working repo for every future
  assignment.
- Install **R**, **RStudio**, and **TinyTeX** (see the HW0 checklist). We start LaTeX next
  week and will compile locally.
