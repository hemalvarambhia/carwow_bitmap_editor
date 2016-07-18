Inbox
========
# Tensions
Currently, we're testing each command's validate arguments method:

`invalid?(args)`

Namely, the command objects have two responsibilities: 
parsing and then executing the command.
This could be a (weak) indication that there is an object missing 
in the design.

How to deal with edge cases is speculative/open-ended at the moment. 
Taking action based purely on speculation is likely to damage the design.
