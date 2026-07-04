# =========================================================
# cheatsheet.zsh — funções de referência (vimfo/tmuxfo/macfo/zfo/keys)
# Depende das variáveis de cor definidas em exports.zsh
# =========================================================

vimfo() {
    echo ""
    echo -e "${BLUE}Vim Cheatsheet - Editing Essentials${RESET}\n"
    echo -e "${MAGENTA}Leader Key: Space${RESET}\n"

    echo -e "${ORANGE}Save & Quit:${RESET}"
    echo -e "${MAGENTA}Space w     ${RESET}- Save file"
    echo -e "${MAGENTA}Space q     ${RESET}- Quit"
    echo -e "${MAGENTA}Space x     ${RESET}- Save and quit"
    echo -e "${MAGENTA}:wq         ${RESET}- Save and quit (alternative)"
    echo -e "${MAGENTA}:q!         ${RESET}- Quit without saving"
    echo

    echo -e "${ORANGE}Movement:${RESET}"
    echo -e "${MAGENTA}h j k l     ${RESET}- Left, Down, Up, Right"
    echo -e "${MAGENTA}w           ${RESET}- Next word"
    echo -e "${MAGENTA}b           ${RESET}- Previous word"
    echo -e "${MAGENTA}0           ${RESET}- Start of line"
    echo -e "${MAGENTA}\$           ${RESET}- End of line"
    echo -e "${MAGENTA}gg          ${RESET}- Top of file"
    echo -e "${MAGENTA}G           ${RESET}- Bottom of file"
    echo -e "${MAGENTA}:<number>   ${RESET}- Go to line number (e.g., :42)"
    echo -e "${MAGENTA}Ctrl d      ${RESET}- Page down"
    echo -e "${MAGENTA}Ctrl u      ${RESET}- Page up"
    echo

    echo -e "${ORANGE}Insert & Edit:${RESET}"
    echo -e "${MAGENTA}i           ${RESET}- Insert before cursor"
    echo -e "${MAGENTA}a           ${RESET}- Insert after cursor"
    echo -e "${MAGENTA}o           ${RESET}- New line below"
    echo -e "${MAGENTA}O           ${RESET}- New line above"
    echo -e "${MAGENTA}x           ${RESET}- Delete character"
    echo -e "${MAGENTA}dd          ${RESET}- Delete line"
    echo -e "${MAGENTA}yy          ${RESET}- Copy line"
    echo -e "${MAGENTA}p           ${RESET}- Paste"
    echo -e "${MAGENTA}u           ${RESET}- Undo"
    echo -e "${MAGENTA}Ctrl r      ${RESET}- Redo"
    echo -e "${MAGENTA}.           ${RESET}- Repeat last command"
    echo -e "${MAGENTA}gcc         ${RESET}- Comment/uncomment line"
    echo

    echo -e "${ORANGE}Visual Mode:${RESET}"
    echo -e "${MAGENTA}v           ${RESET}- Character select"
    echo -e "${MAGENTA}V           ${RESET}- Line select"
    echo -e "${MAGENTA}Ctrl v      ${RESET}- Block select"
    echo -e "${YELLOW}In visual mode:${RESET}"
    echo -e "${MAGENTA}>           ${RESET}- Indent right"
    echo -e "${MAGENTA}<           ${RESET}- Indent left"
    echo -e "${MAGENTA}J           ${RESET}- Move lines down"
    echo -e "${MAGENTA}K           ${RESET}- Move lines up"
    echo -e "${MAGENTA}gc          ${RESET}- Comment selection"
    echo -e "${MAGENTA}y           ${RESET}- Copy"
    echo -e "${MAGENTA}d           ${RESET}- Delete"
    echo

    echo -e "${ORANGE}Search & Replace:${RESET}"
    echo -e "${MAGENTA}/pattern    ${RESET}- Search forward"
    echo -e "${MAGENTA}n           ${RESET}- Next match"
    echo -e "${MAGENTA}N           ${RESET}- Previous match"
    echo -e "${MAGENTA}Space /     ${RESET}- Clear search highlights"
    echo -e "${MAGENTA}*           ${RESET}- Search word under cursor"
    echo -e "${MAGENTA}:%s/old/new/g    ${RESET}- Replace all in file"
    echo -e "${MAGENTA}:%s/old/new/gc   ${RESET}- Replace with confirmation"
    echo

    echo -e "${ORANGE}Mouse:${RESET}"
    echo -e "${MAGENTA}Click       ${RESET}- Position cursor"
    echo -e "${MAGENTA}Drag select ${RESET}- Auto-copy to clipboard"
    echo -e "${MAGENTA}Scroll      ${RESET}- Scroll up/down"
    echo

    echo -e "${ORANGE}Splits (Optional):${RESET}"
    echo -e "${MAGENTA}:sp <file>  ${RESET}- Horizontal split"
    echo -e "${MAGENTA}:vsp <file> ${RESET}- Vertical split"
    echo -e "${MAGENTA}Ctrl h/j/k/l${RESET}- Navigate between splits"
    echo -e "${MAGENTA}Ctrl w c    ${RESET}- Close split"
    echo

    echo -e "${ORANGE}Linting (ALE):${RESET}"
    echo -e "${MAGENTA}]e          ${RESET}- Next error/warning"
    echo -e "${MAGENTA}[e          ${RESET}- Previous error/warning"
    echo -e "${YELLOW}Auto-fixes on save${RESET}"
    echo

    echo -e "${ORANGE}Git (Optional):${RESET}"
    echo -e "${MAGENTA}:Git status ${RESET}- Show git status"
    echo -e "${MAGENTA}:Git diff   ${RESET}- Show changes"
    echo -e "${MAGENTA}:Git add %  ${RESET}- Stage current file"
    echo -e "${MAGENTA}:Git commit ${RESET}- Commit"
    echo -e "${MAGENTA}]c / [c     ${RESET}- Jump to next/prev git change"
    echo

    echo -e "${ORANGE}Useful Commands:${RESET}"
    echo -e "${MAGENTA}Space ve    ${RESET}- Edit vimrc"
    echo -e "${MAGENTA}Space vr    ${RESET}- Reload vimrc"
    echo -e "${MAGENTA}:help <topic>${RESET}- Get help"
    echo -e "${MAGENTA}Ctrl z      ${RESET}- Suspend Vim (fg to return)"
    echo
}

