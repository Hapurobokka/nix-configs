module "extern nb" {
    def available-notebooks [] {
        (ls ~/.nb |
            where type == dir |
            get name |
            path basename |
            where { not ($in | str starts-with ".") })
    }

    # Command line utility for note-taking
    export extern nb [comm?: string]

    # Switch to the specified notebook
    export extern "nb use" [
        notebook: string@available-notebooks # The notebook to switch
    ]

    # Create a new note or folder
    #
    # If no arguments are passed, a new blank note file is opened with $EDITOR.
    # If a non-option argument is passed, `nb` will treat it as a <filename> if
    # a file extension is found. If no file extension is found, `nb` will
    # treat the string as <content> and will create a note without opening the
    # editor. `nb add` can also create a new note with piped content.
    #
    # `nb` creates Markdown files by default. To create a note with a
    # different file type, use the extension in the filename or use the `--type`
    # option. To change the default file type, use `nb set default_extension`.
    #
    # When the `-e` / `--encrypt` option is used, `nb` will encrypt the
    # note with AES-256 using OpenSSL by default, or GPG, if configured in
    # `nb set encryption_tool`.
    export extern "nb add" [
        text?: string
        --browse (-b) # See the file in the $BROWSER
        --content (-c): string # The content of the note
        --edit # Open the note in the $EDITOR
        --encrypt (-e) # Encrypt the note
        --filename (-f): string # The note's name
        --folder: string # The folder where the file will go
        --tags: string # A list of tags
        --template: string # A file template
        --title (-t): string # The note's title
        --type: string # The note's filetype
    ]

    # Show an item or notebook. Notes in text file formats can be rendered or
    # printed to standard output. Non-text files are opened in your system's
    # preferred app or program for that file type.
    #
    # By default, the item is opened using `less` or the program configured
    # in the `$PAGER` environment variable.
    #
    # `-r` / `--render` automatically uses either `w3m` [2] or `links` [3].
    # To specify a preferred browser, set the `$BROWSER` environment variable
    # in your .bashrc, .zshrc, or equivalent, e.g.: export BROWSER="links"
    #
    # If `bat` [5], `highlight` [6], or Pygments [7] is installed, notes are
    # printed with syntax highlighting.
    export extern "nb show" [
        note
        --added (-a) # Print the date and time when the item was added.
        --authors # List the git commit authors of an item.
        --browse (-b) # Open the item with `nb browse`.
        --filename # Print the filename of the item.
        --id # Print the id number of the item.
        --info-line # Print the id, filename, and title of the item.
        --no-color # Show without syntax highlighting.
        --path # Print the full path of the item.
        --print # Print to standard output / terminal.
        --relative-path # Print the item's path relative within the notebook.
        --render (-r) # Use `pandoc` [1] to render the file to HTML and display in the terminal web browser. If either `pandoc` or a browser are unavailable, `-r` / `--render` is ignored. Print the title of the note.
        --title # Print the title of the note.
        --type: string # Print the file extension or, when <type> is specified, return true if the item matches <type>. <type> can be a file extension or one of the following types: archive, audio, bookmark, document, folder, image, text, video
        --updated (-u) # Print the date and time of the last recorded change.
    ]

    # List notes in the current notebook.
    #
    # When <id>, <filename>, <path>, or <title> are present, the listing for the
    # matching note is displayed. When no match is found, titles and filenames
    # are searched for any that match <query> as a case-insensitive regular
    # expression.
    export extern "nb list" [
        --excerpt (-e): int = 3 # Print an excerpt <length> lines long under each note's filename [default: 3].
        --filenames # Print the filename for each note.
        --folders-first (-f) # Print folders before other items.
        --limit (-n): int # The maximum number of notes to list.
        --no-id # Don't include the id in list items.
        --no-indicator # Don't include the indicator in list items.
        --page (-p): int # The page to view in the list paginated by a <limit> option or `nb set limit`.
        --pager # Display output in the pager.
        --paths # Print the full path to each item.
        --sort (-s) # Order notes by id.
        --reverse (-r) # List items in reverse order.
        --tags # List tags in the notebook or folder.
        --type (-t): string # List items of <type>. <type> can be a file extension or one of the following types: archive, audio, book, bookmark, document, folder, image, note, text, video
    ]


    # Manage todos and tasks. By default only lists todos.
    export extern "nb todo" [ ]

    # Add a new todo
    export extern "nb todo add" [
        note_url: string # <notebook>:<folder-path>/<filename> <title>
        --description: string # Description for the todo.
        --due: string # Due date and / or time for the todo.
        --pager # Display output in the pager.
        --related (-r): string # Related URL or selector.
        --tags: string # Comma-separated list of tags.
        --task: string # Task to add to the tasklist.
    ]

    # Delete a todo
    export extern "nb todo delete" [
        note_url : string, # <notebook>:<folder-path>/(<id> | <filename> | <description>)
    ]

    # Mark a todo or task as done
    export extern "nb todo do" [
        note_url: string, # <notebook>:<folder-path>/(<id> | <filename> | <description>)
        task_number: int
    ]

    # List tasks in todos, notebooks, folders, and other item.
    export extern "nb todo tasks" [
        note_url: string, # <notebook>:<folder-path>/
        status?: string # Only "open" or "closed"
        --pager # Display output in the pager.
        --tags: string # Comma-separated list of tags.
    ]

    # Unmark a todo or task as done
    export extern "nb todo undo" [
        note_url: string, # <notebook>:<folder-path>/(<id> | <filename> | <description>)
        task_number: int
    ]

    export alias "nb +" = nb add
    export alias "nb ls" = nb list
    export alias "nb todo a" = nb todo add
    export alias "nb todo +" = nb todo add
    export alias "nb todo -" = nb todo delete

}

# MATCH (a:User)-[:RELATION {type: "Mejor amigo"}]->(b:User),
# (b)-[:RELATION {type: "Mejor amigo"}]->(a)
# RETURN a,b

use "extern nb" *
