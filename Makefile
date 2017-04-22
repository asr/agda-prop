.PHONY : default
default : clean test

.ONESHELL:
.PHONY : checklines
checklines :
	@grep '.\{80,\}' -l --recursive src; \
		status=$$?; \
		if [ $$status = 0 ]; \
		then echo "Lines found with more than 80 characters!"; \
		else echo "Succeed!"; \
		fi


.PHONY : clean
clean :
	- find . -name "*.agdai" -type f -delete

.PHONY : test
test :
	cd src/Data/ && agda Prop.agda --verbose=0
	cd test/ && agda cnf.agda --verbose=0
        cd test/ && agda ex-andreas-abel.agda --verbose=0 
		