# Tmux help
tmuxfo() {
    echo ""
    echo -e "${BLUE}Tmux Cheatsheet${RESET}\n"
    echo -e "${MAGENTA}Ctrl a${RESET}                  - Leader key"
    echo

    echo -e "${ORANGE}Session management${RESET}"
    echo -e "${MAGENTA}tmux new -s <n>${RESET} or ${MAGENTA}tn${RESET}                   - Create new session"
    echo -e "${MAGENTA}tmux new-session -A -s <n>${RESET} or ${MAGENTA}tns${RESET}       - Create session if not exists or attach"
    echo -e "${MAGENTA}tmux ls${RESET} or ${MAGENTA}tl${RESET}                             - List sessions"
    echo -e "${MAGENTA}tmux attach -t <n>${RESET} or ${MAGENTA}ta${RESET}                - Attach to session"
    echo -e "${MAGENTA}tmux switch -t <n>${RESET} or ${MAGENTA}ts${RESET}                - Switch to another session"
    echo -e "${MAGENTA}tmux rename-session -t <old> <new>${RESET} or ${MAGENTA}tres${RESET}  - Rename session"
    echo -e "${MAGENTA}tmux kill-session -t <n>${RESET} or ${MAGENTA}tks${RESET}         - Kill session"
    echo -e "${MAGENTA}tmux kill-server${RESET} or ${MAGENTA}tkss${RESET}                   - Kill tmux server"
    echo -e "${MAGENTA}Ctrl a \$${RESET}                  - Rename current session"
    echo -e "${MAGENTA}Ctrl a d${RESET}                  - Detach from session"
    echo -e "${MAGENTA}Ctrl a s${RESET}                  - List and select sessions"
    echo -e "${MAGENTA}Ctrl a Ctrl t${RESET}             - Choose session from tree"
    echo

    echo -e "${ORANGE}Window management${RESET}"
    echo -e "${MAGENTA}Ctrl a c${RESET}                  - Create new window"
    echo -e "${MAGENTA}Ctrl a x${RESET}                  - Close current window"
    echo -e "${MAGENTA}Ctrl a n${RESET} or ${MAGENTA}Alt n${RESET}         - Next window"
    echo -e "${MAGENTA}Ctrl a p${RESET} or ${MAGENTA}Alt p${RESET}         - Previous window"
    echo -e "${MAGENTA}Ctrl a w${RESET}                  - List windows"
    echo -e "${MAGENTA}Ctrl a ,${RESET} or ${MAGENTA}trew${RESET}          - Rename current window"
    echo -e "${MAGENTA}Ctrl a m${RESET}             - Move window to specific index"
    echo -e "${MAGENTA}Alt 1-5${RESET}                 - Jump to window <1-9>"
    echo -e "${MAGENTA}tmux list-windows${RESET} or ${MAGENTA}tw${RESET}   - List windows"
    echo

    echo -e "${ORANGE}Pane creation and layout${RESET}"
    echo -e "${MAGENTA}Ctrl a |${RESET} or ${MAGENTA}Alt \\\\${RESET}         - Split vertically"
    echo -e "${MAGENTA}Ctrl a -${RESET} or ${MAGENTA}Alt -${RESET}         - Split horizontally"
    echo -e "${MAGENTA}Ctrl a space${RESET}              - Cycle through layouts"
    echo -e "${MAGENTA}Ctrl a =${RESET}                  - Equalize pane sizes"
    echo -e "${MAGENTA}Alt left/right/up/down arrow${RESET} - Move between panes"
    echo -e "${MAGENTA}Alt Shift H${RESET}                  - Swap pane with previous"
    echo -e "${MAGENTA}Alt Shift L${RESET}                  - Swap pane with next"
    echo

    echo -e "${ORANGE}Pane navigation${RESET}"
    echo -e "${MAGENTA}Alt left/right/up/down arrow${RESET} - Move between panes"
    echo -e "${MAGENTA}Ctrl a q${RESET}                     - Show pane numbers (press number to select)"
    echo -e "${MAGENTA}Ctrl a z${RESET}                     - Toggle pane zoom (fullscreen)"
    echo -e "${MAGENTA}Ctrl a {${RESET}                     - Swap pane with previous"
    echo -e "${MAGENTA}Ctrl a }${RESET}                     - Swap pane with next"
    echo -e "${MAGENTA}Ctrl a Ctrl s${RESET}                - Synchronize panes (send input to all panes)"
    echo

    echo -e "${ORANGE}Pane resizing${RESET}"
    echo -e "${MAGENTA}Alt Shift left arrow${RESET}      - Decrease width by 5"
    echo -e "${MAGENTA}Alt Shift right arrow${RESET}     - Increase width by 5"
    echo -e "${MAGENTA}Alt Shift down arrow${RESET}      - Decrease height by 2"
    echo -e "${MAGENTA}Alt Shift up arrow${RESET}        - Increase height by 2"
    echo

    echo -e "${ORANGE}Pane management${RESET}"
    echo -e "${MAGENTA}Ctrl a x${RESET}                  - Close current pane"
    echo -e "${MAGENTA}Ctrl a !${RESET}                  - Break pane into new window"
    echo

    echo -e "${ORANGE}Copy mode and clipboard${RESET}"
    echo -e "${MAGENTA}Ctrl a [${RESET}                  - Enter copy mode"
    echo -e "${MAGENTA}Ctrl c${RESET} or ${MAGENTA}q${RESET}               - Exit copy mode"
    echo -e "${MAGENTA}Space${RESET}                     - Start selection in copy mode"
    echo -e "${MAGENTA}Enter${RESET}                     - Copy selection in copy mode"
    echo -e "${MAGENTA}Ctrl a ]${RESET}                  - Paste copied text"
    echo -e "${MAGENTA}Shift + mouse drag${RESET}        - Highlight and copy text"
    echo -e "${MAGENTA}v${RESET}                         - Start selection in vi mode"
    echo -e "${MAGENTA}y${RESET}                         - Copy selection to system clipboard (tmux-yank)"
    echo -e "${MAGENTA}Y${RESET}                         - Copy current line to system clipboard (tmux-yank)"
    echo -e "${MAGENTA}Ctrl a y${RESET}                  - Copy current pane working directory"
    echo

    echo -e "${ORANGE}Configuration${RESET}"
    echo -e "${MAGENTA}Ctrl a r${RESET}                  - Reload tmux configuration file"
    echo -e "${MAGENTA}Ctrl a :${RESET}                  - Enter command mode"
    echo

    echo -e "${ORANGE}Plugin management - TPM${RESET}"
    echo -e "${MAGENTA}Ctrl a Ctrl I${RESET}             - Install plugins"
    echo -e "${MAGENTA}Ctrl a Ctrl u${RESET}             - Update plugins"
    echo -e "${MAGENTA}Ctrl a Alt u${RESET}              - Uninstall removed plugins"
    echo -e "${MAGENTA}Ctrl a S${RESET}             - Save tmux session (tmux-resurrect)"
    echo -e "${MAGENTA}Ctrl a Ctrl r${RESET}             - Restore tmux session (tmux-resurrect)"
    echo

    echo -e "${ORANGE}Advanced session commands${RESET}"
    echo -e "${MAGENTA}tmux new-session -d -s <n>${RESET}         - Start a detached session"
    echo -e "${MAGENTA}tmux select-layout tiled${RESET} or ${MAGENTA}tslt${RESET}      - Tile all panes"
    echo
}

