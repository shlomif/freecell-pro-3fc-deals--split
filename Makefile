all:

TOT = Total-Imp3.txt

total: $(TOT)

$(TOT):
	(cd Imp3 && ls | xargs cat) > $@

test:
	prove t/*.t
