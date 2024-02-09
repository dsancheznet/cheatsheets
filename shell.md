% Shell Cheatsheet
% (c) D.Sánchez
% 2024

\pagebreak

# Shell

I personally use zsh because I have both, a MacBook and a Linux Laptop, but most of the data from this Cheatsheet
should be applicable to other shells as well. Whoever wants to have a PR incorporated is more than welcome.

## Keyboard Shortcuts

| Shortcuts | Meaning |
|:---------|--------:|
| `Ctrl+a`  | Move cursor to **start** of line |
| `Ctrl+e`  | Move cursor to **end** of line |
| `Ctrl+b`  | Move **back** one **character** |
| `Alt+b`   | Move **back** one **word** |
| `Ctrl+f`  | Move **forward** one **character** |
| `Alt+f`   | Move **forward** one **word** |
| `Ctrl+d`  | Delete current character |
| `Ctrl+k`  | Cut everything after the cursor |
| `Alt+d`   | Cut word after the cursor |
| `Ctrl+w`  | Cut word before the cursor |
| `Ctrl+y`  | Paste the last deleted command |
| `Ctrl+_`  | Undo |
| `Ctrl+u`  | Cut everything before the cursor |
| `Ctrl+x` | Toggle between first and current position |
| `Ctrl+l`  | Clear the terminal |
| `Ctrl+c`  | Cancel the command |
| `Ctrl+r`  | Search command in history - type the search term |
| `Ctrl+j`  | End the search at current history entry |
| `Ctrl+g`  | Cancel the search and restore original line |
| `Ctrl+n`  | Next command from the History |
| `Ctrl+p`  | Previous command from the History |

## Bang commands

| Shortcuts | Meaning |
|:---------|:-------:|
|`!!`      | Run last command |
|`!blah`   | Run the most recent command that starts with ‘blah’ (e.g. !ls) |
|`!blah:p` | Print out the command that !blah would run (also adds it as the latest command in the command history) |
|`!$`      | The last word of the previous command (same as Alt + .) |
|`!$:p`    | Print out the word that !$ would substitute |
|`!*`      | The previous command except for the last word (e.g. if you type ‘_find somefile.txt /’, then !* would give you ‘_find somefile.txt’) |
|`!*:p`    | Print out what !* would substitute |

## Programming

```
//TODO
- Write Programming Manual
```

