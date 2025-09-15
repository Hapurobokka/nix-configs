# Turns a string into a proper dice roll
#
# It takes a string the form '(\d+)d(\d+)([\+|-]\d+)'
# and sets global variables that can be used to get a roll from it
function dice_into_roll -a dice_string
    set -g _dices ""
    set -g _kind ""
    set -g _mod ""
    
    # Check if the string contains + or -
    if string match -q "*+*" -- $dice_string; or string match -q "*-*" -- $dice_string
        # Parse with modifier
        if string match -r '^(\d+)d(\d+)([\+\-]\d+)$' -- $dice_string >/dev/null
            set -g _dices (string match -r '^(\d+)d(\d+)([\+\-]\d+)$' -- $dice_string)[2]
            set -g _kind (string match -r '^(\d+)d(\d+)([\+\-]\d+)$' -- $dice_string)[3]
            set -g _mod (string match -r '^(\d+)d(\d+)([\+\-]\d+)$' -- $dice_string)[4]
        end
    else
        # Parse without modifier
        if string match -r '^(\d+)d(\d+)$' -- $dice_string >/dev/null
            set -g _dices (string match -r '^(\d+)d(\d+)$' -- $dice_string)[2]
            set -g _kind (string match -r '^(\d+)d(\d+)$' -- $dice_string)[3]
            set -g _mod ""
        end
    end
end

# Uses the global variables to make a dice roll
#
# Takes the global parsed values (_dices, _kind, _mod)
# and makes a dice roll using them
function dice_make_roll
    set -l total 0
    
    # Roll each die and sum them up
    for i in (seq 1 $_dices)
        set -l roll (random 1 $_kind)
        set total (math $total + $roll)
    end
    
    # Apply modifier if present
    if test -n "$_mod"
        # Parse the modifier (remove + if present, keep - for negative)
        set -l mod_value (string replace '+' '' -- $_mod)
        set total (math $total + $mod_value)
    end
    
    echo $total
end

# Makes a dice roll
#
# It takes as many strings that you want of
# the form '(\d+)d(\d+)([\+|-]\d+)'
# and turns them into dice rolls
function dice
    for dice_string in $argv
        dice_into_roll $dice_string
        dice_make_roll
    end
end
