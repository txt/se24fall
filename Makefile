SHELL     := bash 
MAKEFLAGS += --warn-undefined-variables
.SILENT: 

help:  ## show help
	awk 'BEGIN {FS = ":.*?## "; print "\nmake [WHAT]" } \
			/^[a-zA-Z_0-9-]+:.*?## / {printf "   \033[36m%-10s\033[0m : %s\n", $$1, $$2} \
			' $(MAKEFILE_LIST)

install: ## install lua on {debian, ubuntu, codespaces}
	sudo apt update
	sudo apt install lua5.3

saved: ## save and push  to main branch 
	read -p "commit msg> " x; git commit -am "$$x"; git push;git status


