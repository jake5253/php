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
    cp ./cronjob /usr/bin/cronjob || fn_error 'cp cronjob'
    chmod 0744 /usr/bin/cronjob || fn_error 'chmod cronjob'
    cp ./crontab /etc/cron.d/weekly-phpupdate || fn_error 'cp crontab'
    chmod 0644 /etc/cron.d/weekly-phpupdate || fn_error 'chmod crontab'
    touch /var/log/cron.log || fn_error 'touch cron.log'
}

fn_phpenmod () {
    cp ./phpenmod /usr/bin/phpenmod || fn_error 'cp phpenmod'
    chmod 0755 /usr/bin/phpenmod || fn_error 'chmod phpenmod'
}

fn_phpserv () {
    cp ./phpserv /usr/bin/phpserv || fn_error 'cp phpserv'
    chmod 0755 /usr/bin/phpserv || fn_error 'chmod phpserv'
}

fn_dircheck || fn_error 'directory checking';
fn_cron;
fn_phpenmod;
fn_phpserv;
