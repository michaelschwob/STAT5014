# Homework 0 — Setting Up

There's no formal submission for this assignment. While it is ungraded, everything in Parts 1–3
should be done before Week 2.

*Note: hashtags inside code blocks are comments, not commands.*

---

## Part 1: GitHub Account

1. Create a GitHub account (<https://github.com/>).
2. Browse the materials on the class repository: `michaelschwob/STAT5014`.

---

## Part 2: Local Git Setup

1. After installing Git, confirm it works by typing `git` in your
   terminal. You should see usage help.
2. Create an SSH key pair by running `ssh-keygen` (accept the defaults). This creates a
   private and a public key in a `.ssh` folder in your home directory. Note that `.ssh` is a hidden directory that you'll need to reveal.
3. Copy your **public** key to your clipboard; never share the private one (unless a Nigerian prince asks)! Open it with
   `vim ~/.ssh/id_rsa.pub` (or `~/.ssh/id_ed25519.pub`), then select and copy the text.
4. Add the public key to GitHub: click your profile picture → **Settings** → **SSH and GPG
   keys** → **New SSH key** → paste it in → give it a name that identifies the machine
   (e.g. "personal laptop") → **Add SSH key**. Repeat for any other computers you use.
5. Configure your identity:
   ```
   git config --global user.email "YourGitHubEmail@example.com"
   git config --global user.name  "Your GitHub Username"
   ```
   Then, set line-ending handling:
   ```
   ## Windows:
   git config --global core.autocrlf true
   ## macOS:
   git config --global core.autocrlf input
   ```
6. Clone our class repository:
   ```
   git clone <course repo SSH URL>
   ```
   You can get the exact URL from the green **"< > Code"** button on the repo's home page (choose
   the SSH option). You may be prompted to "continue connecting." I promise it's not a virus.

---

## Part 3: Your Personal Repository

1. On GitHub, create your own repository (green **"New"** button). Name it
   `STAT5014-lastname` (using your own last name), and set its visibility to **Private**. You can leave the other settings as default for now.
2. Clone it using the SSH link in the blue "Quick setup" box (ignore the empty repository warning), add a `README.md` containing your full name, then commit and push. There are
   many ways to do this; I recommend the command line:
   ```
   cd STAT5014-lastname   # move into your repo
   vim README.md          # create/open the file
   ## press "i" to enter "insert" mode, which means you can type
   ## then press "esc" to enter "Normal" mode and type ":wq" to save and quit
   git add README.md           # don't worry about what this does... yet
   git commit -m "add README"  # don't worry about what this does... yet
   git push                    # don't worry about what this does... yet
   ```
   Refresh your GitHub repository online to see a non-empty repository!
3. Add me as a collaborator: on your repo page, follow **Settings** → **Collaborators** →
   **Add people** → add `michaelschwob`.

---

## Resources

- Generating an SSH key:
  <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>
- Adding a key to GitHub:
  <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>
