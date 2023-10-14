## Tmux

[[tmux/capture]]

## Git Worktrees

```sh
git worktree add <path> <branch>    # current branch if not specified
git worktree list                   # list worktrees and branches associated
git worktree remove <worktree>      # remove worktree (just the folder, not the branch)
git worktree add <path> -b <branch> # create a new branch
git worktree prune                  # Clean worktrees whose branch is no more
```

Starship support for worktrees? Doesn't seem like so

### Init

```sh
gh repo clone rubiconmd/rubicon .bare -- --bare
echo "gitdir: ./.bare" > .git
```

### Debugging

```sh
git rev-parse --is-inside-work-tree
git rev-parse --absolute-git-dir
```
