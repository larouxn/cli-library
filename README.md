# CLI Library
Persistent, command line based, library management software. Add, remove, mark as read, set a bookmark, and see what books you own, all from the command line.

CLI Library automatically sets up/loads and saves your library when you run and quit it, respectively.

Usage `ruby library.rb`

Commands:
- Add a book to your library with a given title and author. All books are unread and non-bookmarked by default.
        add "title" "author"
- Mark a book as read.
        read "title"
- Display all of the books in your library.
        show all
- Display all of the unread books in your library.
        show unread
- Shows all of the books in your library by the given author.
        show all by "author"
- Show the unread books in your library by the given author.
        show unread by "author"
- Place a bookmark in the specified book at the given page number.
        bookmark "title" "author" page_number
- Display this help information.
        help
- Quit the program.
        quit
