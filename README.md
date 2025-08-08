# Dotfiles

Managed by [chezmoi](https://chezmoi.io/)

## Initialize

Run the following command to initialize chezmoi and install pre-requisites.
This will also apply a post-init root-source for chezmoi.

```shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply jake-carpenter
```

Once completed, follow instructions to apply the source changes and
re-initialize chezmoi. This will also trigger a second set of scripts
for required packages to ensure Fish can run with the saved configuration.

```shell
# macOS
source ~/.zshrc

# Linux
source ~/.bashrc

chezmoi init --apply
```

At this point, you should be able to run Fish.
