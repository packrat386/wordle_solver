wordle_solver
-------------

Tired of staring at wordle? Let's automate that.

## Running

Use the `play_one.rb` script to simulate a single game of wordle.

```
$ WORDLE_STRATEGY=naive ruby play_one.rb
THE WORD IS: rover
GUESSING: haiti
-----
haiti
_____
-----
GUESSING: bulgy
-----
bulgy
_____
-----
GUESSING: dover
-----
dover
_EEEE
-----
GUESSING: cover
-----
cover
_EEEE
-----
GUESSING: rover
WIN IN: 5
{:the_word=>"rover", :guess_count=>5, :guesses=>["haiti", "bulgy", "dover", "cover", "rover"], :result=>:win}
```

Use the `play_many.rb` to simulate several

```
$ WORDLE_TRIALS=1000 WORDLE_STRATEGY=naive ruby play_many.rb
WIN/LOSS
{:win=>910, :lose=>90}
GUESSES REQUIRED
{2=>25, 3=>153, 4=>332, 5=>277, 6=>123, 7=>42, 8=>25, 9=>10, 10=>2, 11=>3, 12=>3, 13=>1, 14=>2, 15=>2}
```

Tested with ruby 3.1.0

### Configuration

It uses env vars

* `WORDLE_STRATEGY`: Select the strategy you want. Currently supports `naive`, `later_first`, `avoid_doubles`, `prefer_common`, and `boring_slack`, all of which are poorly named. Defaults to `naive`.
* `WORDLE_TRIALS`: The number of games to play. Only for `play_many.rb`. Defaults to `1000`.
* `WORDLE_DEBUG`: Prints debug output. Unset is off.

## Which Strategy Is Best?

None of these are really complex strategies and it'd probably take some ML magic to get close to a 100% WR, but they do OK. Check out RESULTS.md for the data from some trials.
