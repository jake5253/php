#!/bin/bash
fn_error () {
    echo -e "ERROR! $1 command failed!"
    exit 1;
}

fn_dircheck () {
    [[ -d /usr/local/bin ]] && echo '/usr/local/bin okay' || mkdir -p /usr/local/bin
    [[ -d /usr/local/lib ]] && echo '/usr/local/lib okay' || mkdir -p /usr/local/lib
    [[ -d /usr/local/src ]] && echo '/usr/local/src okay' || mkdir -p /usr/local/src
    [[ -d /etc/cron.d ]] && echo '/etc/cron.d okay' || mkdir -p /etc/cron.d
}

fn_cron () {
    [[ -e cronjob ]] && echo 'cronjob okay'; cp cronjob /usr/local/bin/cronjob || fn_error 'cp cronjob'
    chmod 0744 /usr/local/bin/cronjob || fn_error 'chmod cronjob'
    [[ -e crontab ]] && echo 'crontab okay'; cp ./crontab /etc/cron.d/weekly-phpupdate || fn_error 'cp crontab'
    chmod 0644 /etc/cron.d/weekly-phpupdate || fn_error 'chmod crontab'
    touch /var/log/cron.log || fn_error 'touch cron.log'
}

fn_phpenmod () {
    [[ -e phpenmod ]] && echo 'phpenmod'; cp ./phpenmod /usr/local/bin/phpenmod || fn_error 'cp phpenmod'
    chmod 0755 /usr/local/bin/phpenmod || fn_error 'chmod phpenmod'
}

fn_phpserv () {
    [[ -e phpserv ]] && echo 'phpserv okay'; cp ./phpserv /usr/local/bin/phpserv || fn_error 'cp phpserv'
    chmod 0755 /usr/local/bin/phpserv || fn_error 'chmod phpserv'
}

fn_dircheck || fn_error 'directory checking';
fn_cron;
fn_phpenmod;
fn_phpserv;
