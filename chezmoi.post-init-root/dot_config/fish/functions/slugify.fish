function slugify
    # Convert a string to kebab-case (slug format)
    # Handles: dashes, underscores, camelCase, PascalCase
    
    # Join all arguments into a single string
    set input (string join " " $argv)
    
    # Step 1: Insert dashes before capital letters (for camelCase/PascalCase)
    # First handle lowercase followed by uppercase
    set result (echo $input | sed 's/\([a-z]\)\([A-Z]\)/\1-\2/g')
    # Then handle sequences of capitals followed by lowercase (like "XMLParser" -> "XML-Parser")
    set result (echo $result | sed 's/\([A-Z]\)\([A-Z][a-z]\)/\1-\2/g')
    
    # Step 2: Replace underscores with dashes
    set result (echo $result | tr '_' '-')
    
    # Step 3: Replace spaces with dashes
    set result (echo $result | tr ' ' '-')
    
    # Step 4: Convert to lowercase
    set result (echo $result | tr '[:upper:]' '[:lower:]')
    
    # Step 5: Remove any duplicate dashes and clean up
    set result (echo $result | sed 's/-\+/-/g')
    
    # Step 6: Remove leading/trailing dashes
    set result (echo $result | sed 's/^-\+//; s/-\+$//')
    
    echo $result
end
