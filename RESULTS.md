results
-------

The results of some large trials of the different strategies. Errors are cases where it took more than 20 guesses.

```
 [fg386-server] wordle > WORDLE_TRIALS=100000 WORDLE_STRATEGY=naive ruby play_many.rb
WIN/LOSS
{:win=>89348, :lose=>10647, :error=>5}
GUESSES REQUIRED
{1=>20, 2=>1945, 3=>15033, 4=>32338, 5=>27368, 6=>12644, 7=>5477, 8=>2480, 9=>1254, 10=>601, 11=>370, 12=>201, 13=>110, 14=>68, 15=>34, 16=>20, 17=>11, 18=>11, 19=>7, 20=>3}
```

```
 [fg386-server] wordle > WORDLE_TRIALS=100000 WORDLE_STRATEGY=later_first ruby play_many.rb
WIN/LOSS
{:win=>91183, :lose=>8803, :error=>14}
GUESSES REQUIRED
{1=>18, 2=>2672, 3=>19561, 4=>34771, 5=>23637, 6=>10524, 7=>4405, 8=>2085, 9=>1048, 10=>532, 11=>313, 12=>174, 13=>92, 14=>58, 15=>41, 16=>20, 17=>17, 18=>8, 19=>2, 20=>8}
```

```
 [fg386-server] wordle > WORDLE_TRIALS=100000 WORDLE_STRATEGY=avoid_doubles ruby play_many.rb
WIN/LOSS
{:lose=>6391, :win=>93609}
GUESSES REQUIRED
{1=>11, 2=>2212, 3=>17466, 4=>37074, 5=>26416, 6=>10430, 7=>3790, 8=>1515, 9=>640, 10=>246, 11=>113, 12=>46, 13=>16, 14=>11, 15=>8, 16=>3, 17=>2, 19=>1}
```

```
 [fg386-server] wordle > WORDLE_TRIALS=100000 WORDLE_STRATEGY=prefer_common ruby play_many.rb
WIN/LOSS
{:win=>91547, :lose=>8445, :error=>8}
GUESSES REQUIRED
{1=>10, 2=>2604, 3=>23063, 4=>36916, 5=>20291, 6=>8663, 7=>3941, 8=>2011, 9=>1093, 10=>613, 11=>325, 12=>210, 13=>112, 14=>61, 15=>37, 16=>17, 17=>8, 18=>9, 19=>5, 20=>3}
```

```
 [fg386-server] wordle > WORDLE_TRIALS=100000 WORDLE_STRATEGY=boring_slack ruby play_many.rb
WIN/LOSS
{:win=>94679, :lose=>5317, :error=>4}
GUESSES REQUIRED
{1=>5, 3=>14, 4=>60835, 5=>26645, 6=>7180, 7=>2634, 8=>1235, 9=>606, 10=>358, 11=>189, 12=>131, 13=>70, 14=>35, 15=>28, 16=>19, 17=>5, 18=>3, 19=>1, 20=>3}
```
