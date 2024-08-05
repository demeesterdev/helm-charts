{{/*
Expand the name of the chart.
*/}}
{{- define "lldap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lldap.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lldap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lldap.labels" -}}
helm.sh/chart: {{ include "lldap.chart" . }}
{{ include "lldap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lldap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lldap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lldap.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lldap.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Build the connectionstring being used to connect to the backend
*/}}
{{- define "lldap.externalPostgresConnectString" -}}
postgres://{{- .Values.externalPostgresql.auth.username -}}:{{- .Values.externalPostgresql.auth.password -}}@{{- .Values.externalPostgresql.auth.host -}}:{{- .Values.externalPostgresql.auth.port -}}/{{- .Values.externalPostgresql.auth.database -}}
{{- end }}
{{- define "lldap.externalMariadbConnectString" -}}
mysql://{{- .Values.externalMariadb.auth.username -}}:{{- .Values.externalMariadb.auth.password -}}@{{- .Values.externalMariadb.auth.host -}}:{{- .Values.externalMariadb.auth.port -}}/{{- .Values.externalMariadb.auth.database -}}
{{- end }}

{{- define "lldap.databaseURL" -}}
{{- if .Values.externalPostgresql.enabled -}}
{{- include "lldap.postgresConnectString" . -}}
{{- else if .Values.externalMariadb.enabled -}}
{{- include "lldap.mariadbConnectString" . -}}
{{- else -}}
sqlite:///data/users.db?mode=rwc
{{- end -}}
{{- end }}



{{/*
Build the secret references
*/}}
{{- define "lldap.ldapConfigSecretName" }}
{{- printf "%s-config" (include "lldap.fullname" . ) }}
{{- end }}

{{- define "lldap.ldapUserSecretName" }}
{{- if .Values.lldap.ldapUser.existingSecret.name }}
{{- .Values.lldap.ldapUser.existingSecret.name }}
{{- else if .Values.lldap.ldapUser.secretName -}}
{{- .Values.lldap.ldapUser.secretName }}
{{- else }}
{{- printf "%s-user" (include "lldap.fullname" . ) -}}
{{- end }}
{{- end }}

{{- define "lldap.smtpUserSecretName" }}
{{- if .Values.lldap.smtp.user.existingSecret.name }}
{{- .Values.lldap.smtp.user.existingSecret.name }}
{{- else if .Values.lldap.smtp.user.secretName -}}
{{- .Values.lldap.smtp.user.secretName }}
{{- else }}
{{- printf "%s-user" (include "lldap.fullname" . ) -}}
{{- end }}
{{- end }}

{{- define "lldap.smtpFromString" }}
{{- .Values.lldap.smtp.from.name -}}
{{- printf " <%s>" .Values.lldap.smtp.from.email -}}
{{- end }}

{{- define "lldap.smtpReplyToString" }}
{{- .Values.lldap.smtp.replyTo.name -}}
{{- printf " <%s>" .Values.lldap.smtp.replyTo.email -}}
{{- end }}
