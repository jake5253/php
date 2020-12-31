#!/bin/bash
fn_error () {
    echo "ERROR! $0 command failed!";
    exit 1;
}

fn_dircheck () {
    [[ ! -d /usr/local/bin/ ]] && mkdir -p -m 0755 /usr/local/bin || fn_error
    [[ ! -d /usr/local/lib/ ]] && mkdir -p -m 0755 /usr/local/lib || fn_error
    [[ ! -d /usr/local/src/ ]] && mkdir -p -m 0755 /usr/local/src || fn_error
}

fn_cron () {
    cp ./cronjob /usr/local/bin/cronjob || fn_error
    chmod 0744 /usr/local/bin/cronjob || fn_error
    cp ./crontab /etc/cron.d/weekly-phpupdate || fn_error
    chmod 0644 /etc/cron.d/weekly-phpupdate || fn_error
    touch /var/log/cron.log;
}

fn_phpenmod () {
    cp ./phpenmod /usr/local/bin/phpenmod || fn_error
    chmod 0755 /usr/local/bin/phpenmod || fn_error
}

fn_phpserv () {
    cp ./phpserv /usr/local/bin/phpserv || fn_error
    chmod 0755 /usr/local/bin/phpserv || fn_error
}

fn_dircheck;
fn_cron;
fn_phpenmod;
fn_phpserv;