macfo() {
    local section="${1:-all}"

    case "$section" in

    "nav"|"navigation"|"windows")
        echo ""
        echo -e "${BLUE}macOS — Navigation & Window Management${RESET}\n"
        echo -e "${ORANGE}App Switching:${RESET}"
        echo -e "${MAGENTA}Cmd Tab              ${RESET} — Switch between open apps"
        echo -e "${MAGENTA}Cmd Tab (hold Cmd)    ${RESET} — Hold and use arrows to pick app"
        echo -e "${MAGENTA}Cmd \`                ${RESET} — Switch windows of the same app"
        echo -e "${MAGENTA}Ctrl ↓               ${RESET} — Show all windows of current app (App Exposé)"
        echo ""
        echo -e "${ORANGE}Mission Control & Spaces:${RESET}"
        echo -e "${MAGENTA}Ctrl ↑               ${RESET} — Mission Control (all windows overview)"
        echo -e "${MAGENTA}Ctrl ← / →           ${RESET} — Switch between Desktops/Spaces"
        echo -e "${MAGENTA}F3                   ${RESET} — Mission Control (alternative)"
        echo ""
        echo -e "${ORANGE}Window Management:${RESET}"
        echo -e "${MAGENTA}Ctrl Cmd F            ${RESET} — Toggle fullscreen"
        echo -e "${MAGENTA}Cmd M                 ${RESET} — Minimize window to Dock"
        echo -e "${MAGENTA}Cmd H                 ${RESET} — Hide current app"
        echo -e "${MAGENTA}Cmd Option H          ${RESET} — Hide all other apps"
        echo -e "${MAGENTA}Cmd W                 ${RESET} — Close current window/tab"
        echo -e "${MAGENTA}Cmd Q                 ${RESET} — Quit app completely"
        echo -e "${MAGENTA}Cmd N                 ${RESET} — New window"
        echo -e "${MAGENTA}Cmd Option M          ${RESET} — Minimize all windows of current app"
        echo ""
        echo -e "${ORANGE}Window Tiling (macOS 15 Sequoia+):${RESET}"
        echo -e "${MAGENTA}Fn Ctrl ←             ${RESET} — Tile window to left half"
        echo -e "${MAGENTA}Fn Ctrl →             ${RESET} — Tile window to right half"
        echo -e "${MAGENTA}Fn Ctrl ↑             ${RESET} — Maximize window"
        echo -e "${MAGENTA}Fn Ctrl ↓             ${RESET} — Restore original size"
        echo -e "${CYAN}(Older macOS: hold Option over green button for tiling)${RESET}"
        echo
        ;;

    "system"|"sys")
        echo ""
        echo -e "${BLUE}macOS — System & Lock${RESET}\n"
        echo -e "${ORANGE}Lock & Sleep:${RESET}"
        echo -e "${MAGENTA}Ctrl Cmd Q            ${RESET} — Lock screen"
        echo -e "${MAGENTA}Cmd Option Eject      ${RESET} — Sleep (or Cmd Option Power on laptops)"
        echo -e "${MAGENTA}Ctrl Shift Eject      ${RESET} — Turn off display only"
        echo ""
        echo -e "${ORANGE}Force Quit:${RESET}"
        echo -e "${MAGENTA}Cmd Option Esc        ${RESET} — Force Quit dialog (like Ctrl+Alt+Del)"
        echo -e "${MAGENTA}Cmd Option Shift Esc  ${RESET} — Force quit frontmost app (hold 3 sec)"
        echo ""
        echo -e "${ORANGE}System:${RESET}"
        echo -e "${MAGENTA}Cmd Space             ${RESET} — Spotlight search"
        echo -e "${MAGENTA}Cmd ,                 ${RESET} — Open Preferences/Settings of current app"
        echo -e "${MAGENTA}Cmd Option D          ${RESET} — Toggle Dock auto-hide"
        echo -e "${MAGENTA}Ctrl Cmd Space        ${RESET} — Emoji & Symbol picker"
        echo -e "${MAGENTA}Cmd Shift .           ${RESET} — Show/hide hidden files in Finder/dialogs"
        echo ""
        ###NEW### Adicionado clipboard à cheatsheet macOS
        echo -e "${ORANGE}Clipboard:${RESET}"
        echo -e "${MAGENTA}pbcopy                ${RESET} — Copy stdin to clipboard (ex: cat file | pbcopy)"
        echo -e "${MAGENTA}pbpaste               ${RESET} — Paste clipboard to stdout (ex: pbpaste > file)"
        echo -e "${MAGENTA}clip / paste          ${RESET} — Aliases for pbcopy / pbpaste"
        echo
        ;;

    "screenshot"|"screen"|"ss")
        echo ""
        echo -e "${BLUE}macOS — Screenshots & Screen Recording${RESET}\n"
        echo -e "${MAGENTA}Cmd Shift 3           ${RESET} — Screenshot entire screen"
        echo -e "${MAGENTA}Cmd Shift 4           ${RESET} — Screenshot selected area (crosshair)"
        echo -e "${MAGENTA}Cmd Shift 4 Space     ${RESET} — Screenshot a specific window"
        echo -e "${MAGENTA}Cmd Shift 5           ${RESET} — Screenshot toolbar (area, window, record)"
        echo -e "${MAGENTA}Cmd Shift 6           ${RESET} — Screenshot Touch Bar (if present)"
        echo ""
        echo -e "${ORANGE}Modifiers:${RESET}"
        echo -e "${MAGENTA}+ Ctrl                ${RESET} — Copy to clipboard instead of saving file"
        echo -e "${MAGENTA}+ Option              ${RESET} — Remove window shadow (window screenshot)"
        echo -e "${MAGENTA}Esc                   ${RESET} — Cancel screenshot in progress"
        echo -e "${CYAN}Screenshots save to ~/Desktop by default${RESET}"
        echo -e "${CYAN}Change location: Cmd Shift 5 → Options → Save to${RESET}"
        echo
        ;;

    "text"|"editing"|"txt")
        echo ""
        echo -e "${BLUE}macOS — Text Editing (works in most apps)${RESET}\n"
        echo -e "${ORANGE}Basics:${RESET}"
        echo -e "${MAGENTA}Cmd C / V / X         ${RESET} — Copy / Paste / Cut"
        echo -e "${MAGENTA}Cmd Z                 ${RESET} — Undo"
        echo -e "${MAGENTA}Cmd Shift Z           ${RESET} — Redo"
        echo -e "${MAGENTA}Cmd A                 ${RESET} — Select all"
        echo -e "${MAGENTA}Cmd Option V          ${RESET} — Paste without formatting"
        echo ""
        echo -e "${ORANGE}Navigation:${RESET}"
        echo -e "${MAGENTA}Cmd ← / →             ${RESET} — Jump to start/end of line"
        echo -e "${MAGENTA}Cmd ↑ / ↓             ${RESET} — Jump to start/end of document"
        echo -e "${MAGENTA}Option ← / →          ${RESET} — Jump word by word"
        echo -e "${MAGENTA}Fn ↑ / ↓              ${RESET} — Page Up / Page Down"
        echo -e "${MAGENTA}Fn ← / →              ${RESET} — Home / End"
        echo ""
        echo -e "${ORANGE}Selection (add Shift to any navigation):${RESET}"
        echo -e "${MAGENTA}Shift Cmd →           ${RESET} — Select from cursor to end of line"
        echo -e "${MAGENTA}Shift Option →        ${RESET} — Select word by word"
        echo -e "${MAGENTA}Shift Cmd ↓           ${RESET} — Select to end of document"
        echo ""
        echo -e "${ORANGE}Delete:${RESET}"
        echo -e "${MAGENTA}Fn Delete             ${RESET} — Forward delete (Delete key on full keyboard)"
        echo -e "${MAGENTA}Option Delete         ${RESET} — Delete previous word"
        echo -e "${MAGENTA}Cmd Delete            ${RESET} — Delete to start of line"
        echo ""
        echo -e "${ORANGE}Find:${RESET}"
        echo -e "${MAGENTA}Cmd F                 ${RESET} — Find"
        echo -e "${MAGENTA}Cmd G / Shift Cmd G   ${RESET} — Find next / previous"
        echo -e "${MAGENTA}Cmd Option F          ${RESET} — Find & Replace"
        echo
        ;;

    "finder"|"explorer"|"files"|"file")
        echo ""
        echo -e "${BLUE}macOS — Finder${RESET}\n"
        echo -e "${ORANGE}Navigation:${RESET}"
        echo -e "${MAGENTA}Cmd ↑                 ${RESET} — Go to parent folder"
        echo -e "${MAGENTA}Cmd ↓                 ${RESET} — Open selected folder/file"
        echo -e "${MAGENTA}Cmd [ / ]             ${RESET} — Back / Forward"
        echo -e "${MAGENTA}Cmd Shift G           ${RESET} — Go to folder (type path)"
        echo -e "${MAGENTA}Cmd Shift H           ${RESET} — Go to Home folder"
        echo -e "${MAGENTA}Cmd Shift D           ${RESET} — Go to Desktop"
        echo -e "${MAGENTA}Cmd Shift A           ${RESET} — Go to Applications"
        echo -e "${MAGENTA}Cmd Shift O           ${RESET} — Go to Documents"
        echo -e "${MAGENTA}Cmd Shift L           ${RESET} — Go to Downloads"
        echo ""
        echo -e "${ORANGE}Actions:${RESET}"
        echo -e "${MAGENTA}Space                 ${RESET} — Quick Look (preview file)"
        echo -e "${MAGENTA}Cmd I                 ${RESET} — Get Info"
        echo -e "${MAGENTA}Cmd D                 ${RESET} — Duplicate"
        echo -e "${MAGENTA}Cmd Delete            ${RESET} — Move to Trash"
        echo -e "${MAGENTA}Cmd Shift Delete      ${RESET} — Empty Trash"
        echo -e "${MAGENTA}Enter                 ${RESET} — Rename selected file"
        echo -e "${MAGENTA}Cmd Option C          ${RESET} — Copy file path"
        echo -e "${MAGENTA}Cmd Shift .           ${RESET} — Show/hide hidden files"
        echo ""
        echo -e "${ORANGE}Views:${RESET}"
        echo -e "${MAGENTA}Cmd 1                 ${RESET} — Icon view"
        echo -e "${MAGENTA}Cmd 2                 ${RESET} — List view"
        echo -e "${MAGENTA}Cmd 3                 ${RESET} — Column view"
        echo -e "${MAGENTA}Cmd 4                 ${RESET} — Gallery view"
        echo -e "${MAGENTA}Cmd J                 ${RESET} — View options for current folder"
        echo -e "${MAGENTA}Cmd T                 ${RESET} — New tab"
        echo -e "${MAGENTA}Cmd Option S          ${RESET} — Toggle sidebar"
        echo -e "${MAGENTA}Cmd /                 ${RESET} — Toggle status bar"
        echo
        ;;

    "browser"|"firefox"|"ff")
        echo ""
        echo -e "${BLUE}macOS — Firefox Browser${RESET}\n"
        echo -e "${ORANGE}Tabs:${RESET}"
        echo -e "${MAGENTA}Cmd T                 ${RESET} — New tab"
        echo -e "${MAGENTA}Cmd W                 ${RESET} — Close tab"
        echo -e "${MAGENTA}Cmd Shift T           ${RESET} — Reopen closed tab"
        echo -e "${MAGENTA}Ctrl Tab              ${RESET} — Next tab"
        echo -e "${MAGENTA}Ctrl Shift Tab        ${RESET} — Previous tab"
        echo -e "${MAGENTA}Cmd 1-8               ${RESET} — Jump to tab by number"
        echo -e "${MAGENTA}Cmd 9                 ${RESET} — Jump to last tab"
        echo ""
        echo -e "${ORANGE}Navigation:${RESET}"
        echo -e "${MAGENTA}Cmd L                 ${RESET} — Focus address bar"
        echo -e "${MAGENTA}Cmd [ / ]             ${RESET} — Back / Forward"
        echo -e "${MAGENTA}Cmd R                 ${RESET} — Reload page"
        echo -e "${MAGENTA}Cmd Shift R           ${RESET} — Reload ignoring cache"
        echo -e "${MAGENTA}Cmd + / Cmd -         ${RESET} — Zoom in / out"
        echo -e "${MAGENTA}Cmd 0                 ${RESET} — Reset zoom"
        echo ""
        echo -e "${ORANGE}Other:${RESET}"
        echo -e "${MAGENTA}Cmd Shift N           ${RESET} — New private window"
        echo -e "${MAGENTA}Cmd Option I          ${RESET} — Developer Tools"
        echo -e "${MAGENTA}Cmd J                 ${RESET} — Downloads"
        echo -e "${MAGENTA}Cmd D                 ${RESET} — Bookmark page"
        echo -e "${MAGENTA}Cmd Shift B           ${RESET} — Toggle bookmarks sidebar"
        echo -e "${MAGENTA}Cmd Shift H           ${RESET} — History sidebar"
        echo -e "${MAGENTA}F11                   ${RESET} — Toggle fullscreen"
        echo
        ;;

    ###NEW### Secção terminal reescrita para iTerm2 e Ghostty
    "terminal"|"term"|"iterm"|"ghostty")
        echo ""
        echo -e "${BLUE}macOS — iTerm2 & Ghostty${RESET}\n"
        echo -e "${ORANGE}iTerm2:${RESET}"
        echo -e "${MAGENTA}Cmd T                 ${RESET} — New tab"
        echo -e "${MAGENTA}Cmd N                 ${RESET} — New window"
        echo -e "${MAGENTA}Cmd D                 ${RESET} — Split pane vertically"
        echo -e "${MAGENTA}Cmd Shift D           ${RESET} — Split pane horizontally"
        echo -e "${MAGENTA}Cmd Option Arrow      ${RESET} — Navigate between panes"
        echo -e "${MAGENTA}Cmd W                 ${RESET} — Close tab/pane"
        echo -e "${MAGENTA}Cmd K                 ${RESET} — Clear screen (keeps scrollback)"
        echo -e "${MAGENTA}Cmd + / Cmd -         ${RESET} — Increase/decrease font size"
        echo -e "${MAGENTA}Cmd ,                 ${RESET} — Preferences"
        echo -e "${MAGENTA}Cmd Shift Enter       ${RESET} — Toggle maximize pane"
        echo -e "${MAGENTA}Cmd Option E          ${RESET} — Expose all tabs"
        echo -e "${MAGENTA}Cmd /                 ${RESET} — Show cursor position"
        echo -e "${MAGENTA}Option click          ${RESET} — Move cursor to click position"
        echo ""
        echo -e "${ORANGE}Ghostty:${RESET}"
        echo -e "${MAGENTA}Cmd T                 ${RESET} — New tab"
        echo -e "${MAGENTA}Cmd N                 ${RESET} — New window"
        echo -e "${MAGENTA}Cmd D                 ${RESET} — Split right"
        echo -e "${MAGENTA}Cmd Shift D           ${RESET} — Split down"
        echo -e "${MAGENTA}Cmd Option Arrow      ${RESET} — Navigate between splits"
        echo -e "${MAGENTA}Cmd W                 ${RESET} — Close split/tab"
        echo -e "${MAGENTA}Cmd + / Cmd -         ${RESET} — Font size"
        echo -e "${MAGENTA}Cmd ,                 ${RESET} — Open config file"
        echo -e "${CYAN}Config: ~/.config/ghostty/config${RESET}"
        echo ""
        echo -e "${ORANGE}Zsh/Shell (inside any terminal):${RESET}"
        echo -e "${MAGENTA}Ctrl A / Ctrl E       ${RESET} — Jump to start/end of line"
        echo -e "${MAGENTA}Ctrl W                ${RESET} — Delete previous word"
        echo -e "${MAGENTA}Ctrl U                ${RESET} — Delete entire line (before cursor)"
        echo -e "${MAGENTA}Ctrl K                ${RESET} — Delete from cursor to end of line"
        echo -e "${MAGENTA}Ctrl R                ${RESET} — Reverse search command history"
        echo -e "${MAGENTA}Ctrl L                ${RESET} — Clear screen"
        echo -e "${MAGENTA}Ctrl C                ${RESET} — Cancel current command"
        echo -e "${MAGENTA}Ctrl Z                ${RESET} — Suspend process (fg to resume)"
        echo -e "${MAGENTA}Ctrl D                ${RESET} — Exit shell (EOF)"
        echo -e "${MAGENTA}!!                    ${RESET} — Repeat last command"
        echo -e "${MAGENTA}!\$                    ${RESET} — Last argument of previous command"
        echo
        ;;

    "spotlight"|"search")
        echo ""
        echo -e "${BLUE}macOS — Spotlight & Search${RESET}\n"
        echo -e "${MAGENTA}Cmd Space             ${RESET} — Open Spotlight"
        echo -e "${MAGENTA}type + Enter          ${RESET} — Open top result"
        echo -e "${MAGENTA}type + Cmd Enter      ${RESET} — Show top result in Finder"
        echo -e "${MAGENTA}Cmd B                 ${RESET} — Search in browser"
        echo ""
        echo -e "${ORANGE}Spotlight tips:${RESET}"
        echo -e "${CYAN}Type math:${RESET}            2+2, 15% of 200, 50 USD to EUR"
        echo -e "${CYAN}App launcher:${RESET}         Type app name and Enter"
        echo -e "${CYAN}Dictionary:${RESET}           Type a word for definition"
        echo -e "${CYAN}File search:${RESET}          kind:pdf, date:today, name:report"
        echo -e "${CYAN}Weather:${RESET}              Type 'weather'"
        echo
        ;;

    "accessibility"|"acc")
        echo ""
        echo -e "${BLUE}macOS — Accessibility & Useful Tricks${RESET}\n"
        echo -e "${ORANGE}Zoom:${RESET}"
        echo -e "${MAGENTA}Cmd Option +          ${RESET} — Zoom in (accessibility)"
        echo -e "${MAGENTA}Cmd Option -          ${RESET} — Zoom out (accessibility)"
        echo -e "${MAGENTA}Cmd Option 8          ${RESET} — Toggle zoom on/off"
        echo ""
        echo -e "${ORANGE}Display:${RESET}"
        echo -e "${MAGENTA}Ctrl Cmd Q            ${RESET} — Lock screen"
        echo -e "${MAGENTA}Cmd Shift Q           ${RESET} — Log out"
        echo -e "${MAGENTA}Cmd Option Ctrl 8     ${RESET} — Invert display colors"
        echo ""
        echo -e "${ORANGE}Dictation & Siri:${RESET}"
        echo -e "${MAGENTA}Fn Fn (press twice)   ${RESET} — Start dictation"
        echo -e "${MAGENTA}Hold Cmd Space        ${RESET} — Siri (if enabled)"
        echo ""
        echo -e "${ORANGE}Misc:${RESET}"
        echo -e "${MAGENTA}Cmd Shift 3/4/5       ${RESET} — Screenshots"
        echo -e "${MAGENTA}Cmd Option Esc        ${RESET} — Force Quit"
        echo -e "${MAGENTA}Option click WiFi     ${RESET} — Show detailed WiFi info"
        echo -e "${MAGENTA}Option click Battery  ${RESET} — Show battery condition"
        echo -e "${MAGENTA}Option click Bluetooth${RESET} — Show Bluetooth debug info"
        echo -e "${MAGENTA}Option click Volume   ${RESET} — Select audio output device"
        echo
        ;;

    "all"|"full"|"")
        macfo nav
        macfo system
        macfo screenshot
        macfo text
        macfo finder
        macfo firefox
        macfo terminal
        macfo spotlight
        macfo accessibility
        ;;

    *)
        echo ""
        echo -e "${YELLOW}macOS Cheatsheet — Available sections:${RESET}"
        echo "  nav | navigation | windows — Window management, app switching, Spaces"
        echo "  system | sys               — Lock screen, force quit, Spotlight, Dock"
        echo "  screenshot | screen | ss   — Screenshots and screen recording"
        echo "  text | editing | txt       — Text editing, copy/paste, navigation"
        echo "  finder | explorer | files  — Finder navigation, views, actions"
        echo "  browser | firefox | ff     — Firefox tabs, navigation, zoom"
        echo "  terminal | term | iterm | ghostty — iTerm2, Ghostty, shell shortcuts"
        echo "  spotlight | search         — Spotlight search tips and tricks"
        echo "  accessibility | acc        — Accessibility, zoom, display tricks"
        echo "  all                        — Show all sections"
        echo ""
        echo -e "${CYAN}Usage: macfo [section]${RESET}"
        echo
        ;;
    esac
}


