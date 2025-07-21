# Dotfiles

Managed by [chezmoi](https://chezmoi.io/)

## Initialize

Run the following command to initialize chezmoi and install pre-requisites:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jake-carpenter
```

Once finished, apply the source root in `chezmoi.post-init-root` by creating the `.chezmoiroot` file:

```shell
echo "chezmoi.post-init-root" > .local/share/chezmoi/.chezmoiroot
```
