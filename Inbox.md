Inbox
========

Command pattern appears to be emerging in the `BitmapEditor`

**Clues**
   - executing particular methods based on the command type.
     Could refactor conditional to polymorphic objects
   - dimensions out of bounds tests were initially written in
     the `Canvas` spec but that meant canvas had more than one
     responsibility, so moved it to `BitmapEditor` spec. Now
     `BitmapEditor` violates SRP (it now interprets and executes
     command)
   - The current `BitmapEditor` tests are testing what are really command
     methods in an involved manner

**Advantages**
   - Using pattern would simplify the `BitmapEditor` examples. We just need to check
     the right command object was invoked via test doubles
   - The current specs (exiting the editor, drawing a vertical tests) don't need the input
     anymore, just the args

**Disadvantages**
   - We need eight new classes

**TODO**
 - Command edge cases
      - too few args
      - dimensions out of range

