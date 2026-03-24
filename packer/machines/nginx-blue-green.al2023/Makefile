
# vscode-modelines
# vim:ft=make:ts=8:sts=8:sw=8:noet:tw=80:nowrap:list

# Makefile for Terragrunt

# Variables
TERRAGRUNT_WORKING_DIR ?= .

SHELL:=bash

_os := $(shell uname -sr)
_uname := $(shell uname -om)
_plat := $(shell uname -om | sed -e 's|x86_64 GNU/Linux|linux_amd64|' \
                                 -e 's|x86_64 Linux|linux_amd64|'  \
                                 -e 's|aarch64 Linux|linux_arm64|' \
                                 -e 's|arm64 Darwin|darwin_arm64|' \
                                 -e 's|Darwin arm64|darwin_arm64|' )
_os_release := $(shell awk -F= '/^NAME/ {print $$2}' /etc/os-release)
_brew_version := $(shell brew -v)

#_venv := .venv
#_python_version := $(shell python3 -V)

###
### goals/targets/tasks
### (.PHONY: meaning: target is not a file, but a 'task')
###
.DEFAULT_GOAL:= help


################################################################################
##@ Help

.PHONY: help
help:   ## - Default goal: list of targets in Makefile
	@echo
	@echo "  ## Oper.System : [$(_os)]"
	@echo "  ## Unix name   : [$(_uname)]"
	@echo "  ## Platform    : [$(_plat)]"
	@echo "  ## Distro      : [$(_os_release)]"
	@echo "  ## WSL Distro  : [${WSL_DISTRO_NAME}]"
	@echo "  ## Brew version: [$(_brew_version)]"
#   @echo "  ## Python Version: [$(_python_version)]"
#   @echo "  ## Virtualenv  : [$(_venv)]"

	@awk '\
	  BEGIN { FS = ":.*##"; printf "\nUsage:\n  make \033[01;33m<target>\033[0m\n" }        \
	  /^##@/                  { printf "\n\033[01;37m  %s   \033[0m\n"   , substr($$0, 5) } \
	  /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[01;33m  %-25s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo

################################################################################
##@ Setup

.PHONY: install
install: ## - Install 'packer'
	@echo
	@echo Packer: pre-req:  Download/Install from https://developer.hashicorp.com/packer/install
	@echo


################################################################################
##@ Packer

.PHONY: build
build: ## - Packer: build
	@echo
	source ./_variables.sh && \
	packer init . && packer build .


.PHONY: build-blue
build-blue: ## - Packer: build 'blue' release
	@echo
	export PKR_VAR_release=blue        && \
	source ../../bin/_check-release.sh && \
	source ./_variables.sh             && \
	packer init . && packer build .


.PHONY: build-green
build-green: ## - Packer: build 'green' release
	@echo
	export PKR_VAR_release=green       && \
	source ../../bin/_check-release.sh && \
	source ./_variables.sh             && \
	packer init . && packer build .


.PHONY: build-release
build-release: ## - Packer: build 'PKR_VAR_release' release
	@echo
	source ../../bin/_check-release.sh && \
	source ./_variables.sh             && \
	packer init . && packer build .


validate: ## - Packer: build
	@echo
	source ./_variables.sh && \
	packer init . && packer validate .

.PHONY: debug
debug: ## - Packer: debug (.pem files are locally saved)
	@echo
	source ./_variables.sh && \
	packer init . && packer build -debug . ;

        ## Ref:
        ##   https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs#accessing-the-instance-to-debug


################################################################################
##@ AWS

.PHONY: sg
instance-profile: ## - AWS: create instance-profile
	@echo
	source ./_variables.sh && \
../../bin/iam-packer-instance-profile.sh -y

sg: ## - AWS: create security group
	@echo
	source ./_variables.sh && \
	../../bin/ec2-security-group-create.sh $${PKR_VAR_vpc_id}

sg-del: ## - AWS: delete security group rules
	@echo
	source ./_variables.sh && \
	../../bin/ec2-security-group-delete.sh ec2-packer

ssm: ## - AWS: SSM start session: nginx-blue-green
	@echo
	source ./_variables.sh && \
	../../bin/ssm-start-session.sh packer.httpd-blue-green

ssm-port-forward: ## - AWS: SSM port forward: nginx-blue-green
	@echo
	source ./_variables.sh && \
	../../bin/ssm-port-forward.sh packer.nginx-blue-green


################################################################################
##@ My AMIs


.PHONY: list-ssh-test
list-ssh-test: ## - list of my AMIs
	@echo
	aws ec2 describe-images \
	--filters "Name=name,Values=amzn-ssh-test.*" \
	--query 'Images[][Name,ImageId,OwnerId,CreationDate]' \
	--output text | sort -r | column -t | head -20


################################################################################
##@ Amazon AMIs


.PHONY: list-machine
list-machine: ## - My built machine
	@echo
	aws ec2 describe-images \
	--filters "Name=name,Values=nginx-*.al2023*" \
	--query   'Images[][Name,ImageId,OwnerId,ImageOwnerAlias,CreationDate]' \
	--output text | column -t | sort -k 5 -r
#	--filters "Name=owner-alias,Values=amazon"  \

.PHONY: list-al2023
list-al2023: ## - AMZN: list of 'al2023'
	@echo
	aws ec2 describe-images \
	--filters "Name=name,Values=al2023-ami-2023*" \
	--query   'Images[][Name,ImageId,OwnerId,ImageOwnerAlias,CreationDate]' \
	--output text | column -t | sort
#	--filters "Name=owner-alias,Values=amazon"  \

.PHONY: list-ubuntu
list-ubuntu: ## - AMZN: list of 'ubuntu'
	@echo
	aws ec2 describe-images \
	--filters "Name=name,Values=ubuntu/*24.04*-server-*" \
	--query   'Images[][Name,ImageId,OwnerId,ImageOwnerAlias,CreationDate]' \
	--output text | column -t | sort

.PHONY: list-win
list-win: ## - AMZN: list of 'win'
	@echo
	aws ec2 describe-images \
	--filters "Name=name,Values=Windows_Server-2025*-English*"  \
	--query   'Images[][Name,ImageId,OwnerId,ImageOwnerAlias,CreationDate]' \
	--output text | column -t | sort
