# Turns a string into a proper dice roll
#
# It takes a string the form '(\d+)d(\d+)([\+|-]\d+)'
# and returns a record that can be used to get a
# roll from it
def "dice into-roll" [s: string] {
    if ($s | str contains "+") or ($s | str contains "-" ) {
        $s | parse --regex '(?<dices>\d+)d(?<kind>\d+)(?<mod>[\+|\-]\d+)'
    } else {
        $s | parse --regex '(?<dices>\d+)d(?<kind>\d+)' | insert mod { null }
    }
}

# Uses the given record to make a dice roll
#
# Takes the given record, expecting it contains the
# columns 'kind', 'dices' and optionally 'mod'
# and makes a dice roll using it
def "dice make-roll" [r] {
    random dice -d ($r.dices | into int) -s ($r.kind | into int)
    | math sum
    | if not ($r.mod | is-empty) { $in + ($r.mod | into int) } else { $in }
}

# Makes a dice roll
#
# It takes as many strings that you want of
# the form '(\d+)d(\d+)([\+|-]\d+)'
# and turns them into dice rolls
def dice [...x: string] {
   $x | each { |elt| dice into-roll $elt } | flatten | each { |elt| dice make-roll $elt }
}
