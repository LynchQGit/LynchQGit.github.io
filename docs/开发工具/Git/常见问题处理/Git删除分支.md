## Git 删除分支

在 Git 中，删除本地分支和远程分支的命令是不同的。以下是如何在命令行中执行这两个操作的步骤:
### 删除本地分支
```shell
git branch -d branch_name
```
这里的 `branch_name` 是你要删除的分支的名称。如果分支没有被合并，Git 会给出一个警告。如果你确定要删除该分支，可以使用 `-D` 选项强制删除该分支:
```shell
git branch -D branch_name
```

### 删除远程分支
要删除远程分支，你需要使用 `git push` 命令，后面跟上远程名称（通常是 origin）和要删除的分支名称，前面加上冒号:
```shell
git push origin --delete branch_name
```
或者，你可以使用旧的语法，以下命令:
```shell
git push origin :branch_name
```
