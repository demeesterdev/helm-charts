# lldap

<!-- The contents of this file is generated directly from the chart's values.yaml,
please make any edits there -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: v0.5.0](https://img.shields.io/badge/AppVersion-v0.5.0-informational?style=flat-square)

lldap is a Light LDAP implementation for authentication

This reference was generated for the chart version 0.1.0 which installs lldap v0.5.0.

<!-- markdownlint-disable -->

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| externalMariadb | object | `{"auth":{"database":"lldap","host":"","password":"","port":3306,"username":""},"enabled":false}` | Enable and configure external mariadb database |
| externalPostgresql | object | `{"auth":{"database":"lldap","host":"","password":"","port":5432,"username":""},"enabled":false}` | - Enable and configure external postgresql database |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"lldap/lldap"` | image repository |
| image.tag | string | chart.appVersion | image tag |
| imagePullSecrets | list | `[]` |  |
| ingress | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| lldap.extraVolumeMounts | list | `[]` |  |
| lldap.extraVolumes | list | `[]` | - define extra volumes and mounts for the ldap |
| lldap.gid | int | `1001` |  |
| lldap.jwtSecret | string | generates a 64 long alphanumeric string | Random secret for JWT signature. This secret should be random, and should be shared with application servers that need to consume the JWTs. Changing this secret will invalidate all user sessions and require them to re-login. |
| lldap.keySeed | string | generates a 64 long alphanumeric string | Seed to generate the server private key. This can be any random string, the recommendation is that it's at least 12 characters long. |
| lldap.ldapBaseDomain | string | `"dc=example,dc=com"` | Base DN for LDAP. This is usually your domain name, and is used as a namespace for your users. The choice is arbitrary, but will be needed to configure the LDAP integration with other services. The sample value is for "example.com", but you can extend it with as many "dc" as you want, and you don't actually need to own the domain name. |
| lldap.ldapUser | object | `{"email":null,"existingSecret":{"name":null},"ldapAdminForceReset":false,"secretName":null,"username":"admin"}` | LDAP admin user. For the LDAP interface. |
| lldap.ldapUser.email | string | `nil` | The email of the admin user. |
| lldap.ldapUser.existingSecret.name | string | `nil` | Existing secret containing the admin credentials If set, the admin user will be created using the values in the secret expects the keys "username", "password" |
| lldap.ldapUser.secretName | string | <release-name>-user | The secret to store the admin credentials in existingSecret will overrule this value |
| lldap.ldapUser.username | string | `"admin"` | The username of the admin user. a value of "admin" here will create the LDAP user "cn=admin,ou=people,dc=example,dc=com" (with ldapBaseDomain above). For the administration interface, this is the username. |
| lldap.ldaps | object | see below | Options to configure LDAPS |
| lldap.ldaps.secret.certKey | string | `"tls.crt"` | The key in the secret containing the certificate |
| lldap.ldaps.secret.keyKey | string | `"tls.key"` | The key in the secret containing the key |
| lldap.ldaps.secret.name | string | `nil` | The secret containing the certificate and key for the ldaps service |
| lldap.smtp | object | see below | Options to configure SMTP parameters ti sebd oasswird reset emails |
| lldap.smtp.enablePasswordReset | bool | `false` | Whether to enabled password reset via email, from LLDAP. |
| lldap.smtp.encryption | string | `"TLS"` | SMTP encryption type. valid values are "NONE" (no encryption), "TLS" or "STARTTLS" |
| lldap.smtp.from | object | `{"email":null,"name":""}` | The header field, optional: how the sender appears in the email. |
| lldap.smtp.port | string | `""` | SMTP port. |
| lldap.smtp.replyTo | object | `{"email":null,"name":""}` | The reply-to field, optional: where to send replies to. If not set, the from field is used (if set). |
| lldap.smtp.server | string | `""` | SMTP server. |
| lldap.smtp.user | object | `{"existingSecret":{"name":null},"password":"","secretName":"","username":""}` | SMTP user. |
| lldap.smtp.user.existingSecret.name | string | `nil` | Existing secret containing the admin credentials If set, the admin user will be created using the values in the secret expects the keys "username", "password" |
| lldap.smtp.user.password | string | `""` | The password of the smtp user. |
| lldap.smtp.user.secretName | string | <release-name>-user | The secret to store the smtp credentials in existingSecret will overrule this value |
| lldap.smtp.user.username | string | `""` | The SMPT user, usually your email address. |
| lldap.tz | string | `"Etc/UTC"` |  |
| lldap.uid | int | `1001` |  |
| lldap.verbose | bool | `false` | Tune the logging to be more verbose |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence | object | see values.yaml | Persistence is only required if you are using the SQLite database (default). You can disable persistence if you select MariaDB or PostgreSQL. |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| replicaCount | int | `1` | Number of lldap replicas. Do not increase this above 1 if you are using the SQLite backend. |
| resources | object | `{}` |  |
| securityContext | string | `nil` |  |
| service | object | See values.yaml | Configures service settings for the chart. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | If not set and create is true, a name is generated using the fullname template | The name of the service account to use. |
| tolerations | list | `[]` |  |

<!-- markdownlint-enable -->

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
