if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword     palacinkeDirective         include
syn keyword     palacinkeDeclaration       let


hi def link     palacinkeDirective         Statement
hi def link     palacinkeDeclaration       Type


syn keyword     palacinkeStatement         return let spawn defer struct enum using
syn keyword     palacinkeConditional       if else elseif elsif elif unless where and or case in is
syn keyword     palacinkeBranch            break continue

hi def link     palacinkeStatement         Statement
hi def link     palacinkeClass             Statement
hi def link     palacinkeConditional       Conditional
hi def link     palacinkeBranch            Conditional
hi def link     palacinkeLabel             Label
hi def link     palacinkeRepeat            Repeat


syn match       palacinkeDeclaration       /\<fn\>/
syn match       palacinkeDeclaration       /^fn\>/

syn match comment "#.*$"    contains=@Spell,palacinkeCommentTodo
syn match comment "\/\/.*$" contains=@Spell,palacinkeCommentTodo

syn keyword     palacinkeCast              int str float array


hi def link     palacinkeCast              Type


syn keyword     palacinkeBuiltins          len
syn keyword     palacinkeBuiltins          println print
syn keyword     palacinkeBuiltins          append first last tail
syn keyword     palacinkeBoolean           true false
syn keyword     palacinkeNull              nil

hi def link     palacinkeBuiltins          Keyword
hi def link     palacinkeNull              Keyword
hi def link     palacinkeBoolean           Boolean


" Comments; their contents
syn keyword     palacinkeTodo              contained TODO FIXME XXX BUG
syn cluster     palacinkeCommentGroup      contains=palacinkeTodo
syn region      palacinkeComment           start="#" end="$" contains=@palacinkeCommentGroup,@Spell,@palacinkeTodo


hi def link     palacinkeComment           Comment
hi def link     palacinkeTodo              Todo


" palacinke escapes
syn match       palacinkeEscapeOctal       display contained "\\[0-7]\{3}"
syn match       palacinkeEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       palacinkeEscapeX           display contained "\\x\x\{2}"
syn match       palacinkeEscapeU           display contained "\\u\x\{4}"
syn match       palacinkeEscapeBigU        display contained "\\U\x\{8}"
syn match       palacinkeEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+


hi def link     palacinkeEscapeOctal       palacinkeSpecialString
hi def link     palacinkeEscapeC           palacinkeSpecialString
hi def link     palacinkeEscapeX           palacinkeSpecialString
hi def link     palacinkeEscapeU           palacinkeSpecialString
hi def link     palacinkeEscapeBigU        palacinkeSpecialString
hi def link     palacinkeSpecialString     Special
hi def link     palacinkeEscapeError       Error
hi def link     palacinkeException         Exception

" Strings and their contents
syn cluster     palacinkeStringGroup       contains=palacinkeEscapeOctal,palacinkeEscapeC,palacinkeEscapeX,palacinkeEscapeU,palacinkeEscapeBigU,palacinkeEscapeError
syn region      palacinkeString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@palacinkeStringGroup
syn region      palacinkeRegExString       start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/\s*$+ end=+/\s*[;.,)\]}]+me=e-1 oneline
syn region      palacinkeRawString         start=+`+ end=+`+


hi def link     palacinkeString            String
hi def link     palacinkeRawString         String
hi def link     palacinkeRegExString       String

" Characters; their contents
syn cluster     palacinkeCharacterGroup    contains=palacinkeEscapeOctal,palacinkeEscapeC,palacinkeEscapeX,palacinkeEscapeU,palacinkeEscapeBigU
syn region      palacinkeCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@palacinkeCharacterGroup


hi def link     palacinkeCharacter         Character


" Regions
syn region      palacinkeBlock             start="{" end="}" transparent fold
syn region      palacinkeParen             start='(' end=')' transparent


" Integers
syn match       palacinkeDecimalInt        "\<\d\+\([Ee]\d\+\)\?\>"
syn match       palacinkeHexadecimalInt    "\<0x\x\+\>"
syn match       palacinkeOctalInt          "\<0\o\+\>"
syn match       palacinkeOctalError        "\<0\o*[89]\d*\>"


hi def link     palacinkeDecimalInt        Integer
hi def link     palacinkeHexadecimalInt    Integer
hi def link     palacinkeOctalInt          Integer
hi def link     Integer                 Number

" Floating point
syn match       palacinkeFloat             "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match       palacinkeFloat             "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match       palacinkeFloat             "\<\d\+[Ee][-+]\d\+\>"


hi def link     palacinkeFloat             Float
"hi def link     palacinkeImaginary         Number


if exists("palacinke_fold")
    syn match	palacinkeFunction     "\<fn\>"
    syn region	palacinkeFunctionFold start="\<fn\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match palacinkeSync grouphere palacinkeFunctionFold "\<fn\>"
    syn sync match palacinkeSync grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword palacinkeFunction fn
    syn match	palacinkeBraces   "[{}\[\]]"
    syn match	palacinkeParens   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

hi def link palacinkeFunction Function
hi def link palacinkeBraces   Function

let b:current_syntax = "palacinke"
