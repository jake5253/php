#!/bin/bash
fn_error () {
    echo "ERROR! $1 command failed!";
    exit 1;
}

fn_dircheck () {
    [[ ! -d /usr/local/bin/ ]] && mkdir -p /usr/local/bin || fn_error 'mkdir bin'
    [[ ! -d /usr/local/lib/ ]] && mkdir -p /usr/local/lib || fn_error 'mkdir lib'
    [[ ! -d /usr/local/src/ ]] && mkdir -p /usr/local/src || fn_error 'mkdir src'
}

fn_cron () {
    cp ./cronjob /usr/local/bin/cronjob || fn_error 'cp cronjob'
    chmod 0744 /usr/local/bin/cronjob || fn_error 'chmod cronjob'
    cp ./crontab /etc/cron.d/weekly-phpupdate || fn_error 'cp crontab'
    chmod 0644 /etc/cron.d/weekly-phpupdate || fn_error 'chmod crontab'
    touch /var/log/cron.log || fn_error 'touch cron.log'
}

fn_phpenmod () {
    cp ./phpenmod /usr/local/bin/phpenmod || fn_error 'cp phpenmod'
    chmod 0755 /usr/local/bin/phpenmod || fn_error 'chmod phpenmod'
}

fn_phpserv () {
    cp ./phpserv /usr/local/bin/phpserv || fn_error 'cp phpserv'
    chmod 0755 /usr/local/bin/phpserv || fn_error 'chmod phpserv'
}

fn_dircheck;
fn_cron;
fn_phpenmod;
fn_phpserv;
