class openldap::scripts(
    $openldap_admin_pwd = '',
){
    package { 'pwgen':
        ensure => present,
    }

    exec { '/usr/local/sbin/gitlab_fetch_folder -u root -g root -m 755 -o /usr/local/sbin minions/openldap/generic':
        unless  =>  '/usr/local/sbin/gitlab_fetch_folder -d -u root -g root -m 755 -o /usr/local/sbin minions/openldap/generic > /dev/null 2>&1',
        require => File['/root/.openldap'],
    }

    file { '/root/.openldap':
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => "${openldap_admin_pwd}",
        require => Package['pwgen'],
    }
}
