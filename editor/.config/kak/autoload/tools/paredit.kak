
define-command paredit-enable %{
    map buffer insert ( '()<left>'
    map buffer insert { '{}<left>'
    map buffer insert [ '[]<left>'
    map buffer insert < '<><left>'

    map buffer insert ) '<esc>\)<ret>;li'
    map buffer insert } '<esc>\}<ret>;li'
    map buffer insert ] '<esc>\]<ret>;li'
    map buffer insert > '<esc>\><ret>;li'

}


