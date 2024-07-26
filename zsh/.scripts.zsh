#!/usr/bin/env zsh

export LANG=en_US.UTF-8
export EDITOR="nvim"
export ZVM_VI_EDITOR="$EDITOR"
# export NVIM_APPNAME='astronvim_v4'

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias n="nvim"
alias c='code'
alias py="python3"
alias pn="pnpm"

alias psleep="sudo pmset -b disablesleep 1"
alias asleep="sudo pmset -b disablesleep 0"

alias get_ip="curl https://api.ipify.org -s"
alias enc="openssl aes-256-cbc -pbkdf2 -in"

alias http="py -m http.server 80"
alias table="py -c 'import json, sys, tabulate as t; print(t.tabulate(json.loads(sys.stdin.read()), headers=\"keys\", tablefmt=\"fancy_grid\"))'"

alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"

alias sch=$'perl -F, -lane \'$F[7]=~s/.*(Üyesi |\\. )//;print join ",",@F[1..7]\' < ~/schedule.csv | tabulate -1s,'
alias schz=$'awk -F, \'$7=="Online"{printf "%s - [%s]\\n",$3,$9}\' < ~/schedule.csv|fzf --preview \'yq -oj ".[]|select(.ZOOM==\\"$(perl -lne "/\\d\\{10,11}/&&print $&"<<<{})\\")" ~/schedule.csv|bat --color=always -ljson --style=plain\' --height 50% --reverse --preview-window 70%|perl -lne \'/\\d{10,11}/&&print "https://app.zoom.us/wc/$&/join"\'|xargs open'

alias otp='totp-cli list personal 2>/dev/null| sed "s/.*\\.//" | fzf --preview "totp-cli g personal {} 2>/dev/null" | xargs -I {} sh -c "totp-cli g personal {}" 2> /dev/null | pbcopy'

alias ls="eza --icons --git"
alias lt='eza --icons --git --tree --level=2'

alias bat='bat --style="full"'
alias bm="batman"

# Google Forms
# time seq 97 | parallel -n0 --bar -j60 "curl --cookie 'COOKIES' -d 'FORM DATA' https://docs.google.com/forms/d/e/FORMS URL/formResponse -s" > /dev/null

alias deprem="curl http://www.koeri.boun.edu.tr/scripts/lst7.asp -s | xmllint --html --xpath '//pre/text()' -  --noout 2>/dev/null | awk '/^[0-9]/ {split(\$9, a, \"-\"); city=\$10 ~ /^\(/ ? \$10:a[2] ~ /^\(/ ? a[2]:\"\"  ; printf \"%s-%s\t%-10s%s km\t%-30s%s \n\", \$1,\$2,\$7,\$5,\$9,substr(city, 2, length(city)-2)}' | tail -r | tail -n"
alias sozluk="curl https://sozluk.gov.tr/autocomplete.json -s | jq '.[]|.madde' -r | fzf --preview 'curl -G https://sozluk.gov.tr/gts --data-urlencode 'ara={}' -s | jq | bat --color=always -ljson' --preview-window '70%:wrap'"

# bindkey "^ " _expand_alias
bindkey "¬" _expand_alias
bindkey '^Xh' _complete_help

