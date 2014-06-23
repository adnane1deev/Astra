#Configuration

1. System	: /etc/gitconfig
2. Global	: ~/.gitconfig
2. Local	: .git/config
	
**Globally :**
	git config --global user.name "username"
	git config --global user.email "user email"
	
**Locally :**
	git config user.name "username"
	git config user.email "user email"

	git config --global color.ui true
	
#Initializing

	git init
	
#Status - add

	git status
	git add README

#Commit

	git commit
	
	stage the changes from the files that have previously staged
	git commit -a 
	
	git commit -m "Commit message"
	
	git commit -am "Commit message"
	
#Ignore

Create .gitignore file, in each line of this file I just list a file or folder that I want git to ignore

#Diff

compare file in the current state with the last committed 
	git diff <file>
	
compare what's in the staging directory with our latest commit look like
	git diff --staged <file>
	or
	git diff --cached <file>

getting a comparison between what's in the working directory and the <file> and HEAD version of <file> or basically the last version of <file> that we committed 
	git diff HEAD <file>
	
	git diff
	git diff HEAD

#Log
Log is a tool to view the history of all our commits 
```
git log
git log --stat
git log --oneline
git log --graph
git log --graph --oneline
git log --graph --oneline --decorate
git log --pretty="%variables"
```
Graphical interface
```
gitk
```

#Branch
Branch is useful if you want to miss around with your code experimenting or developing a new feature and you're afraid of accidentally break you code functionality.

```
git branch
git branch <branch-name>
```

Switch to the new branch
```
git checkout <branch-name>
```

Create a new branch and switch to it
```
git checkout -b <branch-name>
```