zfo() {
    local section="${1:-all}"

    case "$section" in

    "git"|"g")
        echo ""
        echo -e "${BLUE}OMZ Git Plugin — Aliases${RESET}\n"

        echo -e "${ORANGE}Basic:${RESET}"
        echo -e "${MAGENTA}g         ${RESET} — git"
        echo -e "${MAGENTA}ga        ${RESET} — git add"
        echo -e "${MAGENTA}gaa       ${RESET} — git add --all"
        echo -e "${MAGENTA}gst       ${RESET} — git status"
        echo -e "${MAGENTA}gss       ${RESET} — git status --short"
        echo -e "${MAGENTA}gsb       ${RESET} — git status --short --branch"
        echo ""

        echo -e "${ORANGE}Commit:${RESET}"
        echo -e "${MAGENTA}gc        ${RESET} — git commit --verbose"
        echo -e "${MAGENTA}gc!       ${RESET} — git commit --verbose --amend"
        echo -e "${MAGENTA}gcn!      ${RESET} — git commit --verbose --no-edit --amend"
        echo -e "${MAGENTA}gcmsg     ${RESET} — git commit --message"
        echo -e "${MAGENTA}gca       ${RESET} — git commit --verbose --all"
        echo -e "${MAGENTA}gca!      ${RESET} — git commit --verbose --all --amend"
        echo -e "${MAGENTA}gcam      ${RESET} — git commit --all --message"
        echo ""

        echo -e "${ORANGE}Branch & Checkout:${RESET}"
        echo -e "${MAGENTA}gb        ${RESET} — git branch"
        echo -e "${MAGENTA}gba       ${RESET} — git branch --all"
        echo -e "${MAGENTA}gbd       ${RESET} — git branch --delete"
        echo -e "${MAGENTA}gbD       ${RESET} — git branch --delete --force"
        echo -e "${MAGENTA}gbnm      ${RESET} — git branch --no-merged"
        echo -e "${MAGENTA}gco       ${RESET} — git checkout"
        echo -e "${MAGENTA}gcb       ${RESET} — git checkout -b"
        echo -e "${MAGENTA}gcm       ${RESET} — git checkout \$(git_main_branch)"
        echo -e "${MAGENTA}gcd       ${RESET} — git checkout develop"
        echo -e "${MAGENTA}gsw       ${RESET} — git switch"
        echo -e "${MAGENTA}gswc      ${RESET} — git switch --create"
        echo ""

        echo -e "${ORANGE}Push & Pull:${RESET}"
        echo -e "${MAGENTA}gp        ${RESET} — git push"
        echo -e "${MAGENTA}gpd       ${RESET} — git push --dry-run"
        echo -e "${MAGENTA}gpf       ${RESET} — git push --force-with-lease"
        echo -e "${MAGENTA}gpf!      ${RESET} — git push --force"
        echo -e "${MAGENTA}gpsup     ${RESET} — git push --set-upstream origin \$(current_branch)"
        echo -e "${MAGENTA}gl        ${RESET} — git pull"
        echo -e "${MAGENTA}ggl       ${RESET} — git pull origin \$(current_branch)"
        echo -e "${MAGENTA}ggp       ${RESET} — git push origin \$(current_branch)"
        echo -e "${MAGENTA}gf        ${RESET} — git fetch"
        echo -e "${MAGENTA}gfa       ${RESET} — git fetch --all --prune --jobs=10"
        echo -e "${MAGENTA}gfo       ${RESET} — git fetch origin"
        echo -e "${MAGENTA}gup       ${RESET} — git pull --rebase"
        echo -e "${MAGENTA}gupa      ${RESET} — git pull --rebase --autostash"
        echo ""

        echo -e "${ORANGE}Log:${RESET}"
        echo -e "${MAGENTA}glog      ${RESET} — git log --oneline --decorate --graph"
        echo -e "${MAGENTA}glol      ${RESET} — git log --graph --pretty (short)"
        echo -e "${MAGENTA}glola     ${RESET} — git log --graph --pretty (all branches)"
        echo -e "${MAGENTA}glols     ${RESET} — git log --graph --pretty --stat"
        echo -e "${MAGENTA}glo       ${RESET} — git log --oneline --decorate"
        echo -e "${MAGENTA}glg       ${RESET} — git log --stat"
        echo -e "${MAGENTA}glgp      ${RESET} — git log --stat --patch"
        echo ""

        echo -e "${ORANGE}Diff:${RESET}"
        echo -e "${MAGENTA}gd        ${RESET} — git diff"
        echo -e "${MAGENTA}gdca      ${RESET} — git diff --cached"
        echo -e "${MAGENTA}gds       ${RESET} — git diff --staged"
        echo -e "${MAGENTA}gdt       ${RESET} — git diff-tree --no-commit-id --name-only -r"
        echo -e "${MAGENTA}gdw       ${RESET} — git diff --word-diff"
        echo ""

        echo -e "${ORANGE}Stash:${RESET}"
        echo -e "${MAGENTA}gsta      ${RESET} — git stash push"
        echo -e "${MAGENTA}gstaa     ${RESET} — git stash apply"
        echo -e "${MAGENTA}gstd      ${RESET} — git stash drop"
        echo -e "${MAGENTA}gstl      ${RESET} — git stash list"
        echo -e "${MAGENTA}gstp      ${RESET} — git stash pop"
        echo -e "${MAGENTA}gsts      ${RESET} — git stash show --patch"
        echo -e "${MAGENTA}gstc      ${RESET} — git stash clear"
        echo ""

        echo -e "${ORANGE}Merge & Rebase:${RESET}"
        echo -e "${MAGENTA}gm        ${RESET} — git merge"
        echo -e "${MAGENTA}gma       ${RESET} — git merge --abort"
        echo -e "${MAGENTA}grb       ${RESET} — git rebase"
        echo -e "${MAGENTA}grba      ${RESET} — git rebase --abort"
        echo -e "${MAGENTA}grbc      ${RESET} — git rebase --continue"
        echo -e "${MAGENTA}grbi      ${RESET} — git rebase --interactive"
        echo -e "${MAGENTA}grbm      ${RESET} — git rebase \$(git_main_branch)"
        echo -e "${MAGENTA}gcp       ${RESET} — git cherry-pick"
        echo -e "${MAGENTA}gcpa      ${RESET} — git cherry-pick --abort"
        echo -e "${MAGENTA}gcpc      ${RESET} — git cherry-pick --continue"
        echo ""

        echo -e "${ORANGE}Remote:${RESET}"
        echo -e "${MAGENTA}gr        ${RESET} — git remote"
        echo -e "${MAGENTA}grv       ${RESET} — git remote --verbose"
        echo -e "${MAGENTA}gra       ${RESET} — git remote add"
        echo -e "${MAGENTA}grrm      ${RESET} — git remote remove"
        echo -e "${MAGENTA}grmv      ${RESET} — git remote rename"
        echo -e "${MAGENTA}grset     ${RESET} — git remote set-url"
        echo ""

        echo -e "${ORANGE}Reset & Clean:${RESET}"
        echo -e "${MAGENTA}grh       ${RESET} — git reset"
        echo -e "${MAGENTA}grhh      ${RESET} — git reset --hard"
        echo -e "${MAGENTA}grhs      ${RESET} — git reset --soft"
        echo -e "${MAGENTA}gpristine ${RESET} — git reset --hard && git clean -dffx"
        echo -e "${MAGENTA}gclean    ${RESET} — git clean --interactive -d"
        echo ""

        echo -e "${ORANGE}Tags:${RESET}"
        echo -e "${MAGENTA}gts       ${RESET} — git tag --sign"
        echo -e "${MAGENTA}gtv       ${RESET} — git tag | sort -V"
        echo ""

        echo -e "${ORANGE}Worktree:${RESET}"
        echo -e "${MAGENTA}gwt       ${RESET} — git worktree"
        echo -e "${MAGENTA}gwta      ${RESET} — git worktree add"
        echo -e "${MAGENTA}gwtls     ${RESET} — git worktree list"
        echo -e "${MAGENTA}gwtmv     ${RESET} — git worktree move"
        echo -e "${MAGENTA}gwtrm     ${RESET} — git worktree remove"
        echo ""

        echo -e "${ORANGE}WIP (Work in Progress):${RESET}"
        echo -e "${MAGENTA}gwip      ${RESET} — git add -A; git rm \$(deleted); git commit -m 'WIP'"
        echo -e "${MAGENTA}gunwip    ${RESET} — Undo WIP commit (git reset HEAD~1 if last commit is WIP)"
        echo ""

        echo -e "${ORANGE}Functions:${RESET}"
        echo -e "${MAGENTA}grename       ${RESET} — Rename old_branch to new_branch (local + remote)"
        echo -e "${MAGENTA}current_branch${RESET} — Returns current branch name"
        echo -e "${MAGENTA}git_main_branch${RESET} — Returns main or master (whichever exists)"
        echo
        ;;

    "kubectl"|"k8s"|"k")
        echo ""
        echo -e "${BLUE}kubectl — Aliases (workflow ArgoCD / read-only)${RESET}\n"
        echo -e "${ORANGE}Core:${RESET}"
        echo -e "${MAGENTA}k         ${RESET} — kubectl"
        echo ""
        echo -e "${ORANGE}Pods:${RESET}"
        echo -e "${MAGENTA}kgp       ${RESET} — kubectl get pods"
        echo -e "${MAGENTA}kgpl      ${RESET} — kubectl get pods -l (by label)"
        echo -e "${MAGENTA}kgpn      ${RESET} — kubectl get pods -n (namespace)"
        echo -e "${MAGENTA}kgpsl     ${RESET} — kubectl get pods --show-labels"
        echo -e "${MAGENTA}kgpw      ${RESET} — kubectl get pods --watch"
        echo -e "${MAGENTA}kgpwide   ${RESET} — kubectl get pods -o wide"
        echo -e "${MAGENTA}kdp       ${RESET} — kubectl describe pods (events!)"
        echo -e "${MAGENTA}keti      ${RESET} — kubectl exec -t -i (shell no pod)"
        echo -e "${MAGENTA}kpf       ${RESET} — kubectl port-forward"
        echo ""
        echo -e "${ORANGE}Deployments:${RESET}"
        echo -e "${MAGENTA}kgd       ${RESET} — kubectl get deployment"
        echo -e "${MAGENTA}kgdwide   ${RESET} — kubectl get deployment -o wide"
        echo -e "${MAGENTA}kdd       ${RESET} — kubectl describe deployment"
        echo -e "${MAGENTA}kgrs      ${RESET} — kubectl get replicaset"
        echo -e "${MAGENTA}krh       ${RESET} — kubectl rollout history (read-only)"
        echo ""
        echo -e "${ORANGE}Rede / contexto (read-only):${RESET}"
        echo -e "${MAGENTA}kgs       ${RESET} — kubectl get svc"
        echo -e "${MAGENTA}kgi       ${RESET} — kubectl get ingress"
        echo ""
        echo -e "${ORANGE}Events & Logs:${RESET}"
        echo -e "${MAGENTA}kge       ${RESET} — kubectl get events (sorted)"
        echo -e "${MAGENTA}kgew      ${RESET} — kubectl get events --watch"
        echo -e "${MAGENTA}kl        ${RESET} — kubectl logs"
        echo -e "${MAGENTA}klf       ${RESET} — kubectl logs -f (follow)"
        echo ""
        echo -e "${ORANGE}Output colorido:${RESET}"
        echo -e "${MAGENTA}kj        ${RESET} — get -o json | jq"
        echo -e "${MAGENTA}kjx       ${RESET} — get -o json | fx   (precisa de fx)"
        echo -e "${MAGENTA}ky        ${RESET} — get -o yaml | yh   (precisa de yh)"
        echo ""
        echo -e "${ORANGE}Contexto & Namespace:${RESET}"
        echo -e "${MAGENTA}kx        ${RESET} — kubectx (troca de contexto; local, sem RBAC)"
        echo -e "${MAGENTA}kn [ns]   ${RESET} — troca de namespace via lista fixa (KNOWN_NS)"
        echo -e "${MAGENTA}knls      ${RESET} — lista os namespaces conhecidos"
        echo -e "${CYAN}Nota: sem permissão de 'list namespaces'; kn usa lista fixa e o switch é local.${RESET}"
        echo ""
        echo -e "${YELLOW}Tip: 'alias | grep kubectl' mostra os aliases ativos.${RESET}"
        echo
        ;;

    "all"|"full"|"")
        zfo git
        zfo kubectl
        ;;

    *)
        echo ""
        echo -e "${YELLOW}Oh My Zsh Plugins Cheatsheet${RESET}"
        echo "  git          — Git aliases"
        echo "  k8s          — Kubectl aliases"
        echo "  all          — Show all"
        echo ""
        echo -e "${CYAN}Uso: zfo [section]${RESET}"
        echo -e "${CYAN}Accepted: git/g, kubectl/k8s/k${RESET}"
        echo
        ;;
    esac
}