lf() {
    export LF_CD_FILE=/var/tmp/.lfcd-$$
    command lf $@
    if [ -s "$LF_CD_FILE" ]; then
        local DIR="$(realpath "$(cat "$LF_CD_FILE")")"
        if [ "$DIR" != "$PWD" ]; then
            echo "cd to $DIR"
            cd "$DIR"
        fi
        /bin/rm "$LF_CD_FILE"
    fi
    unset LF_CD_FILE
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function oui() {
	jq '.data["'`perl -nE 'say substr lc(join"",/[0-9A-f]/g),0,6'<<<$1`'"]' ~/WorkDir/security/oui.json
}

# Some Functions
ipinfo() {
	local pattrn='((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}'
	local ip=$(echo $@ | perl -ne "/$pattrn/ && print $&")
	local args=($(echo $@ | perl -pe "s/$pattrn//"))

	[[ "$ip" = "" ]] && ip=`get_ip`
	curl https://ipinfo.io/widget/demo/$ip -H 'Referer: https://ipinfo.io/' -s | jq $args
}

ipdata() {
	local pattrn='((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}'
	local ip=$(echo $@ | perl -ne "/$pattrn/ && print $&")
	local args=($(echo $@ | perl -pe "s/$pattrn//"))
	local token=`curl https://ipdata.co -s | perl -ne 's/.*([0-f]{56}).*/$1/&&print'`

	curl "https://api.ipdata.co/$ip?api-key=$token" -s | jq $args
}

quake() {
	[ -z "$1" ] && 1=10;
	out=$(curl http://www.koeri.boun.edu.tr/scripts/lst7.asp -s |\
		xmllint --html --xpath '//pre/text()' -  --noout 2>/dev/null |\
		gawk -F' {2,}' '/^[0-9]/{match($8,/(.+)[ -]\((.+)\)|(.+)/,l);printf "%s,%s,%s km,%s,%s,\n", $1,$6,$4,l[1]==""?$8:l[1],l[2]}' |\
		sed 's/ /-/' | tail -r | tail -n $1)

	[[ "$2" = raw ]] && echo $out || echo $out | column -t -s,
}

quake_afad() {
	[ -z "$1" ] && 1=10;
	out=$(curl https://deprem.afad.gov.tr/last-earthquakes.html -s |\
		perl -ne 'm/<table.+<\/table>/;print $&' |\
		xml sel -t -m '//table/tbody/tr' -v 'td[1]' -o $'\t' \
			-v 'td[6]' -o $'\t' \
			-v 'td[4]' -o $'\t' \
			-v 'td[7]' -o $'\t' -n |\
		perl -pe 's/(\d\d)-(\d\d)-/\1.\2./;s/ (?=\d\d:)/-/;s/\t/,/g;s/ \((.+)\)/,\1/;' |\
		awk -F, 'OFS=","{$3=$3" km";print $0}' |\
		# perl -F, -ape '@F[2]="$F[2] km"; $_=join ",", @F' |\
		tail -r | tail -n $1)

	[[ "$2" = raw ]] && echo $out || echo $out | column -t -s,
}

alert(){
	[ -z "$1" ] && 1=10;
	afplay -v $1 /System/Library/PrivateFrameworks/ScreenReader.framework/Versions/A/Resources/Sounds/Alert.aiff
}

get_email() {
	[[ -z "$1" ]] && echo "Please select source (temp_info/temp_org/guerrilla/generator)" && return
	[[ "$1" = temp_info ]] && curl https://temp-email.info/ -s | sed -n "s/.*const email = '\(.*\)';/\1/p"
	[[ "$1" = guerrilla ]] && curl https://www.guerrillamail.com/ -s | xmllint --html --xpath '//span[@id="email-widget"]/text()' - 2> /dev/null
	[[ "$1" = generator ]] && curl https://generator.email/ -s | xmllint --html --xpath '//span[@id="email_ch_text"]/text()' - 2> /dev/null
	[[ "$1" = temp_org ]] && curl https://web2.temp-mail.org/mailbox -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/115.0' -d '' -s | jq .mailbox
} 

stopwatch() {
	start_time=$(date +%s)

	while true; do
		elapsed_time=$((`date +%s` - start_time))
		formatted_time=$(date -v0H -v0M -v0S -v+"$elapsed_time"S)
		output=$(eval "$@")

		[[ $(printf $output 2>/dev/null| pcregrep -Mc '\n') > 0 ]] && printf "\e[2J\e[H"

		printf "\r%s" "$formatted_time: $output" 
		sleep 1
	done
}

html2table(){
	[[ ! $1 =~ '^[0-9]+$' ]] && 1=''
    py -c "import pandas as pd;import sys;d=pd.read_html(sys.stdin.read())[1].iloc[:,:$1];print(d.to_csv())"
}

function nv() {
  items=("default" "NvChad" "AstroNvim" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
