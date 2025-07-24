function ghrepo --description 'Create a GitHub repository for the current local git repo'
    # Check if current directory is a git repository
    if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
        echo "Error: Current directory is not a git repository. Please initialize git first with 'git init'."
        return 1
    end

    # Determine repository name
    if test (count $argv) -gt 0
        set repo_name $argv[1]
    else
        set repo_name (basename (pwd))
    end

    # Convert repository name to kebab-case using slugify
    set repo_slug (slugify $repo_name)

    # Prompt for repository visibility
    echo "Repository name will be: $repo_slug"
    echo "Choose repository visibility:"
    echo "1) Private"
    echo "2) Public"

    while true
        read -P "Enter your choice (1 or 2): " choice

        switch $choice
            case 1
                set visibility "private"
                break
            case 2
                set visibility "public"
                break
            case '*'
                echo "Invalid choice. Please enter 1 for private or 2 for public."
        end
    end

    echo "Creating $visibility repository: $repo_slug"

    # Create the GitHub repository
    # Using --source=. to use current directory as source
    # Using --remote=origin to set up the remote
    # Using --push to push the current branch
    # Using --clone=false since we're already in the repo
    if test $visibility = "private"
        set vis_flag "--private"
    else
        set vis_flag "--public"
    end

    # Create the repository
    if gh repo create $repo_slug $vis_flag --source=. --remote=origin --push --clone=false
        echo "Successfully created GitHub repository: $repo_slug"
        echo "Repository URL: https://github.com/(gh api user --jq .login)/$repo_slug"

        # Verify SSH remote is set up correctly
        echo "Verifying remote configuration..."
        git remote -v
    else
        echo "Failed to create GitHub repository"
        return 1
    end
end