# =========================================================
# keys — cheatsheet do window-management (AeroSpace/AltTab/Sketchybar)
# =========================================================
typeset -g KEYS_MD="${KEYS_MD:-$HOME/git/personal/mac-dotfiles/cheatsheet.md}"

_keys_header()  { printf '\n\033[1;36m━━ %s ━━\033[0m\n\n' "$1"; }
_keys_row()     { printf '  \033[1;33m%-26s\033[0m %s\n' "$1" "$2"; }
_keys_section() { printf '\n  \033[1;35m%s\033[0m\n' "$1"; }
_keys_note()    { printf '\n  \033[2m%s\033[0m\n' "$1"; }

_keys_menu() {
  _keys_header "keys — mac-dotfiles"
  printf '  Usage: \033[1mkeys\033[0m \033[2m[section]\033[0m\n\n'
  printf '  Sections:\n'
  _keys_row "aerospace"  "AeroSpace keybindings (focus, move, workspaces, monitor)"
  _keys_row "alttab"     "AltTab window switcher"
  _keys_row "sketchybar" "Sketchybar control and items"
  _keys_row "multi"      "Multi-monitor reference"
  _keys_row "cli"        "AeroSpace CLI helpers"
  _keys_row "trouble"    "Troubleshooting"
  _keys_row "all"        "Render the full cheatsheet.md via glow"
  echo
}

