#Configuration

1. System	: /etc/gitconfig
2. Global	: ~/.gitconfig
2. Local	: .git/config
	
**Globally :**
```
git config --global user.name "username"
git config --global user.email "user email"
```
	
**Locally :**
```
git config user.name "username"
git config user.email "user email"

git config --global color.ui true
```
	
#Initializing
```
git init
```
	
#Status - add
```
git status
git add README
```

#Commit
```
git commit
```

stage the changes from the files that have previously staged
```
git commit -a 

git commit -m "Commit message"

git commit -am "Commit message"
```
	
#Ignore

Create .gitignore file, in each line of this file I just list a file or folder that I want git to ignore

#Diff

compare file in the current state with the last committed 
```
git diff <file>
```
	
compare what's in the staging directory with our latest commit look like
```
git diff --staged <file>
or
git diff --cached <file>
```

getting a comparison between what's in the working directory and the <file> and HEAD version of <file> or basically the last version of <file> that we committed 
```
git diff HEAD <file>

git diff
git diff HEAD

git diff <hash-1> <hash-2>
```

#Log
Log is a tool to view the history of all our commits 
```
git log
git log --stat
git log --oneline
git log --graph
git log --graph --oneline
git log --graph --oneline --decorate
git log --graph --oneline --decorate --all
git log --pretty="%variables"
```
Graphical interface
```
gitk
gitk --all
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

Delete branch
```
git branch -d <branch-name>
```

#Merge-Rebase
Merging the target branch with the master branch
```
git merge <target-branch-name>
```

Rebasing target branch to master branch for more linear graph
```
git rebase <target-branch-name>
```

#Github
```
https://help.github.com/articles/generating-ssh-keys
```

#Remotes - push - pull

Add remote to the project
```
git remote add <remote-name> <link>
```

to show the remote 
```
git remote
```

push content up to github
```
git push -u <remote-name> <branch-name>
```

pull changes down from github to our local repository
```
git pull
```

get the changes without merging them
```
git fetch
```

merge the changes to the master branch after looking at them
```
git merge <remote-name>/master
```

#Interactive add

```
git add -i
```

"git add -i" give us a interactive command prompt
```
1: status			- show paths with changes
2: update			- add working tree state to the staged set of changed
3: revert			- revert staged set of changes back to the HEAD version
4: add untracked	- add content of untracked files to the staged set of changes
5: patch			- pick hunks and update selectively
6: diff				- view diff between HEAD and index
7: quit
8: help
```

An alternative for of the patch option located in the interactive add command
```
git add -p
```

#Git-stash
hide the changes that had been made after the last commit
```
git stash
git stash save "stash message"
git stash list
```
Reapply the hidden changes from the stash
```
git stash apply
git stash apply stash@{N}
git stash pop stash@{N}
```
drop a stash
```
git stash drop - drop from the top
git stash drop stash@{N}
```