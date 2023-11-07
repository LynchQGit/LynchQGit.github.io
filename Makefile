push:
	git add -A
	git config --local user.name "LynchQGit"
	git config --local user.email "hlq_git@163.com"
	git commit -m 'update site at $(shell date +%Y%m%d-%H%M%S), machine $(shell hostname)'
	git pull --rebase
	git push --set-upstream origin HEAD