_keys_aerospace() {
  _keys_header "AeroSpace"
  _keys_section "Focus & movement"
  _keys_row "alt + h/j/k/l"          "Focus window left/down/up/right (vim-style)"
  _keys_row "alt + shift + h/j/k/l"  "Move window within the workspace"
  _keys_row "alt + f"                "Toggle fullscreen (non-native)"
  _keys_row "alt + shift + space"    "Toggle floating / tiling layout"
  _keys_row "alt + /"                "Layout: tiles"
  _keys_row "alt + ,"                "Layout: accordion"
  _keys_row "alt + -"                "Resize: shrink"
  _keys_row "alt + ="                "Resize: grow"
  _keys_section "Workspaces"
  _keys_row "alt + 1..9"             "Switch to workspace 1-9"
  _keys_row "alt + shift + 1..9"     "Move window to workspace 1-9 (focus follows)"
  _keys_row "alt + tab"              "Toggle current ↔ previous workspace"
  _keys_section "Multi-monitor"
  _keys_row "alt + shift + ←"        "Move window to previous monitor"
  _keys_row "alt + shift + →"        "Move window to next monitor"
  _keys_row "alt + shift + ↑"        "Move workspace to previous monitor"
  _keys_row "alt + shift + ↓"        "Move workspace to next monitor"
  _keys_section "Service mode (enter: alt + shift + ;)"
  _keys_row "esc"                    "Reload config and exit"
  _keys_row "r"                      "Flatten tree (reset layout)"
  _keys_row "f"                      "Toggle floating / tiling"
  _keys_row "backspace"              "Close all windows except focused"
  echo
}

