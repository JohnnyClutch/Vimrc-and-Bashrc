#	This is the default standard profile provided to a user.
#	They are expected to edit it to meet their own needs.

# if [ -f /etc/bashrc ]; then
# . /etc/bashrc
# fi


export DEBUG=
export PATH=:$HOME/bin:$HOME/.rvm/bin:/opt/local/bin:/usr/local/bin:/usr/X11R6/bin/:/bin:/usr/bin:/bin:/usr/local/sbin:/sbin:/usr/local/mysql/bin:/usr/sbin:/Applications/MacVim.app:.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
export MACVIM_APP_DIR=/Applications/MacVim

alias msql='mysql -u gbullock image_hash_cache'
alias rsql='sqlite3 db/development.sqlite3'
alias la='ls -al'
alias maek='make'
alias amke='make'
alias amek='make'
alias md='mkdir'
alias pd='popd'
alias dir='ls -l'
alias dri='ls -l'
alias idr='ls -l'
alias dc='cd'
alias pig='du | sort -r -n | more'
alias dird='ls -lF | grep "^d"'
alias dirp='ls -alFb | more'
alias dirw='ls -CFb | more'
alias h='history | tail -20'
alias where='type'
alias dirt='ls -altb | head -20'
alias job='cls;cd $JOB; dir'
alias r='sudo'
alias ll='ls -l'

#
# functions
#

# PRR = Project root's root
export PRR=~/vooProjects
# PR = Project's root
export PR=~/vooProjects/
# JR = Job root ($PR/app/views)
export JR=~/vooProjects/

cr() { rvm $1; RBV=`ruby -v | egrep -o '[0-9]+\.[0-9]+\.[0-9][a-z]?[0-9]? ' | sed 's/ $//g'`; }
setp() { RBV=`ruby -v | egrep -o '[0-9]+\.[0-9]+\.[0-9][a-z]?[0-9]? ' | sed 's/ $//g'`; }

vw() { cr 1.8.7; export PR=$PRR/Voonami-Web; export JR=$PR/; export JOB=$JR; job; }
sj() { export JOB=$JR/$1; job; }
sjm() { export JOB=$JR/app/models; job; }
sjv() { export JOB=$JR/app/views/$1; job; }
sjc() { export JOB=$JR/app/controllers; job; }
sjh() { export JOB=$JR/app/helpers; job; }
psj() { export JOB=$JR/$1; jp; }

ssm() { export JOB=$JR/vendor/plugins/substruct/app/models; job; }
ssv() { export JOB=$JR/vendor/plugins/substruct/app/views/$1; job; }
ssc() { export JOB=$JR/vendor/plugins/substruct/app/controllers; job; }

fnd() { find ./ -name "$1" -print; }
tiki() { cr 1.8.7; export PR=$PRR/Voonami-Tiki; export JR=$PR/; export JOB=$JR; job; }
angus() { cr 1.9.2; export PR=$PRR/Setpoint-Ammo; export JR=$PR/; export JOB=$JR; job; }

cdr() { cd $PR; }

allgrp() { find ./ -name "*" -exec grep -H $1 "{}" \;; }
jgrp() { find ./ -name "*.java" | grep -v javaSource | xargs grep -H $1; }
rbgrp() {   find ./ -name "*rb" -exec grep -H $1 "{}" \;; }
cgrp() {   find ./ -name "*.c" -exec grep -H $1 "{}" \;; }
cppgrp() { find ./ -name "*.cpp" -exec grep -H $1 "{}" \;; }
hppgrp() { find ./ -name "*.hpp" -exec grep -H $1 "{}" \;; }
hgrp() { find ./ -name "*.h" -exec grep -H $1 "{}" \;; }
htmgrp() { find ./ -name "*\.htm?" -exec grep -Hi $1 "{}" \;; }
cssgrp() { find ./ -name "*\.css" -exec grep -Hi $1 "{}" \;; }
jsgrp() { find ./ -name "*\.js" -exec grep -Hi $1 "{}" \;; }
grp() { rbgrp $1; }

allgrpl() { find ./ -name "*" -exec grep -l $1 "{}" \;; }
rbgrpl() {   find ./ -name "*rb" -exec grep -l $1 "{}" \;; }
cgrpl() {   find ./ -name "*.c" -exec grep -l $1 "{}" \;; }
ppgrpl() { find ./ -name "*pp" -exec grep -l $1 "{}" \;; }
cppgrpl() { find ./ -name "*.cpp" -exec grep -l $1 "{}" \;; }
hppgrpl() { find ./ -name "*.hpp" -exec grep -l $1 "{}" \;; }
jgrpl() { find ./ -name "*.java" -exec grep -l $1 "{}" \;; }
hgrpl() { find ./ -name "*.h" -exec grep -l $1 "{}" \;; }
grpl() { rbgrpl $1; }

allgrpi() { find ./ -name "*" -exec grep -Hi $1 "{}" \;; }
rbgrpi() {   find ./ -name "*rb" -exec grep -Hi $1 "{}" \;; }
cgrpi() {   find ./ -name "*.c" -exec grep -Hi $1 "{}" \;; }
ppgrpi() { find ./ -name "*pp" -exec grep -Hi $1 "{}" \;; }
cppgrpi() { find ./ -name "*.cpp" -exec grep -Hi $1 "{}" \;; }
hppgrpi() { find ./ -name "*.hpp" -exec grep -Hi $1 "{}" \;; }
jgrpi() { find ./ -name "*.java" -exec grep -Hi $1 "{}" \;; }
hgrpi() { find ./ -name "*.h" -exec grep -Hi $1 "{}" \;; }
grpi() { rbgrpi $1; }

allgrpli() { find ./ -name "*" -exec grep -li $1 "{}" \;; }
rbgrpli() {   find ./ -name "*rb" -exec grep -li $1 "{}" \;; }
cgrpli() {   find ./ -name "*.c" -exec grep -li $1 "{}" \;; }
ppgrpli() { find ./ -name "*pp" -exec grep -li $1 "{}" \;; }
cppgrpli() { find ./ -name "*.cpp" -exec grep -li $1 "{}" \;; }
hppgrpli() { find ./ -name "*.hpp" -exec grep -li $1 "{}" \;; }
jgrpli() { find ./ -name "*.java" -exec grep -li $1 "{}" \;; }
hgrpli() { find ./ -name "*.h" -exec grep -li $1 "{}" \;; }
grpli() { rbgrpli $1; }

#
# Set prompt
#
if test X$LOGNAME != X; then
    export USER=$LOGNAME
fi
HOSTNAME=`hostname | cut -d. -f1`
rvm 1.9.2
MYID=`id -u -n`
RBV=`ruby -v | egrep -o '[0-9]+\.[0-9]+\.[0-9][a-z]?[0-9]? ' | sed 's/ $//g'`
PS1="\${MYID}@\${HOSTNAME} (\${RBV}) \${PWD}>"
export PS1

#
# Other stuff
#
set -o vi
umask 006
set bell-style=visible

