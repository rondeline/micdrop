directory$ = "/Users/deniznarikan/Desktop/wavs/pps"

pps$ = "209"

soundFile_names$ = selected$("LongSound")
textGrid_names$ = selected$("TextGrid")
select TextGrid 'textGrid_names$'
num_of_intervals = Get number of intervals... 1
for i from 3 to num_of_intervals
    select TextGrid 'textGrid_names$'
	code$ = Get label of interval... 3 'i'
    # If the label is empty, or if there is an accidental space, skip this interval
    if code$ <> ""
        beg = Get start point... 1 'i'
        end = Get end point... 1 'i'
        select LongSound 'soundFile_names$'
        Extract part... beg end no
        Write to WAV file... 'directory$'/'pps$'_'i'_'code$'.wav
        Remove
    endif
endfor
