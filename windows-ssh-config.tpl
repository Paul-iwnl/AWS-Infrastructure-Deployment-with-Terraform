Add-Content -Path "$env:USERPROFILE/.ssh/config" -Value @'
Host ${hostname}
    Hostname ${hostname}
    User ${user}
    IdentityFile ${identityfile}
'@
