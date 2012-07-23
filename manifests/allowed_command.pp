define sudoers::allowed_command(
  $command,
  $filename         = $title,
  $host             = "ALL",
  $run_as           = "root",
  $user             = undef,
  $group            = undef,
  $require_password = true,
  $comment          = undef,
  $allowed_env_variables = []
) {
  if ($user == undef and $group == undef) {
    fail("must define user or group")
  }

  $nopasswd = $require_password ? {
    true => "",
    false => " NOPASSWD:"
  }

  $user_spec = $group ? {
    undef => $user,
    default => "%${group}"
  }

  $require_spec = $group ? {
    undef => $user ? { 'ALL' => undef, default => User[$user] },
    default => Group[$group]
  }


  file { "/etc/sudoers.d/${filename}":
    ensure => file,
    content => validate(template("sudoers/allowed-command.erb"), "/usr/sbin/visudo -cq -f"),
    mode => "440", owner => root, group => root,
    require => $require_spec
  }
}