_keys_alttab() {
  _keys_header "AltTab"
  _keys_row "option + tab"           "Cycle forward through windows"
  _keys_row "option + shift + tab"   "Cycle backward"
  _keys_row "option (release)"       "Confirm selection"
  _keys_row "esc"                    "Cancel"
  _keys_row "arrows"                 "Navigate selection"
  _keys_row "q"                      "Quit highlighted app"
  _keys_row "w"                      "Close highlighted window"
  _keys_row "h"                      "Hide highlighted app"
  _keys_row "m"                      "Minimize highlighted window"
  _keys_section "Recommended settings (Windows-like)"
  _keys_row "Show from apps"         "All apps"
  _keys_row "Show from spaces"       "All spaces"
  _keys_row "Show from screens"      "All screens"
  _keys_row "Minimized"             "Show"
  _keys_row "Hidden"                "Show"
  _keys_row "Fullscreen"            "Show"
  _keys_row "Apps with no window"   "Hide"
  echo
}

_keys_sketchybar() {
  _keys_header "Sketchybar"
  _keys_section "Service control"
  _keys_row "brew services start sketchybar"   "Start as background service"
  _keys_row "brew services restart sketchybar" "Restart (structural changes)"
  _keys_row "brew services stop sketchybar"    "Stop"
  _keys_row "sketchybar --reload"              "Re-source sketchybarrc (light)"
  _keys_row "sketchybar --update"              "Force refresh of every item"
  _keys_section "Items in this config"
  _keys_row "left"                  "AeroSpace workspaces (clickable, highlighted)"
  _keys_row "right"                 "Clock and battery"
  _keys_section "Plugins"
  _keys_row "aerospace.sh"          "Toggles highlight per workspace item"
  _keys_row "clock.sh"              "Renders date and time"
  _keys_row "battery.sh"            "Renders battery icon + percentage"
  echo
}

