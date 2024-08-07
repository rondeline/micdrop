
textfile$="188/durationchaos_188_10.txt"
# check how many intervals there are in the selected tier:
for tier from 3 to 3 
	number = Get number of intervals... tier
# loop through all the intervals
	for k to number
		label$ = Get label of interval... tier k
# if the interval has some text as a label, then calculate the duration.
		if label$ <> ""
			start = Get starting point... tier k
			end = Get end point... tier k
			duration = end - start
		# and, when there are spaces in between labels, duplicate the line	
		  # put more lines here!
		# append the label and the duration to the end of the text file, separated with a tab:		
			resultline$ = "'label$'	'start'	'end'	'duration''newline$'"
			fileappend "'textfile$'" 'resultline$'
		endif
	endfor
endfor