_keys_multi() {
  _keys_header "Multi-monitor"
  _keys_section "Workspace pinning (this config)"
  _keys_row "1-5"                   "built-in (laptop screen)"
  _keys_row "6-9"                   "secondary (external, when present)"
  _keys_note "When only the laptop is connected, 6-9 fall back to built-in."
  _keys_section "Gaps (per-monitor)"
  _keys_row "built-in"              "10px top gap"
  _keys_row "any external"          "40px top gap (room for sketchybar)"
  _keys_section "Monitor patterns used in aerospace.toml"
  _keys_row "'main'"                "macOS primary display"
  _keys_row "'secondary'"           "non-main when 2 monitors connected"
  _keys_row "'built-in'"            "case-insensitive regex substring (laptop)"
  echo
}

_keys_cli() {
  _keys_header "AeroSpace — CLI helpers"
  _keys_row "aerospace list-workspaces --all"      "All workspaces"
  _keys_row "aerospace list-workspaces --focused"  "Currently focused"
  _keys_row "aerospace list-monitors"              "Monitor names + ids"
  _keys_row "aerospace list-windows --all"         "Every managed window"
  _keys_row "aerospace list-windows --workspace 3" "Windows in workspace 3"
  _keys_row "aerospace workspace 4"                "Switch to workspace 4"
  _keys_row "aerospace move-node-to-workspace 5"   "Move focused window to ws 5"
  _keys_row "aerospace move-node-to-monitor next"  "Move focused window to next monitor"
  _keys_row "aerospace reload-config"              "Reload aerospace.toml"
  _keys_row "aerospace enable toggle"              "Disable / re-enable tiling globally"
  echo
}

_keys_trouble() {
  _keys_header "Troubleshooting"
  _keys_section "Sketchybar doesn't update on workspace change"
  _keys_note "Check exec-on-workspace-change in aerospace.toml, and --focus-follows-window on move-node-to-workspace bindings."
  _keys_section "Workspace items missing in sketchybar"
  _keys_note "Plugin scripts not executable. Run: chmod +x ~/.config/sketchybar/plugins/*.sh"
  _keys_section "Battery / clock items show '?'"
  _keys_note "Nerd Font missing. brew install --cask font-sf-mono-nerd-font"
  _keys_section "Top gap wrong on external monitor"
  _keys_note "Confirm monitor matching with: aerospace list-monitors."
  _keys_section "Native fullscreen breaks tiling"
  _keys_note "Use alt+f (AeroSpace fullscreen) instead of the green button."
  _keys_section "Permissions"
  _keys_note "AeroSpace and AltTab need Accessibility: System Settings → Privacy & Security → Accessibility."
  echo
}

_keys_all() {
  if command -v glow >/dev/null 2>&1; then glow "$KEYS_MD"
  elif command -v bat >/dev/null 2>&1; then bat --language=md "$KEYS_MD"
  else cat "$KEYS_MD"; fi
}

keys() {
  case "${1:-}" in
    ""|menu|help|-h|--help) _keys_menu ;;
    aero|aerospace)         _keys_aerospace ;;
    alttab|at)              _keys_alttab ;;
    sketchybar|bar|sb)      _keys_sketchybar ;;
    multi|monitor|mon)      _keys_multi ;;
    cli)                    _keys_cli ;;
    trouble|troubleshoot)   _keys_trouble ;;
    all|full|md)            _keys_all ;;
    *) printf '\033[1;31mUnknown section:\033[0m %s\n' "$1"; _keys_menu; return 1 ;;
  esac
}

if [[ -n "${ZSH_VERSION:-}" ]]; then
  _keys_completion() {
    local -a sections
    sections=(
      'aerospace:AeroSpace keybindings' 'alttab:AltTab shortcuts'
      'sketchybar:Sketchybar control'   'multi:Multi-monitor reference'
      'cli:AeroSpace CLI helpers'       'trouble:Troubleshooting'
      'all:Full markdown via glow'      'menu:Show menu'
    )
    _describe 'section' sections
  }
  compdef _keys_completion keys 2>/dev/null
fi
